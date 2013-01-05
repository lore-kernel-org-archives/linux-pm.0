From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH/RFC 0/1] Delete legacy power trace API
Date: Sat, 05 Jan 2013 23:10:46 +0100
Message-ID: <5190666.Mu6UtpjCCL@vostro.rjw.lan>
References: <1357350544-32704-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1357350544-32704-1-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: linux-pm@vger.kernel.org, Arjan van de Ven <arjan@linux.intel.com>, Frederic Weisbecker <fweisbec@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Friday, January 04, 2013 08:49:03 PM Paul Gortmaker wrote:
> The actual deletion is mind-numbingly simple; and if you go by the
> comments in the code, it is well overdue.  However, in discussions
> with Frederic, he suggested to me that those comments might have
> been overly optimistic, and that there may still be people out
> there who are still unknowingly using this dead API.
> 
> So, that is the crux of the RFC component -- to check whether the
> comments saying "delete by v3.1" can be taken at face value, or
> whether they were overly optimistic, and hence this stuff is still
> actively used even though it is overdue for deletion.

Do you want me or the tracing maintainers to handle this?

Rafael


> ---
> 
> Paul Gortmaker (1):
>   tracing: remove deprecated power trace API
> 
>  Documentation/trace/events-power.txt | 27 +----------
>  arch/arm/mach-omap2/pm34xx.c         |  2 -
>  arch/x86/kernel/process.c            |  6 ---
>  drivers/cpufreq/cpufreq.c            |  1 -
>  drivers/cpuidle/cpuidle.c            |  2 -
>  include/trace/events/power.h         | 92 ------------------------------------
>  kernel/trace/Kconfig                 | 15 ------
>  kernel/trace/power-traces.c          |  3 --
>  8 files changed, 1 insertion(+), 147 deletions(-)
> 
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
