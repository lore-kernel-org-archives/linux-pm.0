From: David Cohen <david.a.cohen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [RFC/PATCH 0/3] pm: Make SET_*_PM_OPS() macros more smart
Date: Wed, 18 Dec 2013 21:12:29 -0800
Message-ID: <20131219051229.GA27854@psi-dev26.jf.intel.com>
References: <1386911905-2366-1-git-send-email-david.a.cohen@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1386911905-2366-1-git-send-email-david.a.cohen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: pavel-+ZI9xUNit7I@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, sarah.a.sharp-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, santosh.shilimkar-l0cyMroinI0@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Thu, Dec 12, 2013 at 09:18:22PM -0800, David Cohen wrote:
> Hi,
>=20
> These patches are proposal to extend the lack of #ifdef checks on PM =
callback
> to its implementation too.
>=20
> Currently SET_*_PM_OPS() macros make #ifdefs checks not necessary whe=
n setting
> the callback to PM ops, but the callbacks implementation don't see sa=
me
> benefit.
>=20
> This RFC Solves a problem reported by Santosh on xhci-plat.c driver d=
ue to
> wrong #ifdef checks:
>=20
> drivers/usb/host/xhci-plat.c:201:12: warning: =E2=80=98xhci_plat_susp=
end=E2=80=99 defined but not used [-Wunused-function]
> drivers/usb/host/xhci-plat.c:209:12: warning: =E2=80=98xhci_plat_resu=
me=E2=80=99 defined but not used [-Wunused-function]
>=20
> But instead of fixing the #ifdefs, we remove the need for it :)

Ping. Comments here? :)

Br, David

>=20
> Br, David Cohen
>=20
> ---
> David Cohen (2):
>   pm: make PM macros more smart
>   usb/xhci: implement proper static inline stubs when !CONFIG_PM
>=20
> Santosh Shilimkar (1):
>   usb/xhci-plat: remove unnecessary #ifdef checks for CONFIG_PM_SLEEP
>=20
>  drivers/usb/host/xhci-plat.c |  7 +------
>  drivers/usb/host/xhci.h      |  6 ++++--
>  include/linux/pm.h           | 11 +++++++++--
>  3 files changed, 14 insertions(+), 10 deletions(-)
>=20
> --=20
> 1.8.4.2
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
