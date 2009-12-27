From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH 12/12] PM / r8169: Add simplified
 run-time PM support
Date: Sun, 27 Dec 2009 21:01:47 +0100
Message-ID: <20091227200147.GJ11737__10094.8831685402$1261944263$gmane$org@elf.ucw.cz>
References: <200911160047.46299.rjw@sisk.pl> <200911291644.27288.rjw@sisk.pl>
	<20091215114956.GA1415@ucw.cz> <200912272048.37332.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200912272048.37332.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux PCI <linux-pci@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Francois Romieu <romieu@fr.zoreil.com>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sun 2009-12-27 20:48:37, Rafael J. Wysocki wrote:
> On Tuesday 15 December 2009, Pavel Machek wrote:
> > Hi!
> > 
> > > Use the PCI run-time power management framework to add simplified
> > > run-time PM support to the r8169 driver.  Namely, make the driver
> > > suspend the device when the link is off and set it up for generating
> > > wake-up event after the link has been detected again.
> > 
> > Nice!
> > 
> > Do you have any idea how much power it saves?
> 
> No, but there should be a power meter somewhere here ...
> 
> I'll let you know if I can find it.

On notebooks, you can often use

pavel@amd:/data/l/linux-msm/arch/arm/mach-msm$ cat
/proc/acpi/battery/BAT0/state 
present:                 yes
capacity state:          ok
charging state:          charged
present rate:            0 mW
remaining capacity:      71830 mWh
present voltage:         16277 mV

...present rate is often usable-enough.
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
