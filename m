From: Anson Huang <anson.huang-3arQi8VN3Tc@public.gmane.org>
Subject: RE: [PATCH 2/2] cpufreq: imx6q: add 696MHz operating point for
 i.mx6ul
Date: Mon, 8 Jan 2018 01:56:52 +0000
Message-ID: <AM3PR04MB131599C49BF8197F9C7140C3F5130@AM3PR04MB1315.eurprd04.prod.outlook.com>
References: <1514912859-17691-1-git-send-email-Anson.Huang@nxp.com>
 <CAJZ5v0it+Gc5nTa5Vt8X8_OPHh6ndcQB3peAQA1SDsuQ2+FZKA@mail.gmail.com>
 <AM3PR04MB131556AF9BDE24E071A51300F51D0@AM3PR04MB1315.eurprd04.prod.outlook.com>
 <2009633.KF2URkV5n1@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <2009633.KF2URkV5n1-yvgW3jdyMHm1GS7QM15AGw@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Cc: "Rafael J. Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux PM <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Russell King - ARM Linux <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jacky Bai <ping.bai-3arQi8VN3Tc@public.gmane.org>, "A.s. Dong" <aisheng.dong-3arQi8VN3Tc@public.gmane.org>
List-Id: linux-pm@vger.kernel.org



Best Regards!
Anson Huang


> -----Original Message-----
> From: Rafael J. Wysocki [mailto:rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org]
> Sent: 2018-01-08 7:34 AM
> To: Anson Huang <anson.huang-3arQi8VN3Tc@public.gmane.org>
> Cc: Rafael J. Wysocki <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>; linux-arm-
> kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org; devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Linux PM <linux-
> pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>; Linux Kernel Mailing List <linux-
> kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>; Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>; Sascha Hauer
> <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>; Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>; Rob
> Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>; Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>;
> Russell King - ARM Linux <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>; Viresh Kumar
> <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>; Jacky Bai <ping.bai-3arQi8VN3Tc@public.gmane.org>; A.s. Dong
> <aisheng.dong-3arQi8VN3Tc@public.gmane.org>
> Subject: Re: [PATCH 2/2] cpufreq: imx6q: add 696MHz operating point for
> i.mx6ul
>=20
> On Saturday, January 6, 2018 4:05:41 AM CET Anson Huang wrote:
> > Hi, Rafael
> >
> > Best Regards!
> > Anson Huang
> >
> >
> > > -----Original Message-----
> > > From: rjwysocki-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org [mailto:rjwysocki-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org] On Behalf Of
> > > Rafael J. Wysocki
> > > Sent: 2018-01-05 8:21 PM
> > > To: Anson Huang <anson.huang-3arQi8VN3Tc@public.gmane.org>
> > > Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org;
> > > devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Linux PM <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>;
> > > Linux Kernel Mailing List <linux- kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>; Shawn Guo
> > > <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>; Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>; Fabio
> > > Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>; Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>;
> > > Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>; Russell King - ARM Linux
> > > <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>; Rafael J. Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>;
> > > Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>; Jacky Bai
> > > <ping.bai-3arQi8VN3Tc@public.gmane.org>; A.s. Dong <aisheng.dong-3arQi8VN3Tc@public.gmane.org>
> > > Subject: Re: [PATCH 2/2] cpufreq: imx6q: add 696MHz operating point
> > > for i.mx6ul
> > >
> > > On Tue, Jan 2, 2018 at 6:07 PM, Anson Huang <Anson.Huang-3arQi8VN3Tc@public.gmane.org>
> wrote:
> > > > Add 696MHz operating point for i.MX6UL, only for those parts with
> > > > speed grading fuse set to 2b'10 supports 696MHz operating point,
> > > > so, speed grading check is also added for i.MX6UL in this patch,
> > > > the clock tree for each operating point are as below:
> > > >
> > > > 696MHz:
> > > >     pll1                       696000000
> > > >        pll1_bypass             696000000
> > > >           pll1_sys             696000000
> > > >              pll1_sw           696000000
> > > >                 arm            696000000
> > > > 528MHz:
> > > >     pll2                       528000000
> > > >        pll2_bypass             528000000
> > > >           pll2_bus             528000000
> > > >              ca7_secondary_sel 528000000
> > > >                 step           528000000
> > > >                    pll1_sw     528000000
> > > >                       arm      528000000
> > > > 396MHz:
> > > >     pll2_pfd2_396m             396000000
> > > >        ca7_secondary_sel       396000000
> > > >           step                 396000000
> > > >              pll1_sw           396000000
> > > >                 arm            396000000
> > > > 198MHz:
> > > >     pll2_pfd2_396m             396000000
> > > >        ca7_secondary_sel       396000000
> > > >           step                 396000000
> > > >              pll1_sw           396000000
> > > >                 arm            198000000
> > > >
> > > > Signed-off-by: Anson Huang <Anson.Huang-3arQi8VN3Tc@public.gmane.org>
> > >
> > > This doesn't apply for me and in a nontrivial way.
> > >
> > > What kernel is it against?
> >
> > I did it based on linux-next, it should be on linux-next-pm branch, I
> > redo the patch set V2 based on linux-next-pm, also redo the test,
> > sorry for the inconvenience.
>=20
> But you didn't add the Reviewed-by: tags from Fabio to them.
>=20
> Was that on purpose or by mistake?
>=20
> Thanks,
> Rafael

It was my mistake, I thought it will be added by maintainer, I will add the=
m and set a V3
patch set. Thanks.

Anson.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
