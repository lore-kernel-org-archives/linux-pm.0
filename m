From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: Re: [PATCH] devfreq: rk3399_dmc: fix error code in
 rk3399_dmcfreq_probe()
Date: Sun, 16 Jul 2017 23:50:32 -0500
Message-ID: <c93a3d29-0da4-9d0a-db6c-444ec1033035@embeddedor.com>
References: <CGME20170630071526epcas3p1104189e06db8f2d62622d72dc5f6fdd6@epcas3p1.samsung.com>
 <20170630071522.GA20486@embeddedgus> <5956057D.3070704@samsung.com>
 <CAJ0PZbQfwf6VrHLMWc_VL=7FgzFo7DpCugDfiZtawY1FDLcy7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJ0PZbQfwf6VrHLMWc_VL=7FgzFo7DpCugDfiZtawY1FDLcy7g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: myungjoo.ham@gmail.com, Chanwoo Choi <cw00.choi@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>, Linux PM list <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org



On 07/01/2017 02:50 AM, MyungJoo Ham wrote:
> On Fri, Jun 30, 2017 at 5:02 PM, Chanwoo Choi <cw00.choi@samsung.com> wrote:
>> Hi,
>>
>> On 2017년 06월 30일 16:15, Gustavo A. R. Silva wrote:
>>> Print and propagate the return value of platform_get_irq on failure.
>>>
>>> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
>>> ---
>>>  drivers/devfreq/rk3399_dmc.c | 5 +++--
>>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/devfreq/rk3399_dmc.c b/drivers/devfreq/rk3399_dmc.c
>>> index 40a2499..1b89ebb 100644
>>> --- a/drivers/devfreq/rk3399_dmc.c
>>> +++ b/drivers/devfreq/rk3399_dmc.c
>>> @@ -336,8 +336,9 @@ static int rk3399_dmcfreq_probe(struct platform_device *pdev)
>>>
>>>       irq = platform_get_irq(pdev, 0);
>>>       if (irq < 0) {
>>> -             dev_err(&pdev->dev, "Cannot get the dmc interrupt resource\n");
>>> -             return -EINVAL;
>>> +             dev_err(&pdev->dev,
>>> +                     "Cannot get the dmc interrupt resource: %d\n", irq);
>>> +             return irq;
>>>       }
>>>       data = devm_kzalloc(dev, sizeof(struct rk3399_dmcfreq), GFP_KERNEL);
>>>       if (!data)
>>>
>>
>> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
>
> Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>
>

Thank you, Chanwoo and MyungJoo.

-- 
Gustavo A. R. Silva
