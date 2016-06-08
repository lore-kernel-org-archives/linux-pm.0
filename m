From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] PCI / PM: check all fields in
 pci_set_platform_pm()
Date: Wed, 08 Jun 2016 12:04:06 +0300
Message-ID: <1465376646.1767.114.camel@linux.intel.com>
References: <1465223133-73532-1-git-send-email-andriy.shevchenko@linux.intel.com>
	 <2053744.vokaYxPbf2@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <2053744.vokaYxPbf2@vostro.rjw.lan>
Sender: linux-pci-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, 2016-06-08 at 02:17 +0200, Rafael J. Wysocki wrote:
> On Monday, June 06, 2016 05:25:33 PM Andy Shevchenko wrote:
> > When assign new PCI platform PM operations check for all mandatory
> > fields to
> > prevent NULL pointer dereference.
> >=20
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>=20
> OK in principle, but what's the motivation?

I didn't investigate the guts of the core code, but I'm about to add ne=
w
module which will use these facilities. Since the module is slightly
based on existing code for older kernels I noticed those new callbacks.
To prevent potential NULL pointer dereference.


> > ---
> > =C2=A0drivers/pci/pci.c | 4 ++--
> > =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index c8b4dbd..badbddc 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -530,8 +530,8 @@ static const struct pci_platform_pm_ops
> > *pci_platform_pm;
> > =C2=A0
> > =C2=A0int pci_set_platform_pm(const struct pci_platform_pm_ops *ops=
)
> > =C2=A0{
> > -	if (!ops->is_manageable || !ops->set_state || !ops-
> > >choose_state
> > -	=C2=A0=C2=A0=C2=A0=C2=A0|| !ops->sleep_wake)
> > +	if (!ops->is_manageable || !ops->set_state || !ops-
> > >choose_state ||
> > +	=C2=A0=C2=A0=C2=A0=C2=A0!ops->sleep_wake || !ops->run_wake || !op=
s-
> > >need_resume)
> > =C2=A0		return -EINVAL;
> > =C2=A0	pci_platform_pm =3D ops;
> > =C2=A0	return 0;
> >=20
>=20

--=20
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
