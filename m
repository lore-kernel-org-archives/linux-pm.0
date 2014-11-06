From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: (bisected) Lock up on sh73a0/kzm9g on cpuidle initialization
Date: Thu, 06 Nov 2014 22:02:22 +0100
Message-ID: <545BE1DE.6060900@linaro.org>
References: <CAMuHMdXaaa2t6+sH2egGacVxkAPeTUkAgwdYsOnMnEPnuLdB5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdXaaa2t6+sH2egGacVxkAPeTUkAgwdYsOnMnEPnuLdB5Q@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>, Ingo Molnar <mingo@kernel.org>, Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Paul McKenney <paulmck@linux.vnet.ibm.com>, Jiri Kosina <jkosina@suse.cz>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 11/06/2014 09:38 PM, Geert Uytterhoeven wrote:
> When CONFIG_CPU_IDLE=3Dy, the kernel locks up during cpuidle initiali=
zation
> on Renesas sh73a0/kzm9g-reference, which has a dual-core Cortex-A9.
>
> Last message is:
>
>      DMA: preallocated 256 KiB pool for atomic coherent allocations
>
> After this it's supposed to print:
>
>      cpuidle: using governor ladder
>      cpuidle: using governor menu
>
> I've bisected this to commit 442bf3aaf55a91ebfec71da46a4ee10a3c905bcc
> ("sched: Let the scheduler see CPU idle states").
>
> Reverting that commit, and commit 83a0a96a5f26d974580fd7251043ff70c8f=
1823d
> ("sched/fair: Leverage the idle state info when choosing the "idlest"
> cpu") which
> depends on it, fixes the problem.
>
> I saw the discussion "lockdep splat in CPU hotplug", so I enabled loc=
kdep
> debugging, but didn't see a lockdep splat.

Did you try the fix attached ?

https://lkml.org/lkml/2014/10/22/722

> I'm using CONFIG_TREE_RCU=3Dy, as this is SMP without PREEMPT.
>
> Anyone with a clue?




>
> In personal conversations with technical people, I call myself a hack=
er. But
> when I'm talking to journalists I just say "programmer" or something =
like that.
>                                  -- Linus Torvalds
>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

