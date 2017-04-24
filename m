From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [GIT PULL] Immutable branch between MFD and IIO due
 for the v4.12 merge window
Date: Mon, 24 Apr 2017 12:02:39 +0100
Message-ID: <20170424110239.cv5nylgvymhwvg4w@dell>
References: <20170404063441.7656-1-quentin.schulz@free-electrons.com>
 <20170411100528.2zif3fyi7uoyw33n@dell>
 <0f30afec-ff42-e125-96d6-35893324f7ef@kernel.org>
Reply-To: lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBDA7X7F2WUEBBU5W67DQKGQEFN5TPOA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <0f30afec-ff42-e125-96d6-35893324f7ef-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, knaack.h-Mmb7MZpHnFY@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org, icenowy-ymACFijhrKM@public.gmane.org, liam-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org, thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Fri, 14 Apr 2017, Jonathan Cameron wrote:

> On 11/04/17 11:05, Lee Jones wrote:
> > Enjoy!
> >=20
> > The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d=
9201:
> >=20
> >   Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)
> >=20
> > are available in the git repository at:
> >=20
> >   git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-iio-=
v4.12
> >=20
> > for you to fetch changes up to f2499ab450d3052097ba53a7d763f767935c0c59=
:
> >=20
> >   iio: adc: add support for X-Powers AXP20X and AXP22X PMICs ADCs (2017=
-04-11 11:02:33 +0100)
> >=20
> > ----------------------------------------------------------------
> > Immutable branch between MFD and IIO due for the v4.12 merge window
> >=20
> > ----------------------------------------------------------------
> > Quentin Schulz (1):
> >       iio: adc: add support for X-Powers AXP20X and AXP22X PMICs ADCs
> >=20
> >  drivers/iio/adc/Kconfig      |  10 +
> >  drivers/iio/adc/Makefile     |   1 +
> >  drivers/iio/adc/axp20x_adc.c | 617 +++++++++++++++++++++++++++++++++++=
++++++++
> >  3 files changed, 628 insertions(+)
> >  create mode 100644 drivers/iio/adc/axp20x_adc.c
> >=20
> Hi Lee,=20
>=20
> Thanks for doing this, but the reason it was going to go through your
> tree in the first place was a dependency on
> commit 4707274714ef ("mfd: axp20x: Correct name of temperature data ADC r=
egisters")
>=20
> Not present in the immutable branch.
>=20
> There isn't much time for anything else going on around this driver thoug=
h
> so other than a possible merge conflict on the Kconfig and Makefile shoul=
dn't
> matter if this just goes through mfd. (famous last words ;)

It's not as though you committed it to text and sent it out to a
public mailing list for us all to reference though is it?  Doh!

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
