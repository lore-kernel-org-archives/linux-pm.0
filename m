From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: Fwd: [PATCH v2 0/8] PM / devfreq: Add NoCP devfreq-event and
 support busfreq on exyno5422-odroidxu3
Date: Tue, 03 May 2016 11:17:45 +0900
Message-ID: <57280A49.6060609@samsung.com>
References: <1894783822.297231462168123817.JavaMail.weblogic@ep2mlwas04a>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1894783822.297231462168123817.JavaMail.weblogic@ep2mlwas04a>
Sender: linux-kernel-owner@vger.kernel.org
To: myungjoo.ham@samsung.com, =?UTF-8?B?67CV6rK966+8?= <kyungmin.park@samsung.com>, =?UTF-8?B?7YGs7Ims7Iuc7Yag7ZSE?= <k.kozlowski@samsung.com>, "tomasz.figa@gmail.com" <tomasz.figa@gmail.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, "kgene@kernel.org" <kgene@kernel.org>
Cc: "robh@kernel.org" <robh@kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "galak@codeaurora.org" <galak@codeaurora.org>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "linux.amoon@gmail.com" <linux.amoon@gmail.com>, "m.reichl@fivetechno.de" <m.reichl@fivetechno.de>, "tjakobi@math.uni-bielefeld.de" <tjakobi@math.uni-bielefeld.de>, =?UTF-8?B?64yA7J246riw?= <inki.dae@samsung.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, devicetree@vger.k
List-Id: linux-pm@vger.kernel.org

Dear Myungjoo,

On 2016=EB=85=84 05=EC=9B=94 02=EC=9D=BC 14:48, MyungJoo Ham wrote:
> Sender : =EC=B5=9C=EC=B0=AC=EC=9A=B0<cw00.choi@samsung.com> S5(=EC=B1=
=85=EC=9E=84)/Change Agent/Tizen Platform Lab(S/W=EC=84=BC=ED=84=B0)/=EC=
=82=BC=EC=84=B1=EC=A0=84=EC=9E=90
> Date : 2016-04-15 15:32 (GMT+09:00)
>>
>> This patchset support the AMBA bus frequency scaling on Exynos5422-b=
ased
>> Odroid-XU3 board. But, this series only support the bus frequency sc=
aling
>> for INT (Internal) block using VDD_INT power line.
>=20
> Along with Devfreq/Passive patchset, the patchset is merged in
> devfreq for-4.7 tree.
>=20
> https://git.kernel.org/cgit/linux/kernel/git/mzx/devfreq.git/log/?h=3D=
for-4.7
>=20
> @Chanwoo: If there are commits to be merged by a tree other than Linu=
x/PM,
> please let me know. I'll send out pull-request soon.

On Krzysztof Kozlowski's reply, dts patches will be merged on samsung-s=
oc tree.
and then the clock patches about exynos5420 was already merged to samsu=
ng-clk tree
by Sylwester.

Only devfreq patches should be merged on devfreq tree.

We already discussed this topic on offline. I expect that you will agai=
n handle
this patchset according to reply of both Krzysztof and me.

Best Regards,
Chanwoo Choi

>=20
>=20
> Cheers,
> MyungJoo
>=20
>>
>> Also, to support the bus frequency scaling for Exynos542x SoC,
>> Exynos542x SoC has the specific 'NoC (Network on Chip) Probe' device
>> to measure the transfered data traffic on NoC (Network on Chip)
>> instead of PPMU (Platform Performance Monitoring Unit). NoC Probe de=
vice
>> provide the utilization for INT block of Exynos542x SoC.
>>
>> The generic exynos-bus frequency driver uses the 'NoC Probe' devfreq=
-event
>> device (drivers/devfreq/event/exynos-nocp.c) without any modificatio=
n.
>> Just add the phandle of 'NoC Probe' dt node to bus dt node.
>>
>> Depend on:
>> This patchset depends on patch[1] which support the generic exynos-b=
us
>> frequency driver.
>> [1] http://www.spinics.net/lists/arm-kernel/msg495976.html
>> - [PATCH v9 00/20] PM / devferq: Add generic exynos bus frequency dr=
iver and new passive governor
>>
>>
