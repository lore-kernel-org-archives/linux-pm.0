From: David Brownell <david-b@pacbell.net>
Subject: Re: sleepy linux self-test
Date: Sun, 3 Feb 2008 00:26:02 -0800
Message-ID: <200802030026.03249.david-b__6806.35921094126$1202027382$gmane$org@pacbell.net>
References: <20080130131748.GA3796@elf.ucw.cz>
	<200802022318.03597.david-b@pacbell.net>
	<20080203075111.GB19981@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080203075111.GB19981@uranus.ravnborg.org>
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
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Ingo Molnar <mingo@elte.hu>, linux-pm@lists.linux-foundation.org, kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Saturday 02 February 2008, Sam Ravnborg wrote:
> > --- g26.orig/drivers/char/Kconfig
> > +++ g26/drivers/char/Kconfig
> > @@ -715,9 +715,12 @@ config NVRAM
> >  	  To compile this driver as a module, choose M here: the
> >  	  module will be called nvram.
> >  
> > +comment "You are using the RTC framework, not the legacy CMOS RTC driver"
> > +	depends on RTC_DRV_CMOS
> > +
> >  config RTC
> >  	tristate "Enhanced Real Time Clock Support"
> > -	depends on !PPC && !PARISC && !IA64 && !M68K && !SPARC && !FRV && !ARM && !SUPERH && !S390
> > +	depends on !PPC && !PARISC && !IA64 && !M68K && !SPARC && !FRV && !ARM && !SUPERH && !S390 && !RTC_DRV_CMOS
> 
> This looks like a prime candidate for a HAVE_RTC config variable

In drivers/rtc/Kconfig there's *currently* a list of about
three dozen (!) different RTC drivers ... some of which support
quite a few different variants.

I'd be glad to see someone clean up the config mess with respect
to systems using MC146818 compatible chips, but that shouldn't
begin by assuming the numerous non-MC146818 chips are somehow
not real RTCs.  ;)

- Dave
