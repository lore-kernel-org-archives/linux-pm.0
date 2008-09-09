From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFC 3/5] pci wakeup handler
Date: Mon, 8 Sep 2008 19:56:47 -0700
Message-ID: <200809081956.48036.david-b__36896.2632994682$1220929937$gmane$org@pacbell.net>
References: <20080908091926.785882370@sli10-desk.sh.intel.com>
	<200809081509.52070.rjw@sisk.pl>
	<76780B19A496DC4B80439008DAD7076C01AC7F30F3@PDSMSX501.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <76780B19A496DC4B80439008DAD7076C01AC7F30F3@PDSMSX501.ccr.corp.intel.com>
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
To: "Li, Shaohua" <shaohua.li@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, Jesse Barnes <jbarnes@virtuousgeek.org>
List-Id: linux-pm@vger.kernel.org

On Monday 08 September 2008, Li, Shaohua wrote:
> > =A0 =A0 =A0 =A0if (drv && drv->pm && drv->pm->base.wakeup_event) {
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int dev_ret =3D drv->pm->base.wakeup_eve=
nt(&pdev->dev);
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (ret)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D dev_ret;
> > =A0 =A0 =A0 =A0}
> >
> > Also, why do you think we should ignore the returned value if ret is ze=
ro?
> =

> Because we already identified the device which invokes PME.

Well, we *may* have identified *one* of them.  If the device
supports the PCI PM standards, we did.  If it uses legacy PM
(like Intel's UHCI controllers), that's not guaranteed ...


> Even the .wakeup_event() returns an error, we should populate
> It's this device which has wakeup event.

You haven't exactly defined the semantics of the return value,
or what a caller would do with it.  =



> In my mind, driver isn't =

> required to provide .wakeup_event() unless device has non-standard
> regs for wakeup event or some special to handle. Generic PME handling
> should be fine for most devices (for PCI devices).      =


I don't follow this then.  You're saying it will suffice to
just clear the PCI PM status, and the driver is expected to
work fine without even being notified about its wake event??
