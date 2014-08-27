From: Caesar Wang <caesar.wang@rock-chips.com>
Subject: Re: [PATCH v2 2/2] dt-bindings: document Rockchip thermal
Date: Thu, 28 Aug 2014 04:36:35 +0800
Message-ID: <53FE4153.3080601@rock-chips.com>
References: <1409096503-7081-1-git-send-email-caesar.wang@rock-chips.com> <1409096503-7081-3-git-send-email-caesar.wang@rock-chips.com> <5911166.ElkaNhDZrP@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <5911166.ElkaNhDZrP@wuerfel>
Sender: linux-doc-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: heiko@sntech.de, rui.zhang@intel.com, edubezval@gmail.com, grant.likely@linaro.org, robh+dt@kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, huangtao@rock-chips.com, cf@rock-chips.com, dianders@chromium.org, dtor@chromium.org, zyw@rock-chips.com, addy.ke@rock-chips.com, zhaoyifeng <zyf@rock-chips.com>
List-Id: linux-pm@vger.kernel.org

Arnd,


=E5=9C=A8 2014=E5=B9=B408=E6=9C=8828=E6=97=A5 04:17, Arnd Bergmann =E5=86=
=99=E9=81=93:
> On Wednesday 27 August 2014 07:41:43 Caesar Wang wrote:
>> +- clock-names : Shall be "tsadc_clk" for the transfer-clock, and "t=
sadc_pclk" for
>> +    the peripheral clock.
>>
> Why not just name them "clk" and "pclk"? The "tsadc" part seems highl=
y redundant.
>
> Alternatively, how about "transfer" and "peripheral"?

It seems  nappropriate description.

But,I will fix  as the following:

-clock-names =EF=BC=9A Shall be "tsadc" for the converter-clock, and "a=
pb_pclk" for
               the peripheral clock.

Thanks!



>
> 	Arnd
>
>
>

--=20
Best regards,
Caesar


