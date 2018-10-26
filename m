From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: RE: [PATCH 3/3] usb: renesas_usbhs: Remove dummy runtime PM callbacks
Date: Fri, 26 Oct 2018 02:09:31 +0000
Message-ID: <OSBPR01MB229369A87CAC7846EB6BD8A6D8F00@OSBPR01MB2293.jpnprd01.prod.outlook.com>
References: <20181024135134.28456-1-jarkko.nikula@linux.intel.com>
 <20181024135134.28456-4-jarkko.nikula@linux.intel.com>
 <20181025225742.GB20207@kunai>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20181025225742.GB20207@kunai>
Content-Language: ja-JP
Sender: netdev-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "David S . Miller" <davem@davemloft.net>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Wolfram-san,

> From: Wolfram Sang, Sent: Friday, October 26, 2018 7:58 AM
<snip>
> >  static const struct dev_pm_ops usbhsc_pm_ops =3D {
> >  	.suspend		=3D usbhsc_suspend,
> >  	.resume			=3D usbhsc_resume,
>=20
> Unrelated to this patch, but I wonder right now: is there a reason not
> to use SET_SYSTEM_SLEEP_PM_OPS here? Shimoda-san?

I don't know why because this code is contributed from Morimoto-san.
I'm guessing this code seems to come from sh_eth.c or i2c-sh_mobile.c
and we don't have the SET_SYSTEM_SLEEP_PM_OPS macro at 2009.
Morimoto-san contributed this code at 2010, but it seems not to realize
we have such macro.

Anyway, I'll try to use SET_SYSTEM_SLEEP_PM_OPS on the renesas_usbhs driver=
.

Best regards,
Yoshihiro Shimoda
