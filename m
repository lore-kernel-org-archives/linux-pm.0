From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH v2 1/2] power: reset: at91: add sama5d3 reset function
Date: Tue, 28 Jul 2015 09:27:38 +0200
Message-ID: <55B72EEA.5020600@atmel.com>
References: <1437384726-24927-1-git-send-email-josh.wu@atmel.com> <20150720164241.GA5930@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150720164241.GA5930@earth>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Josh Wu <josh.wu@atmel.com>, linux-arm-kernel@lists.infradead.org, Guenter Roeck <linux@roeck-us.net>, Kumar Gala <galak@codeaurora.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Herring <robh+dt@kernel.org>, Ben Dooks <ben.dooks@codethink.co.uk>, Krzysztof Kozlowski <k.kozlowski.k@gmail.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Pawel Moll <pawel.moll@arm.com>, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>, Wei Yongjun <yongjun_wei@trendmicro.com.cn>, Fabian Frederick <fabf@skynet.be>, linux-kernel@vger.kernel.org, Boris Brezillon <boris.brezillon@free-electrons.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Mark Rutland <mark.rutland@arm.com>, Maxime Ripard <maxime.ripard@free-electrons.com>
List-Id: linux-pm@vger.kernel.org

Le 20/07/2015 18:42, Sebastian Reichel a =E9crit :
> Hi,
>=20
> On Mon, Jul 20, 2015 at 05:32:05PM +0800, Josh Wu wrote:
>> This patch introduces a new compatible string: "atmel,sama5d3-rstc" =
and
>> new reset function for sama5d3 and later chips.
>>
>> As in sama5d3 or later chips, we don't have to shutdown the DDR
>> controller before reset. Shutdown the DDR controller before reset is=
 a
>> workaround to avoid DDR signal driving the bus, but since sama5d3 an=
d
>> later chips there is no such a conflict.
>>
>> So in this patch:
>>    1. the sama5d3 reset function only need to write the rstc registe=
r
>> and return.
>>    2. we can remove the code related with sama5d3 DDR controller as
>> we don't use it at all.
>>
>> Signed-off-by: Josh Wu <josh.wu@atmel.com>
>> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
>=20
> queued.

Sebastian,

As my Device Tree changes depend on this modification, we can
synchronize in tree ways:

1/ you provide me a stable branch so that I can pull it before applying
my changes that can go through arm-soc.

2/ you let me take the driver's modifications with me and the two
patches of the series would go through arm-soc.

3/ you take the second patch of my series with my Acked-by tag and carr=
y
both of them up to Linus' tree.

Please tell me your preference.

Thanks, bye,
--=20
Nicolas Ferre
