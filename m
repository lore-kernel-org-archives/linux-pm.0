From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [RFC][RFT][PATCH] ACPI: Protection from suspending
 in the middle of EC transaction
Date: Mon, 1 Feb 2010 07:46:43 -0200
Message-ID: <20100201094643.GB8740__46732.6560909443$1265017681$gmane$org@khazad-dum.debian.net>
References: <201001310029.48717.rjw@sisk.pl>
	<9b2b86521001310611m339862afw73410dc7eb5692c8@mail.gmail.com>
	<1264957760.7264.3.camel@maxim-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1264957760.7264.3.camel@maxim-laptop>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Alan Jenkins <sourcejedi.lkml@googlemail.com>
List-Id: linux-pm@vger.kernel.org

On Sun, 31 Jan 2010, Maxim Levitsky wrote:
> Unfortunately, this patch even causes regressions on my notebook (it
> survive 63 hibernate cycles), but now I battery driver reports 'battery
> absent', backlight driver reports 0 brightness, but reload helped.

...

> I think that not only _PTS ans _WAK are problematic. What about other
> ACPI drivers that start accessing the EC before it is resumed?
> I think that these cause the problems I observe.

ACPI drivers might access the EC (even indirectly, through the DSDT).  And
platform drivers do often access the EC both at suspend and resume time.

This needs some sort of strong ordering, the EC must suspend last, and
resume first (as seen by any ACPI and ACPI-aware drivers such as libata,
some platform drivers, etc).  If EC interrupts are a problem, maybe it can
be kicked to poll mode for the suspend/resume transition?

Some platform drivers (like thinkpad-acpi) might need some changes to access
the EC syncronized with their ACPI devices (often they have all sort of
devices, e.g.  backlight, ALSA, hwmon...) if the ordering is based on logic
in the ACPi bus driver.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
