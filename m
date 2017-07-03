From: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] devfreq: tegra: fix error code in tegra_devfreq_probe()
Date: Mon, 3 Jul 2017 13:22:04 +0100
Message-ID: <df35dc5e-0a8f-0022-be20-36be38fbf83b@nvidia.com>
References: <20170630072211.GA21867@embeddedgus>
 <89de541e-355e-e79c-0090-cffefd277b4c@nvidia.com>
 <20170703065905.Horde.JGioNMGT4RgQsy5ykZpOZQ1@gator4166.hostgator.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170703065905.Horde.JGioNMGT4RgQsy5ykZpOZQ1-fU+oOHjIBR1LoJgMfuPDHBfZZeVsHd8q@public.gmane.org>
Content-Language: en-US
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Gustavo A. R. Silva" <garsilva-L1vi/lXTdts+Va1GwOuvDg@public.gmane.org>
Cc: MyungJoo Ham <myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org


On 03/07/17 12:59, Gustavo A. R. Silva wrote:
> Hi Jon,
> 
> Quoting Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>:
> 
>> On 30/06/17 08:22, Gustavo A. R. Silva wrote:
>>> Print and propagate the return value of platform_get_irq on failure.
>>>
>>> Signed-off-by: Gustavo A. R. Silva <garsilva-L1vi/lXTdts+Va1GwOuvDg@public.gmane.org>
>>> ---
>>>  drivers/devfreq/tegra-devfreq.c | 6 +++---
>>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/devfreq/tegra-devfreq.c
>>> b/drivers/devfreq/tegra-devfreq.c
>>> index 214fff9..ae71215 100644
>>> --- a/drivers/devfreq/tegra-devfreq.c
>>> +++ b/drivers/devfreq/tegra-devfreq.c
>>> @@ -688,9 +688,9 @@ static int tegra_devfreq_probe(struct
>>> platform_device *pdev)
>>>      }
>>>
>>>      irq = platform_get_irq(pdev, 0);
>>> -    if (irq <= 0) {
>>> -        dev_err(&pdev->dev, "Failed to get IRQ\n");
>>> -        return -ENODEV;
>>> +    if (irq < 0) {
>>
>> The changelog does not describe the above change and if/why this is ok.
>> However, the original test looks fine to me and so I don't see a need to
>> change this.
>>
> 
> You are right about the changelog. I think this one is much better:
> 
> platform_get_irq() returns an error code, but the tegra-devfreq
> driver ignores it and always returns -ENODEV. This is not correct,
> and prevents -EPROBE_DEFER from being propagated properly.
> 
> Notice that platform_get_irq() no longer returns 0 on error:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e330b9a6bb35dc7097a4f02cb1ae7b6f96df92af

Yes the above should be added to the changelog.

Looks like someone should update the following for consistency too ...

141 int platform_irq_count(struct platform_device *dev)
142 {
143         int ret, nr = 0;
144
145         while ((ret = platform_get_irq(dev, nr)) >= 0)
146                 nr++;

> 
> Print error message and propagate the return value of
> platform_get_irq on failure.
> 
> What do you think?
Fine with me.

Thanks!
Jon

-- 
nvpublic
