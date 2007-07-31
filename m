From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] create CONFIG_SUSPEND_UP_POSSIBLE
Date: Tue, 31 Jul 2007 11:33:26 +0200
Message-ID: <200707311133.27963.rjw__3537.91002785346$1185873934$gmane$org@sisk.pl>
References: <200707251238.50218.lenb@kernel.org>
	<200707302354.23237.lenb@kernel.org>
	<20070731063833.GD22419@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070731063833.GD22419@elf.ucw.cz>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: david@lang.hm, Nigel Cunningham <nigel@nigel.suspend2.net>, linux-kernel@vger.kernel.org, Adrian Bunk <bunk@stusta.de>, linux-acpi@vger.kernel.org, Stefan Richter <stefanr@s5r6.in-berlin.de>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday, 31 July 2007 08:38, Pavel Machek wrote:
> Hi!
> 
> > Without this change, it is possible to build CONFIG_HIBERNATE
> > on all !SMP architectures, but not necessarily their SMP versions.
> 
> Did you want to say "CONFIG_SUSPEND"?
> 
> > I don't know for sure if the architecture list under SUSPEND_UP_POSSIBLE
> > is correct.  For now it simply matches the list for
> > SUSPEND_SMP_POSSIBLE.
> 
> I do not think it is.

No, it's not.

> > Signed-off-by: Len Brown <len.brown@intel.com>
> > ---
> >  Kconfig |    7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
> > index 412859f..ccf6576 100644
> > --- a/kernel/power/Kconfig
> > +++ b/kernel/power/Kconfig
> > @@ -72,6 +72,11 @@ config PM_TRACE
> >  	CAUTION: this option will cause your machine's real-time clock to be
> >  	set to an invalid time after a resume.
> >  
> > +config SUSPEND_UP_POSSIBLE
> > +	bool
> > +	depends on (X86 && !X86_VOYAGER) || (PPC64 && (PPC_PSERIES ||
> 
> At least ARM can do suspend, too... probably others.

ARM, frv, sh, mips and blackfin (AFAICS).

> I was under impression that SUSPEND is "supported" by all the architectures,
> just some of them veto it at runtime (using pm_ops or how was it renamed).

Historically, suspend support was implied by CONFIG_PM.

For now, it's not much point in using CONFIG_PM at all if the arch in question
doesn't support suspending or hibernation, so I thought it would be better to
leave it unrestricted.

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
