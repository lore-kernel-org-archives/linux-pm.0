From: David Brownell <david-b@pacbell.net>
Subject: Re: sleepy linux self-test
Date: Sat, 2 Feb 2008 23:18:02 -0800
Message-ID: <200802022318.03597.david-b__36534.6480314203$1202023198$gmane$org@pacbell.net>
References: <20080130131748.GA3796@elf.ucw.cz> <20080203050537.GA18942@elte.hu>
	<20080203051425.GA20740@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080203051425.GA20740@elte.hu>
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
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-pm@lists.linux-foundation.org, kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Saturday 02 February 2008, Ingo Molnar wrote:
> > [ =A0 23.509562] Calling initcall 0xc0c49e00: be_sleepy+0x0/0x170()
> > [ =A0 23.515837] PM: no wakelarm-capable RTC
> > [ =A0 23.517562] initcall 0xc0c49e00: be_sleepy+0x0/0x170() returned =
0.

Because CONFIG_RTC_DRV_CMOS was not configured, though
you had several other RTC drivers ready.

> # CONFIG_RTC_DRV_CMOS is not set

Then later you had that enabled, but you also had the
legacy driver enabled:

> CONFIG_RTC=3Dy

So that was the driver which succesfully bound to the RTC
(since it's probed first) and prevented the more generic
code from kicking in.


Nobody has yet submitted a patch to help arbitrate between the
legacy and "newfangled" RTC drivers.  The general "how to Kconfig"
policy has been to expect a lot (too much?) from users, but this
type of annoyance is too common.

Maybe we need something to more actively avoid the "two drivers"
on PC hardware ... like the appended.  (The "comment" is there as
a reminder to folk who still look to that menu for RTC stuff.)

- Dave


--- g26.orig/drivers/char/Kconfig
+++ g26/drivers/char/Kconfig
@@ -715,9 +715,12 @@ config NVRAM
 	  To compile this driver as a module, choose M here: the
 	  module will be called nvram.
=20
+comment "You are using the RTC framework, not the legacy CMOS RTC driver=
"
+	depends on RTC_DRV_CMOS
+
 config RTC
 	tristate "Enhanced Real Time Clock Support"
-	depends on !PPC && !PARISC && !IA64 && !M68K && !SPARC && !FRV && !ARM =
&& !SUPERH && !S390
+	depends on !PPC && !PARISC && !IA64 && !M68K && !SPARC && !FRV && !ARM =
&& !SUPERH && !S390 && !RTC_DRV_CMOS
 	---help---
 	  If you say Y here and create a character special file /dev/rtc with
 	  major number 10 and minor number 135 using mknod ("man mknod"), you
--- g26.orig/drivers/rtc/Kconfig
+++ g26/drivers/rtc/Kconfig
@@ -281,6 +281,7 @@ comment "Platform RTC drivers"
 config RTC_DRV_CMOS
 	tristate "PC-style 'CMOS'"
 	depends on X86 || ALPHA || ARM || M32R || ATARI || PPC || MIPS
+	default y if X86
 	help
 	  Say "yes" here to get direct support for the real time clock
 	  found in every PC or ACPI-based system, and some other boards.
=20
