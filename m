From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] PCI / PM: enforce type casting for pci_power_t
Date: Mon, 13 Jun 2016 14:40:54 +0300
Message-ID: <1465818054.30123.10.camel@linux.intel.com>
References: <1465321713-146178-1-git-send-email-andriy.shevchenko@linux.intel.com>
	 <20160611001956.GH16462@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20160611001956.GH16462@localhost>
Sender: linux-pci-owner@vger.kernel.org
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Fri, 2016-06-10 at 19:19 -0500, Bjorn Helgaas wrote:
> On Tue, Jun 07, 2016 at 08:48:33PM +0300, Andy Shevchenko wrote:
> > When cast pci_power_t type of variables a static analizer tool
> > complains on
> > that.
> >=20
> > 	include/linux/pci.h:119:37: warning: cast from restricted
> > pci_power_t
> >=20
> > Enforce type casting to make static analizer happy.
> >=20
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>=20
> Applied to pci/pm for v4.8, thanks, Andy.

Thanks.

By the way, what was the main point to use __bitwise annotation to this
type in the first place?

>=20
> > ---
> > =C2=A0include/linux/pci.h | 2 +-
> > =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > index b67e4df..8d74834 100644
> > --- a/include/linux/pci.h
> > +++ b/include/linux/pci.h
> > @@ -116,7 +116,7 @@ extern const char *pci_power_names[];
> > =C2=A0
> > =C2=A0static inline const char *pci_power_name(pci_power_t state)
> > =C2=A0{
> > -	return pci_power_names[1 + (int) state];
> > +	return pci_power_names[1 + (__force int) state];
> > =C2=A0}
> > =C2=A0
> > =C2=A0#define PCI_PM_D2_DELAY		200
> > --=C2=A0
> > 2.8.1
> >=20
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-pci=
"=20
> > in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at=C2=A0=C2=A0http://vger.kernel.org/majordomo-=
info.html

--=20

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
