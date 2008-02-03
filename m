From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: sleepy linux self-test
Date: Sun, 3 Feb 2008 08:51:11 +0100
Message-ID: <20080203075111.GB19981__26087.4800420881$1202025315$gmane$org@uranus.ravnborg.org>
References: <20080130131748.GA3796@elf.ucw.cz> <20080203050537.GA18942@elte.hu>
	<20080203051425.GA20740@elte.hu>
	<200802022318.03597.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200802022318.03597.david-b@pacbell.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: David Brownell <david-b@pacbell.net>
Cc: Ingo Molnar <mingo@elte.hu>, linux-pm@lists.linux-foundation.org, kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

> --- g26.orig/drivers/char/Kconfig
> +++ g26/drivers/char/Kconfig
> @@ -715,9 +715,12 @@ config NVRAM
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called nvram.
>  
> +comment "You are using the RTC framework, not the legacy CMOS RTC driver"
> +	depends on RTC_DRV_CMOS
> +
>  config RTC
>  	tristate "Enhanced Real Time Clock Support"
> -	depends on !PPC && !PARISC && !IA64 && !M68K && !SPARC && !FRV && !ARM && !SUPERH && !S390
> +	depends on !PPC && !PARISC && !IA64 && !M68K && !SPARC && !FRV && !ARM && !SUPERH && !S390 && !RTC_DRV_CMOS

This looks like a prime candidate for a HAVE_RTC config variable
So you do:

 config RTC
 	tristate "Enhanced Real Time Clock Support"
+	depends on HAVE_RTC && !RTC_DEV_CMOS

config HAVE_RTC
	bool

(No "depends on" allowed!)


And then the architectures that do support the RTC Framework do an:
(arch/x86/Kconfig as an example):
 config X86
+	select HAVE_RTC

So when PPC suddenly supports it they add this single
select statement and no more Kconfig magic needed.

See Documentation/kbuild/kconfig-language.txt for a bit more elaborate
description.

	Sam
