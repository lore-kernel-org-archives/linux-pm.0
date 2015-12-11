From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v3 18/20] ARM: dts: Add support of bus frequency using
 VDD_INT for exynos3250-rinato
Date: Fri, 11 Dec 2015 16:28:21 +0900
Message-ID: <566A7B15.4020903@samsung.com>
References: <1449810479-14763-1-git-send-email-cw00.choi@samsung.com>
 <1449810479-14763-19-git-send-email-cw00.choi@samsung.com>
 <566A78AB.9000504@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <566A78AB.9000504@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>, myungjoo.ham@samsung.com, kgene@kernel.org
Cc: kyungmin.park@samsung.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, tjakobi@math.uni-bielefeld.de, linux.amoon@gmail.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 2015=EB=85=84 12=EC=9B=94 11=EC=9D=BC 16:18, Krzysztof Kozlowski wro=
te:
> On 11.12.2015 14:07, Chanwoo Choi wrote:
>> This patch adds the bus device-tree node of INT (internal) block
>> to enable the bus frequency scaling. The following sub-blocks share
>> the VDD_INT power source:
>> - LEFTBUS (parent device)
>> - RIGHTBUS
>> - PERIL
>> - LCD0
>> - FSYS
>> - MCUISP / ISP
>> - MFC
>>
>> The LEFTBUS is parent device with devfreq ondemand governor
>> and the rest devices has the dependency on LEFTBUS bus.
>=20
> I pointed this previously. If you wish to leave the sentence in such
> form then "rest of" and "have" not "has".

It is my mistake. I'll modify it as following your comment:
- "and the rest of devices depend on the LEFTBUS device."

Best Regards,
Chanwoo Choi
