// frontend/src/components/BottomInputBar.tsx
import React from "react";

interface BottomInputBarProps {
  handleSubmit: (input: string, effort: string, model: string) => void;
  isLoading: boolean;
  onCancel: () => void;
}

export const BottomInputBar: React.FC<BottomInputBarProps> = ({
  handleSubmit,
  isLoading,
  onCancel,
}) => {
  const [input, setInput] = React.useState("");
  // eslint-disable-next-line @typescript-eslint/no-unused-vars
  const [effort, setEffort] = React.useState("medium");
// eslint-disable-next-line @typescript-eslint/no-unused-vars
  const [model, setModel] = React.useState("gpt-4");

  const onFormSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    handleSubmit(input, effort, model);
    setInput("");
  };

  return (
    <form onSubmit={onFormSubmit} className="flex gap-2">
      <input
        className="flex-1 p-2 rounded bg-neutral-700 text-white"
        placeholder="Enter your prompt..."
        value={input}
        onChange={(e) => setInput(e.target.value)}
        disabled={isLoading}
      />
      <button
        type="submit"
        className="bg-blue-600 px-4 py-2 rounded disabled:opacity-50"
        disabled={isLoading}
      >
        {isLoading ? "Running..." : "Submit"}
      </button>
      <button
        type="button"
        className="bg-red-600 px-4 py-2 rounded"
        onClick={onCancel}
      >
        Cancel
      </button>
    </form>
  );
};