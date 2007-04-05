From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: Power Mangement Interfaces
Date: Thu, 05 Apr 2007 16:20:05 +0800
Message-ID: <1175761205.23121.28.camel__3680.06087742305$1175761303$gmane$org@localhost.localdomain>
References: <20070330235759.GC4252@cosmic.amd.com>
	<200703312001.55231.david-b@pacbell.net>
	<1175509422.5321.37.camel@localhost.localdomain>
	<200704021124.21926.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200704021124.21926.david-b@pacbell.net>
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
Cc: linux-pm@lists.linux-foundation.org, devel@laptop.org, "linux-acpi@vger" <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 2007-04-03 at 02:24 +0800, David Brownell wrote:
> On Monday 02 April 2007 3:23 am, Zhang Rui wrote:
> > If a device is also described in ACPI namespace, it should know its
> ACPI
> > device node in sysfs.
> =

> What about PCI or PNP devices that have "shadow" listings in ACPI?
> =

what do you mean "devices that have shadow listings in ACPI"? :)
Sorry I'm not quite familiar with pci and pnp devices.

> > > And while it seems that the three USB controllers on this system
> show up
> > > as /sys/devices/acpi_system:00/device:00/PNP0A03:00/device:
> {01,02,03} I
> > > have no idea which one is /sys/devices/pci0000:00/0000:00:02.2
> versus
> > > 0000:00:02.1 or 0000:00:02.0 ... I know that USB0 is device:01 and
> so
> > > on (by reading "path"), but associating one with a PCI device
> seems to
> > > involve pure guesswork.
> >
> > Sorry to make you confused.
> > That's what we need to improve in the wish list. :)
> =

> Do you mean the "ACPI 4.0" wishlist?  Or the "Linux ACPI" wishlist?
> =

No, as part of the ACPI sysfs conversion work, it's just the things that
are not finished now and I wish to do in the near future.

Thanks,
Rui
