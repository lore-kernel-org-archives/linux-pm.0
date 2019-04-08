From: Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v2 4/4] power: supply: add Ingenic JZ47xx battery driver.
Date: Mon, 08 Apr 2019 12:23:03 +0200
Message-ID: <1554718983.1893.0@crapouillou.net>
References: <20190323172809.14407-1-contact@artur-rojek.eu>
        <20190323172809.14407-4-contact@artur-rojek.eu>
        <20190324153137.04857cdf@archlinux>
        <20190407165234.is66vmnjfc35jnho@earth.universe>
        <1554664077.4322.0@crapouillou.net>
        <20190408093824.yzpd7mve6df7lpka@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190408093824.yzpd7mve6df7lpka@earth.universe>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, Artur Rojek <contact@artur-rojek.eu>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org



Le lun. 8 avril 2019 =E0 11:38, Sebastian Reichel <sre@kernel.org> a=20
=E9crit :
> Hi Paul,
>=20
> On Sun, Apr 07, 2019 at 09:07:57PM +0200, Paul Cercueil wrote:
>>  Hi Sebastian,
>>=20
>>  Le dim. 7 avril 2019 =E0 18:52, Sebastian Reichel <sre@kernel.org> a=20
>> =E9crit :
>>  > Hi,
>>  >
>>  > On Sun, Mar 24, 2019 at 03:31:37PM +0000, Jonathan Cameron wrote:
>>  > >  On Sat, 23 Mar 2019 18:28:09 +0100
>>  > >  Artur Rojek <contact@artur-rojek.eu> wrote:
>>  > >
>>  > >  > Add a driver for battery present on Ingenic JZ47xx SoCs.
>>  > >  >
>>  > >  > Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
>>  > >  The IIO parts look fine to me.
>>  > >  Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>  > >
>>  > >  Sebastian, assuming you are happy with this version,
>>  >
>>  > The driver itself looks ok. I'm a bit unhappy, that we already=20
>> have
>>  > jz4740-battery. This driver is much cleaner, but does not yet seem
>>  > to be ready to replace it. Artur Rojek what are your plans=20
>> regarding
>>  > to the existing driver? Is there currently work going on migrating
>>  > JZ47xx to DT?
>>=20
>>  Why do you think it's not ready? Feature-wise, it has everything we
>>  need to replace jz4740-battery, which will be trashed as soon as the
>>  LB60 board code is updated to use the new driver.
>=20
> jz4740-battery has a few features not provided by your driver.
> For example the gpio providing the charging status.

Artur sumitted a separate patchset for this functionality:
https://lkml.org/lkml/2019/2/26/501

> Assuming you plan to trash the old driver soon:
>=20
> Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>
>=20
>>  We are working on porting the JZ47xx code to devicetree, yes. The
>>  ultimate goal is to completely get rid of
>>  arch/mips/jz4740/board-qi_lb60.c and arch/mips/jz4740/platform.c.
>=20
> Ok, sounds good.
>=20
> -- Sebastian

=
