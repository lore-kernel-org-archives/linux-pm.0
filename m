From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH v3 05/18] mfd: axp20x: add ADC cells for AXP20X and AXP22X PMICs
Date: Tue, 21 Feb 2017 12:51:49 +0800
Message-ID: <CAGb2v64zeOG+JtifgtdtxDMvi=+i6aeJ9_5UqghqB2oeBTjA3Q@mail.gmail.com>
References: <20170214094112.27426-1-quentin.schulz@free-electrons.com>
 <20170214094112.27426-6-quentin.schulz@free-electrons.com> <20170215093701.k33jmzeu4xz5guet@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170215093701.k33jmzeu4xz5guet@dell>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Quentin Schulz <quentin.schulz@free-electrons.com>, knaack.h@gmx.de, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Chen-Yu Tsai <wens@csie.org>, Sebastian Reichel <sre@kernel.org>, Russell King <linux@armlinux.org.uk>, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-iio@vger.kernel.org, devicetree <devicetree@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, "open list:THERMAL" <linux-pm@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Icenowy Zheng <icenowy@aosc.xyz>, =?UTF-8?Q?Bruno_Pr=C3=A9mont?= <bonbons@linux-vserver.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Feb 15, 2017 at 5:37 PM, Lee Jones <lee.jones@linaro.org> wrote:
> On Tue, 14 Feb 2017, Quentin Schulz wrote:
>
>> This adds the AXP20X/AXP22x ADCs driver to the mfd cells of the AXP209,
>> AXP221 and AXP223 MFD.
>>
>> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
>> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
>> ---
>>
>> v3:
>>  - removed of_compatible as DT node has been removed,
>>  - use different names to probe the ADC driver,
>>
>>  drivers/mfd/axp20x.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>
> For my own reference:
>   Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Chen-Yu Tsai <wens@csie.org>
