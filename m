From: Caesar Wang <wxt@rock-chips.com>
Subject: Re: [PATCH 3/5] dt-bindings: rockchip-thermal: Support the
 RK3228/RK3399 SoCs compatible
Date: Thu, 26 Nov 2015 10:57:49 +0800
Message-ID: <5656752D.2010707@rock-chips.com>
References: <1448438377-29203-1-git-send-email-wxt@rock-chips.com>
 <1448438377-29203-4-git-send-email-wxt@rock-chips.com>
 <11146001.lIrLtFf7Xg@diego>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <11146001.lIrLtFf7Xg@diego>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>
Cc: Eduardo Valentin <edubezval@gmail.com>, linux-rockchip@lists.infradead.org, Dan Carpenter <dan.carpenter@oracle.com>, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, Kumar Gala <galak@codeaurora.org>, linux-kernel@vger.kernel.org, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org, Pawel Moll <pawel.moll@arm.com>, Zhang Rui <rui.zhang@intel.com>, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-pm@vger.kernel.org



=E5=9C=A8 2015=E5=B9=B411=E6=9C=8825=E6=97=A5 22:56, Heiko St=C3=BCbner=
 =E5=86=99=E9=81=93:
> Am Mittwoch, 25. November 2015, 15:59:35 schrieb Caesar Wang:
>> This patchset attempts to new compatible for thermal founding
>> on RK3228/RK3399 SoCs.
>>
>> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
>> ---
>>
>>   Documentation/devicetree/bindings/thermal/rockchip-thermal.txt | 2=
 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/thermal/rockchip-ther=
mal.txt
>> b/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt ind=
ex
>> 0dfa60d..af5f802 100644
>> --- a/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
>> +++ b/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
>> @@ -2,8 +2,10 @@
>>
>>   Required properties:
>>   - compatible : should be "rockchip,<name>-tsadc"
>> +   "rockchip,rk3228-tsadc": found on RK3228 SoCs
>>      "rockchip,rk3288-tsadc": found on RK3288 SoCs
>>      "rockchip,rk3368-tsadc": found on RK3368 SoCs
>> +   "rockchip,rk3368-tsadc": found on RK3399 SoCs
> copy'n'paste error, should proably be
>   "rockchip,rk3399-tsadc": found on RK3399 SoCs

=46ixed in next version, thanks!
>>   - reg : physical base address of the controller and length of memo=
ry mapped
>> region.
>>   - interrupts : The interrupt number to the cpu. The interrupt spec=
ifier
>> format
>
>
>

--=20
caesar wang | software engineer | wxt@rock-chip.com
