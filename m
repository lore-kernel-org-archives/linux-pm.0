From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [RESEND][PATCH 3/3] arm64: dts: mt8173: Add dynamic power node.
Date: Thu, 21 Apr 2016 12:28:28 +0200
Message-ID: <5718AB4C.5020804@gmail.com>
References: <1458029437-12846-1-git-send-email-dawei.chien@mediatek.com>
 <1458029437-12846-4-git-send-email-dawei.chien@mediatek.com>
 <1461211971.16427.4.camel@mtksdaap41>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:36036 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751008AbcDUK2c (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 21 Apr 2016 06:28:32 -0400
In-Reply-To: <1461211971.16427.4.camel@mtksdaap41>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: dawei chien <dawei.chien@mediatek.com>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Daniel Kurtz <djkurtz@chromium.org>, Sascha Hauer <s.hauer@pengutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>, srv_heupstream <srv_heupstream@mediatek.com>, Sascha Hauer <kernel@pengutronix.de>, Punit Agrawal <punit.agrawal@arm.com>



On 21/04/16 06:12, dawei chien wrote:
> On Tue, 2016-03-15 at 16:10 +0800, Dawei Chien (=E9=8C=A2=E5=A4=A7=E8=
=A1=9B) wrote:
>> This device node is for calculating dynamic power in mW.
>> Since mt8173 has two clusters, there are two dynamic power
>> coefficient as well.
>>
>> Signed-off-by: Dawei Chien <dawei.chien@mediatek.com>
>> ---
>> This patch is base on patchset:
>> https://lkml.org/lkml/2015/11/17/251
>
> Sorry for miss one dependence for this device node.
> https://lkml.org/lkml/2015/7/9/206
>

This patch got somehow forgotten.
Thanks for the reminder.
Matthias

>> ---
>>   arch/arm64/boot/dts/mediatek/mt8173.dtsi |    4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/b=
oot/dts/mediatek/mt8173.dtsi
>> index f9c44cc..5cb6b4e 100644
>> --- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
>> +++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
>> @@ -71,6 +71,7 @@
>>                          #cooling-cells =3D <2>;
>>                          #cooling-min-level =3D <0>;
>>                          #cooling-max-level =3D <7>;
>> +                       dynamic-power-coefficient =3D <263>;
>>                  };
>>
>>                  cpu1: cpu@1 {
>> @@ -95,6 +96,7 @@
>>                          #cooling-cells =3D <2>;
>>                          #cooling-min-level =3D <0>;
>>                          #cooling-max-level =3D <7>;
>> +                       dynamic-power-coefficient =3D <263>;
>>                  };
>>
>>                  cpu2: cpu@100 {
>> @@ -119,6 +121,7 @@
>>                          #cooling-cells =3D <2>;
>>                          #cooling-min-level =3D <0>;
>>                          #cooling-max-level =3D <7>;
>> +                       dynamic-power-coefficient =3D <530>;
>>                  };
>>
>>                  cpu3: cpu@101 {
>> @@ -143,6 +146,7 @@
>>                          #cooling-cells =3D <2>;
>>                          #cooling-min-level =3D <0>;
>>                          #cooling-max-level =3D <7>;
>> +                       dynamic-power-coefficient =3D <530>;
>>                  };
>>
>>                  idle-states {
>> --
>> 1.7.9.5
>>
>
>
