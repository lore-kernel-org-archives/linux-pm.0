From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: RE: [PATCH 3/3] usb: renesas_usbhs: Remove dummy runtime PM callbacks
Date: Thu, 25 Oct 2018 02:45:18 +0000
Message-ID: <OSBPR01MB229365A4E6587232987F1F1CD8F70@OSBPR01MB2293.jpnprd01.prod.outlook.com>
References: <20181024135134.28456-1-jarkko.nikula@linux.intel.com>
 <20181024135134.28456-4-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20181024135134.28456-4-jarkko.nikula@linux.intel.com>
Content-Language: ja-JP
Sender: netdev-owner@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "David S . Miller" <davem@davemloft.net>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Jarkko,

> From: Jarkko Nikula, Sent: Wednesday, October 24, 2018 10:52 PM
>=20
> Platform drivers don't need dummy runtime PM callbacks that just return
> success in order to have runtime PM happening. This has changed since
> following commits:
>=20
> 05aa55dddb9e ("PM / Runtime: Lenient generic runtime pm callbacks")
> 543f2503a956 ("PM / platform_bus: Allow runtime PM by default")
> 8b313a38ecff ("PM / Platform: Use generic runtime PM callbacks directly")
>=20
> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> ---
> Only build tested.

Thank you for the patch!

Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

> ---
>  drivers/usb/renesas_usbhs/common.c | 14 --------------
>  1 file changed, 14 deletions(-)
>=20
> diff --git a/drivers/usb/renesas_usbhs/common.c b/drivers/usb/renesas_usb=
hs/common.c
> index a3e1290d682d..0e760f228dd8 100644
> --- a/drivers/usb/renesas_usbhs/common.c
> +++ b/drivers/usb/renesas_usbhs/common.c
> @@ -874,23 +874,9 @@ static int usbhsc_resume(struct device *dev)
>  	return 0;
>  }
>=20
> -static int usbhsc_runtime_nop(struct device *dev)
> -{
> -	/* Runtime PM callback shared between ->runtime_suspend()
> -	 * and ->runtime_resume(). Simply returns success.
> -	 *
> -	 * This driver re-initializes all registers after
> -	 * pm_runtime_get_sync() anyway so there is no need
> -	 * to save and restore registers here.
> -	 */

I guess this code came from i2c-sh_mobile.c or sh_eth.c
and we didn't realize this code didn't need at that time (Oct 10 2011).

Best regards,
Yoshihiro Shimoda

> -	return 0;
> -}
> -
>  static const struct dev_pm_ops usbhsc_pm_ops =3D {
>  	.suspend		=3D usbhsc_suspend,
>  	.resume			=3D usbhsc_resume,
> -	.runtime_suspend	=3D usbhsc_runtime_nop,
> -	.runtime_resume		=3D usbhsc_runtime_nop,
>  };
>=20
>  static struct platform_driver renesas_usbhs_driver =3D {
> --
> 2.19.1
