From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: Re: [PATCH v2 01/11] base: power: Add generic OF-based power domain
 look-up
Date: Thu, 20 Mar 2014 00:16:14 +0100
Message-ID: <532A253E.2000106@gmail.com>
References: <1393862536-9842-1-git-send-email-tomasz.figa@gmail.com> <1393862536-9842-2-git-send-email-tomasz.figa@gmail.com> <7e54f23f-1e11-4e17-ad29-13b497d7055a@TX2EHSMHS041.ehs.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ee0-f52.google.com ([74.125.83.52]:41022 "EHLO
	mail-ee0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759400AbaCSXQO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 19 Mar 2014 19:16:14 -0400
In-Reply-To: <7e54f23f-1e11-4e17-ad29-13b497d7055a@TX2EHSMHS041.ehs.local>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?UTF-8?B?U8O2cmVuIEJyaW5rbWFubg==?= <soren.brinkmann@xilinx.com>
Cc: linux-pm@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Ulf Hansson <ulf.hansson@linaro.org>, Stephen Warren <swarren@wwwdotorg.org>, Len Brown <len.brown@intel.com>, Stephen Boyd <sboyd@codeaurora.org>, Tomasz Figa <t.figa@samsung.com>, Pavel Machek <pavel@ucw.cz>, Kukjin Kim <kgene.kim@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, linux-samsung-soc@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, devicetree@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, Kumar Gala <gal>

Hi S=C3=B6ren,

On 20.03.2014 00:13, S=C3=B6ren Brinkmann wrote:
> On Mon, 2014-03-03 at 05:02PM +0100, Tomasz Figa wrote:
>> This patch introduces generic code to perform power domain look-up u=
sing
>> device tree and automatically bind devices to their power domains.
>> Generic device tree binding is introduced to specify power domains o=
f
>> devices in their device tree nodes.
>>
>> Backwards compatibility with legacy Samsung-specific power domain
>> bindings is provided, but for now the new code is not compiled when
>> CONFIG_ARCH_EXYNOS is selected to avoid collision with legacy code. =
This
>> will change as soon as Exynos power domain code gets converted to us=
e
>> the generic framework in further patch.
>>
>> Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
>> ---
>>   .../devicetree/bindings/power/power_domain.txt     |  51 ++++
>>   drivers/base/power/domain.c                        | 298 +++++++++=
++++++++++++
>>   include/linux/pm_domain.h                          |  46 ++++
>>   kernel/power/Kconfig                               |   4 +
>>   4 files changed, 399 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/power/power_d=
omain.txt
>>
>> diff --git a/Documentation/devicetree/bindings/power/power_domain.tx=
t b/Documentation/devicetree/bindings/power/power_domain.txt
>> new file mode 100644
>> index 0000000..93be5d9
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/power/power_domain.txt
>> @@ -0,0 +1,51 @@
>> +* Generic power domains
>> +
>> +System on chip designs are often divided into multiple power domain=
s that
>> +can be used for power gating of selected IP blocks for power saving=
 by
>> +reduced leakage current.
>> +
>> +This device tree binding can be used to bind power domain consumer =
devices
>> +with their power domains provided by power domain providers. A powe=
r domain
>> +provider can be represented by any node in the device tree and can =
provide
>> +one or more power domains. A consumer node can refer to the provide=
r by
>> +a phandle and a set of phandle arguments (so called power domain sp=
ecifier)
>> +of length specified by #power-domain-cells property in the power do=
main
>> +provider node.
>> +
>> +=3D=3DPower domain providers=3D=3D
>> +
>> +Required properties:
>> + - #power-domain-cells : Number of cells in a power domain specifie=
r;
>> +   Typically 0 for nodes representing a single power domain and 1 f=
or nodes
>> +   providing multiple power domains (e.g. power controllers), but c=
an be
>> +   any value as specified by device tree binding documentation of p=
articular
>> +   provider.
>> +
>> +Example:
>> +
>> +	power: power-controller@12340000 {
>> +		compatible =3D "foo,power-controller";
>> +		reg =3D <0x12340000 0x1000>;
>> +		#power-domain-cells =3D <1>;
>> +	};
>> +
>> +The node above defines a power controller that is a power domain pr=
ovider
>> +and expects one cell as its phandle argument.
>> +
>> +=3D=3DPower domain consumers=3D=3D
>> +
>> +Required properties:
>> + - power-domain : A phandle and power domain specifier as defined b=
y bindings
>> +                  of power controller specified by phandle.
>> +
>> +Example:
>> +
>> +	leaky-device@12350000 {
>> +		compatible =3D "foo,i-leak-current";
>> +		reg =3D <0x12350000 0x1000>;
>> +		power-domain =3D <&power 0>;
>> +	};
>> +
>> +The node above defines a typical power domain consumer device, whic=
h is located
>> +inside power domain with index 0 of power controller represented by=
 node with
>> +label "power".
>
> Does this allow nesting of power domains? E.g. you have a PD which is
> represented by some programmable power supply, and within this domain
> smaller islands/domains that can be gated independently.

These are client-side bindings only, i.e. power domain providers and=20
consumers. Registering power domains and relations between them are up=20
to platform-specific code, e.g. power controller driver.

Best regards,
Tomasz
