From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH 03/14] thermal: Add support for sun8i THS on Allwinner H3
Date: Sat, 25 Jun 2016 08:54:56 +0800
Message-ID: <CAGb2v65DEgD-mpFMHaWU1XRwBgmQ+=hu2A9EW5u=v0oynGCE1Q@mail.gmail.com>
References: <20160623192104.18720-1-megous@megous.com> <20160623192104.18720-4-megous@megous.com>
 <CAGb2v66sFfbD0rTaeeR9CBZFaXLiCKV4DrqKi4Yhc3+u2q+UMw@mail.gmail.com> <f6015f63-f8e6-6aa4-aab3-48a8152f0df5@megous.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.csie.ntu.edu.tw ([140.112.30.61]:53700 "EHLO
	smtp.csie.ntu.edu.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751747AbcFYAzV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 24 Jun 2016 20:55:21 -0400
In-Reply-To: <f6015f63-f8e6-6aa4-aab3-48a8152f0df5@megous.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?UTF-8?Q?Ond=C5=99ej_Jirman?= <megous@megous.com>
Cc: Chen-Yu Tsai <wens@csie.org>, dev <dev@linux-sunxi.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, open list <linux-kernel@vger.kernel.org>, "open list:THERMAL" <linux-pm@vger.kernel.org>

On Sat, Jun 25, 2016 at 8:35 AM, Ond=C5=99ej Jirman <megous@megous.com>=
 wrote:
> On 24.6.2016 05:09, Chen-Yu Tsai wrote:
>>> +static int sun8i_ths_h3_init(struct platform_device *pdev,
>>> +                            struct sun8i_ths_data *data)
>>> +{
>>> +       int ret;
>>> +       size_t callen;
>>> +       s32 *caldata;
>>> +
>>> +       data->busclk =3D devm_clk_get(&pdev->dev, "ahb");
>>> +       if (IS_ERR(data->busclk)) {
>>> +               ret =3D PTR_ERR(data->busclk);
>>> +               dev_err(&pdev->dev, "failed to get ahb clk: %d\n", =
ret);
>>> +               return ret;
>>> +       }
>>> +
>>> +       data->clk =3D devm_clk_get(&pdev->dev, "ths");
>>> +       if (IS_ERR(data->clk)) {
>>> +               ret =3D PTR_ERR(data->clk);
>>> +               dev_err(&pdev->dev, "failed to get ths clk: %d\n", =
ret);
>>> +               return ret;
>>> +       }
>>> +
>>> +       data->reset =3D devm_reset_control_get(&pdev->dev, "ahb");
>>
>> IIRC with the new shared reset control stuff merged, you are suppose=
d
>> to specify whether you want a shared or exclusive one when you ask f=
or
>> it.
>
> Here devm_reset_control_get will get the exclusive reference. So this
> should be ok.

See https://patchwork.kernel.org/patch/9158691/

The generic ones might be removed later on. I remember in another threa=
d
it was asked that new users should use the explicit API, and avoid havi=
ng
to be converted.

ChenYu

>
> regards,
>   Ondrej
>
>>
>> Regards
>> ChenYu
>>
>>> +MODULE_LICENSE("GPL v2");
>>> --
>>> 2.9.0
>>>
>
