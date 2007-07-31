From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] create CONFIG_SUSPEND_UP_POSSIBLE
Date: Tue, 31 Jul 2007 08:38:33 +0200
Message-ID: <20070731063833.GD22419__7378.11605581573$1185864074$gmane$org@elf.ucw.cz>
References: <200707251238.50218.lenb@kernel.org>
	<200707292323.29601.rjw@sisk.pl>
	<alpine.LFD.0.999.0707291717410.3442@woody.linux-foundation.org>
	<200707302354.23237.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200707302354.23237.lenb@kernel.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Len Brown <lenb@kernel.org>
Cc: david@lang.hm, Nigel Cunningham <nigel@nigel.suspend2.net>, linux-kernel@vger.kernel.org, Adrian Bunk <bunk@stusta.de>, linux-acpi@vger.kernel.org, Stefan Richter <stefanr@s5r6.in-berlin.de>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> Without this change, it is possible to build CONFIG_HIBERNATE
> on all !SMP architectures, but not necessarily their SMP versions.

Did you want to say "CONFIG_SUSPEND"?

> I don't know for sure if the architecture list under SUSPEND_UP_POSSIBLE
> is correct.  For now it simply matches the list for
> SUSPEND_SMP_POSSIBLE.

I do not think it is.

> Signed-off-by: Len Brown <len.brown@intel.com>
> ---
>  Kconfig |    7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
> index 412859f..ccf6576 100644
> --- a/kernel/power/Kconfig
> +++ b/kernel/power/Kconfig
> @@ -72,6 +72,11 @@ config PM_TRACE
>  	CAUTION: this option will cause your machine's real-time clock to be
>  	set to an invalid time after a resume.
>  
> +config SUSPEND_UP_POSSIBLE
> +	bool
> +	depends on (X86 && !X86_VOYAGER) || (PPC64 && (PPC_PSERIES ||

At least ARM can do suspend, too... probably others. I was under
impression that SUSPEND is "supported" by all the architectures, just
some of them veto it at runtime (using pm_ops or how was it renamed).
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
