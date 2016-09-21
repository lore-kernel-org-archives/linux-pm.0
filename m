From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v4 07/10] x86/sched: Add SD_ASYM_PACKING flags to x86 ITMT CPU
Date: Wed, 21 Sep 2016 22:33:16 +0200
Message-ID: <CAJZ5v0hCWEAvuB17rQva-Gyc3qBBSsx4e8U1kaOKaExG1Sv2RQ@mail.gmail.com>
References: <1474485552-141429-1-git-send-email-srinivas.pandruvada@linux.intel.com>
 <1474485552-141429-8-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1474485552-141429-8-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@suse.de>, the arch/x86 maintainers <x86@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, tim.c.chen@linux.intel.com, jolsa@redhat.com
List-Id: linux-pm@vger.kernel.org

On Wed, Sep 21, 2016 at 9:19 PM, Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
> From: Tim Chen <tim.c.chen@linux.intel.com>
>
> Some Intel cores in a package can be boosted to a higher turbo frequency
> with ITMT 3.0 technology. The scheduler can use the asymmetric packing
> feature to move tasks to the more capable cores.
>
> If ITMT is enabled, add SD_ASYM_PACKING flag to the thread and core
> sched domains to enable asymmetric packing.
>
> Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  arch/x86/kernel/smpboot.c | 27 +++++++++++++++++++++++----
>  1 file changed, 23 insertions(+), 4 deletions(-)
>
> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> index 38901b3..46815e6 100644
> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c
> @@ -487,22 +487,41 @@ static bool match_die(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
>         return false;
>  }
>
> +#ifndef CONFIG_SCHED_ITMT
> +#define sysctl_sched_itmt_enabled      0
> +#endif

I thought that would be done in the header where
sysctl_sched_itmt_enabled is declared (along with defining the stubs
for the sched_set_itmt_* functions).

Thanks,
Rafael
