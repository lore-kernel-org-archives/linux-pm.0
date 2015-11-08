From: Caesar Wang <caesar.upstream@gmail.com>
Subject: Re: [PATCH v2 0/9] Better compatible for the rockchip thermal and
 support RK3368 SoCs
Date: Sun, 8 Nov 2015 17:39:13 +0800
Message-ID: <563F1841.9060400@gmail.com>
References: <1446700685-18017-1-git-send-email-wxt@rock-chips.com>
 <1509087.903MXQEqfv@phil> <563E1E7A.6010503@gmail.com>
 <4207814.5j47hyHv2C@phil>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4207814.5j47hyHv2C@phil>
Sender: linux-kernel-owner@vger.kernel.org
To: Heiko Stuebner <heiko@sntech.de>
Cc: Eduardo Valentin <edubezval@gmail.com>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Jiri Kosina <trivial@kernel.org>, Pawel Moll <pawel.moll@arm.com>, linux-pm@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, Rob Herring <robh+dt@kernel.org>, Kumar Gala <galak@codeaurora.org>, Olof Johansson <olof@lixom.net>, Zhang Rui <rui.zhang@intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-arm-kernel@lists.infradead.org, Caesar Wang <wxt@rock-chips.com>
List-Id: linux-pm@vger.kernel.org

Hi Heiko,

=E5=9C=A8 2015=E5=B9=B411=E6=9C=8808=E6=97=A5 07:13, Heiko Stuebner =E5=
=86=99=E9=81=93:
> Hi Caesar,
>
> Am Samstag, 7. November 2015, 23:53:30 schrieb Caesar Wang:
>> =E5=9C=A8 2015=E5=B9=B411=E6=9C=8807=E6=97=A5 03:03, Heiko Stuebner =
=E5=86=99=E9=81=93:[]
>>
>> [....]
>>
>>> I call dibs on the devicetree patches :-) .
>>>
>>> Code and dt parts are very much separate, so I'd like to take the d=
t parts
>>> though my tree and arm-soc to keep further dts changes together.
>>> Of course only once you are ok with the code parts :-)
>>>
>>> Devicetree parts themselfs look ok to me.
>> Many thanks, I guess that I don't need send the dts patch again.;-)
>> the Code is still a bit change for thermal driver.
> I think you should still send the dts patches with next revisions. I =
can
> only take the patches, once Eduardo is satisfied with the code change=
s
> that include the new binding, and while I hope that this will be in v=
3, it
> will be hard if we get to v5 or so, to grep through the older revisio=
ns,
> trying to find the dts changes :-).

Okay, I send the v3 patchs.


>
> Heiko
>

--=20
Thanks,
Caesar
