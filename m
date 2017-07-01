From: MyungJoo Ham <myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] devfreq: tegra: fix error code in tegra_devfreq_probe()
Date: Sat, 1 Jul 2017 16:42:29 +0900
Message-ID: <CAJ0PZbRfrz0-pp318Z1rQOXMkQvCQX3ju__CC7Obzsyp91VtpA@mail.gmail.com>
References: <CGME20170630072216epcas1p34027491553237c57f0270b3f305f0058@epcas1p3.samsung.com>
 <20170630072211.GA21867@embeddedgus> <5956058A.3090304@samsung.com>
Reply-To: myungjoo.ham-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5956058A.3090304-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: "Gustavo A. R. Silva" <garsilva-L1vi/lXTdts+Va1GwOuvDg@public.gmane.org>, Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jonathan Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Linux PM list <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Jun 30, 2017 at 5:02 PM, Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> wrote=
:
> Hi,
>
> On 2017=EB=85=84 06=EC=9B=94 30=EC=9D=BC 16:22, Gustavo A. R. Silva wrote=
:
>> Print and propagate the return value of platform_get_irq on failure.
>>
>> Signed-off-by: Gustavo A. R. Silva <garsilva-L1vi/lXTdts+Va1GwOuvDg@public.gmane.org>
>> ---
>>  drivers/devfreq/tegra-devfreq.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-dev=
freq.c
>> index 214fff9..ae71215 100644
>> --- a/drivers/devfreq/tegra-devfreq.c
>> +++ b/drivers/devfreq/tegra-devfreq.c
>> @@ -688,9 +688,9 @@ static int tegra_devfreq_probe(struct platform_devic=
e *pdev)
>>       }
>>
>>       irq =3D platform_get_irq(pdev, 0);
>> -     if (irq <=3D 0) {
>> -             dev_err(&pdev->dev, "Failed to get IRQ\n");
>> -             return -ENODEV;
>> +     if (irq < 0) {
>> +             dev_err(&pdev->dev, "Failed to get IRQ: %d\n", irq);
>> +             return irq;
>>       }
>>
>>       platform_set_drvdata(pdev, tegra);
>>
>
> Reviewed-by: Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>

Acked-by: MyungJoo Ham <myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>

>
> --
> Best Regards,
> Chanwoo Choi
> Samsung Electronics



--=20
MyungJoo Ham, Ph.D.
S/W Center, Samsung Electronics
