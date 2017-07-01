From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: Re: [PATCH] devfreq: rk3399_dmc: fix error code in rk3399_dmcfreq_probe()
Date: Sat, 1 Jul 2017 16:50:49 +0900
Message-ID: <CAJ0PZbQfwf6VrHLMWc_VL=7FgzFo7DpCugDfiZtawY1FDLcy7g@mail.gmail.com>
References: <CGME20170630071526epcas3p1104189e06db8f2d62622d72dc5f6fdd6@epcas3p1.samsung.com>
 <20170630071522.GA20486@embeddedgus> <5956057D.3070704@samsung.com>
Reply-To: myungjoo.ham@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yb0-f193.google.com ([209.85.213.193]:36524 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751831AbdGAHvF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 1 Jul 2017 03:51:05 -0400
In-Reply-To: <5956057D.3070704@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: "Gustavo A. R. Silva" <garsilva@embeddedor.com>, Kyungmin Park <kyungmin.park@samsung.com>, Linux PM list <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Fri, Jun 30, 2017 at 5:02 PM, Chanwoo Choi <cw00.choi@samsung.com> wrote=
:
> Hi,
>
> On 2017=EB=85=84 06=EC=9B=94 30=EC=9D=BC 16:15, Gustavo A. R. Silva wrote=
:
>> Print and propagate the return value of platform_get_irq on failure.
>>
>> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
>> ---
>>  drivers/devfreq/rk3399_dmc.c | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/devfreq/rk3399_dmc.c b/drivers/devfreq/rk3399_dmc.c
>> index 40a2499..1b89ebb 100644
>> --- a/drivers/devfreq/rk3399_dmc.c
>> +++ b/drivers/devfreq/rk3399_dmc.c
>> @@ -336,8 +336,9 @@ static int rk3399_dmcfreq_probe(struct platform_devi=
ce *pdev)
>>
>>       irq =3D platform_get_irq(pdev, 0);
>>       if (irq < 0) {
>> -             dev_err(&pdev->dev, "Cannot get the dmc interrupt resource=
\n");
>> -             return -EINVAL;
>> +             dev_err(&pdev->dev,
>> +                     "Cannot get the dmc interrupt resource: %d\n", irq=
);
>> +             return irq;
>>       }
>>       data =3D devm_kzalloc(dev, sizeof(struct rk3399_dmcfreq), GFP_KERN=
EL);
>>       if (!data)
>>
>
> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>

>
> --
> Best Regards,
> Chanwoo Choi
> Samsung Electronics



--=20
MyungJoo Ham, Ph.D.
S/W Center, Samsung Electronics
