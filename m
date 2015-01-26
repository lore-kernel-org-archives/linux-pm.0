From: Rafael David Tinoco <inaddy@ubuntu.com>
Subject: HP Proliant Servers + intel_idle = NMI on MWAIT instructions
Date: Mon, 26 Jan 2015 10:45:09 -0200
Message-ID: <CAMiJ5CVVYAk68KwSD081hrROXzqOpse4xLtvYXy4iGCejjN=2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Len and others,

Over the past few months I've been given several core dumps related to
NMIs occurring in HP Proliant DL360 and DL380 servers and kernels 3.11
and 3.13. I'd like to share what I'm seeing and to ask feedback
regarding this. It looks like HP Proliant servers are deeply based in
ACPI C-states table for their power management and, with intel_idle
ignoring those tables, they can't proper handle MWAIT instructions
generated from intel_idle (if I'm interpreting this correctly).

One of the stack traces (3.11.0-19):

crash> bt

PID: 0 TASK: ffffffff81c14440 CPU: 0 COMMAND: "swapper/0"
#0 [ffff880fffa07c40] machine_kexec at ffffffff8104b391
#1 [ffff880fffa07cb0] crash_kexec at ffffffff810d5fb8
#2 [ffff880fffa07d80] panic at ffffffff81730335
#3 [ffff880fffa07e00] hpwdt_pretimeout at ffffffffa00988b5 [hpwdt]
#4 [ffff880fffa07e20] nmi_handle at ffffffff8174a76a
#5 [ffff880fffa07ea0] default_do_nmi at ffffffff8174aacd
#6 [ffff880fffa07ed0] do_nmi at ffffffff8174abe0
#7 [ffff880fffa07ef0] end_repeat_nmi at ffffffff81749c81
[exception RIP: intel_idle+204]
--- <NMI exception stack> ---
#8 [ffffffff81c01d88] intel_idle at ffffffff813f07ec
#9 [ffffffff81c01dc0] cpuidle_enter_state at ffffffff815e76cf
#10 [ffffffff81c01e20] cpuidle_idle_call at ffffffff815e7820
#11 [ffffffff81c01e70] arch_cpu_idle at ffffffff8101d0ee
#12 [ffffffff81c01e80] cpu_idle_loop at ffffffff810baae8
#13 [ffffffff81c01ef0] cpu_startup_entry at ffffffff810bad1b
#14 [ffffffff81c01f10] rest_init at ffffffff81725787
#15 [ffffffff81c01f20] start_kernel at ffffffff81d26f23

There was a NMI right after the following instruction:

369 if (!need_resched())

0xffffffff813f07e0 <+192>: test $0x8,%al
0xffffffff813f07e2 <+194>: jne 0xffffffff813f07ec <intel_idle+204>
0xffffffff813f07e9 <+201>: mwait %rax,%rcx

370 __mwait(eax, ecx);

It looks like that right after MWAIT instructions those servers are
generating NMIs.

Registers from exception stack:

#7 [ffff880fffa07ef0] end_repeat_nmi at ffffffff81749c81
   [exception RIP: intel_idle+204]
   RIP: ffffffff813f07ec  RSP: ffffffff81c01d88  RFLAGS: 00000046
   RAX: 0000000000000010  RBX: 0000000000000010  RCX: 0000000000000046
   RDX: ffffffff81c01d88  RSI: 0000000000000018  RDI: 0000000000000001
   RBP: ffffffff813f07ec   R8: ffffffff813f07ec   R9: 0000000000000018
   R10: ffffffff81c01d88  R11: 0000000000000046  R12: ffffffffffffffff
   R13: 0000000000000000  R14: ffffffff81c01fd8  R15: 0000000000000000
   ORIG_RAX: 0000000000000000  CS: 0010  SS: 0018

--- <NMI exception stack> ---

AND the following piece of code:

#8 [ffffffff81c01d88] intel_idle at ffffffff813f07ec

364                     if (this_cpu_has(X86_FEATURE_CLFLUSH_MONITOR))

  0xffffffff813f07b9 <+153>:   and    $0x1,%edx
  0xffffffff813f07bc <+156>:   jne    0xffffffff813f0820 <intel_idle+256>

365                             clflush((void *)&current_thread_info()->flags);
366
367                     __monitor((void *)&current_thread_info()->flags, 0, 0);

  0xffffffff813f07cc <+172>:   lea    -0x1fc8(%rsi),%rax
  0xffffffff813f07d3 <+179>:   monitor %rax,%rcx,%rdx
...

368                     smp_mb();

  0xffffffff813f07d6 <+182>:   mfence

369                     if (!need_resched())

  0xffffffff813f07e0 <+192>:   test   $0x8,%al
  0xffffffff813f07e2 <+194>:   jne    0xffffffff813f07ec <intel_idle+204>

370                             __mwait(eax, ecx);

  0xffffffff813f07e9 <+201>:   mwait  %rax,%rcx

Suggests that MONITOR instruction was possibly called with following args:

MONITOR 00000010 00000046 ffffffff81c01d88

and MWAIT instruction was called with the following args:

MWAIT 00000010 00000046

What would be weird and would cause a #GP (and not a NMI) since ECX would have
reserved bits set (Intel's software developer manual MWAIT instruction).

Concluding that maybe the exception stack was overlapped.

I found some exception stacks that looked like more real... between
several exceptions
(from intel_idle + 204) I found the following:

  KERNEL-MODE EXCEPTION FRAME AT: ffff880fffa07ef8
    [exception RIP: intel_idle+204]
    RIP: ffffffff813f07ec  RSP: ffffffff81c01d88  RFLAGS: 00000046
    RAX: 0000000000000001  RBX: 0000000000000002  RCX: 0000000000000001
    RDX: 0000000000000000  RSI: ffffffff81c01fd8  RDI: 0000000000000000
    RBP: ffffffff81c01db8   R8: 000000000000007d   R9: 0000000000000b64
    R10: 0000000000000079  R11: 0000000000000000  R12: 0000000000000002
    R13: 0000000000000001  R14: 0000000000000001  R15: 0000000000000002
    ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018

And this is correct according to ASM code (from intel_idle):

mov    0x48(%rsi,%rax,8),%eax                          # store *(rsi +
72 + (rax * 8)) into eax

 # 72 = 24 from struct cpuidle_driver.cpuidle_state + 48 from
cpuidle_state.flags
0xffffffff813f075a <+58>:    mov    %eax,%r13d   # store eax into r13d
(*drv ptr)
0xffffffff813f075d <+61>:    shr    $0x18,%r13d    # shift 24 bits
from r13d (flg2MWAIT MACRO)

And from:

0xffffffff813f07e2 <+194>:   jne    0xffffffff813f07ec <intel_idle+204>
0xffffffff813f07e4 <+196>:   mov    $0x1,%cl
0xffffffff813f07e6 <+198>:   mov    %r13,%rax
0xffffffff813f07e9 <+201>:   mwait  %rax,%rcx

RAX == R13 == 0x01

So for this case I would have state C1E-IVB :

struct cpuidle_driver {
  name = 0xffffffff81b731ad "intel_idle",
  owner = 0x0,
  refcnt = 0,
  bctimer = 0,
...

{
      name = "C1E-IVB\000\000\000\000\000\000\000\000",
      desc = "MWAIT
0x01\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000",
      flags = 16777217,
      exit_latency = 10,
      power_usage = 0,
      target_residency = 20,
      disabled = false,
      enter = 0xffffffff813f0720 <intel_idle>,
      enter_dead = 0
    },

and for the weird NMI exception frames:

KERNEL-MODE EXCEPTION FRAME AT: ffff880fffa07f58
    [exception RIP: intel_idle+204]
    RIP: ffffffff813f07ec  RSP: ffffffff81c01d88  RFLAGS: 00000046
    RAX: 0000000000000010  RBX: 0000000000000010  RCX: 0000000000000046
    RDX: ffffffff81c01d88  RSI: 0000000000000018  RDI: 0000000000000001
    RBP: ffffffff813f07ec   R8: ffffffff813f07ec   R9: 0000000000000018
    R10: ffffffff81c01d88  R11: 0000000000000046  R12: ffffffffffffffff
    R13: 0000000000000000  R14: ffffffff81c01fd8  R15: 0000000000000000
    ORIG_RAX: 0000000000000000  CS: 0010  SS: 0018

RAX = 0x10 would be:

{
      name = "C3-IVB\000\000\000\000\000\000\000\000\000",
      desc = "MWAIT
0x10\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000",
      flags = 268500993,
      exit_latency = 59,
      power_usage = 0,
      target_residency = 156,
      disabled = false,
      enter = 0xffffffff813f0720 <intel_idle>,
      enter_dead = 0
    }

with a "impossible" RCX of 0x46 (should have caused a GP by the
manual) -> Don't think MWAIT changed
ECX value and not sure how to interpret this 0x46 ECX here.

Anyway, I got feedback saying that disabling intel_idle
(intel_idle.max_cstate=0) made the NMIs to go away.
With these cores (and their NMIs exception frames) it looks like NMIs
are coming from C1E and C3 states (and
not only from deeper c-state MWAIT instructions).

What might be happening here ? Why could HP's firmware be generating
NMIs for MWAIT instructions since
all possible MWAIT flags (EAX, ECX) are get by intel_idle code using
CPUID instruction ?

Thanks in advance

Rafael Tinoco
