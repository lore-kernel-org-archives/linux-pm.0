From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 2/2] kprobes: check CONFIG_FREEZER instead of
	CONFIG_PM
Date: Tue, 10 Feb 2009 13:37:34 +0100
Message-ID: <20090210123734.GB21531__30495.5451553271$1234269609$gmane$org@elte.hu>
References: <200901062112.29227.rjw@sisk.pl> <200901062115.33286.rjw@sisk.pl>
	<20090107121659.GA16268@elte.hu>
	<alpine.LFD.2.00.0901091530090.16697@localhost.localdomain>
	<20090210010546.GA28129@elte.hu> <49909764.3020303@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <49909764.3020303@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Masami Hiramatsu <mhiramat@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@suse.cz>, Cheng Renquan <crquan@gmail.com>, pm list <linux-pm@lists.linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org


* Masami Hiramatsu <mhiramat@redhat.com> wrote:

> Ingo Molnar wrote:
>> * Len Brown <lenb@kernel.org> wrote:
>>
>>>>> Check CONFIG_FREEZER instead of CONFIG_PM because kprobe booster
>>>>> depends on freeze_processes() and thaw_processes() when CONFIG_PREEMPT=y.
>>>>>
>>>>> This fixes a linkage error which occurs when CONFIG_PREEMPT=y, CONFIG_PM=y
>>>>> and CONFIG_FREEZER=n.
>>>>>
>>>>> Reported-by: Cheng Renquan <crquan@gmail.com>
>>>>> Signed-off-by: Masami Hiramatsu <mhiramat@redhat.com>
>>>>> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
>>>>> ---
>>>>>  arch/ia64/kernel/kprobes.c |    2 +-
>>>>>  arch/x86/kernel/kprobes.c  |    2 +-
>>>>>  kernel/kprobes.c           |    2 +-
>>>>>  3 files changed, 3 insertions(+), 3 deletions(-)
>>>> looks good, the x86 bits:
>>>>
>>>> Acked-by: Ingo Molnar <mingo@elte.hu>
>>> man, we have too many config options:-)
>>
>> the non-x86 bits (kernel/kprobes.c) are crappy though, and broke -rc4
>> allnoconfig:
>>
>> kernel/built-in.o: In function `collect_garbage_slots':
>> kprobes.c:(.kprobes.text+0x16e4): undefined reference to `freeze_processes'
>> kprobes.c:(.kprobes.text+0x16f2): undefined reference to `thaw_processes'
>> kprobes.c:(.kprobes.text+0x176b): undefined reference to `thaw_processes'
>
> Hmm, it seems that kernel/power/built-in.o was not linked to .tmp_vmlinux1.
>
>   ld -m elf_i386 --build-id -o .tmp_vmlinux1 -T arch/x86/kernel/vmlinux.lds
> arch/x86/kernel/head_32.o arch/x86/kernel/head32.o arch/x86/kernel/head.o
> arch/x86/kernel/init_task.o  init/built-in.o --start-group  usr/built-in.o
> arch/x86/kernel/built-in.o  arch/x86/mm/built-in.o  arch/x86/mach-default/built-in.o
> arch/x86/crypto/built-in.o  arch/x86/vdso/built-in.o  kernel/built-in.o
> mm/built-in.o  fs/built-in.o  ipc/built-in.o  security/built-in.o  crypto/built-in.o
> block/built-in.o  lib/lib.a  arch/x86/lib/lib.a  lib/built-in.o
> arch/x86/lib/built-in.o  drivers/built-in.o  sound/built-in.o  firmware/built-in.o
> arch/x86/pci/built-in.o  net/built-in.o --end-group
> kernel/built-in.o: In function `collect_garbage_slots':
> kprobes.c:(.kprobes.text+0x16e4): undefined reference to `freeze_processes'
> kprobes.c:(.kprobes.text+0x16f2): undefined reference to `thaw_processes'
> kprobes.c:(.kprobes.text+0x176b): undefined reference to `thaw_processes'
>
> At kernel/Makefile:53, I can see
>
> obj-$(CONFIG_PM) += power/
>
> but CONFIG_PM was not set in config

Sounds plausible. We need a fix for this - it's broken upstream.

	Ingo
