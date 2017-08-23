From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH] devfreq: Convert to using %pOF instead of full_name
Date: Thu, 24 Aug 2017 08:18:29 +0900
Message-ID: <599E0D45.7030001@samsung.com>
References: <20170718214339.7774-17-robh@kernel.org>
        <CGME20170718214411epcas2p43fc1475c80245889737ba9e731497e38@epcms1p2>
        <596EB809.7050605@samsung.com>
        <20170720052553epcms1p24dc190a0d51f2e447a76e417e519bd28@epcms1p2>
        <CAL_JsqL9x16Z76VSAkDUiyEddafYuiH4mFTUur=8LgrJehrFLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <CAL_JsqL9x16Z76VSAkDUiyEddafYuiH4mFTUur=8LgrJehrFLw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Rob,

On 2017년 08월 24일 03:09, Rob Herring wrote:
> On Thu, Jul 20, 2017 at 12:25 AM, MyungJoo Ham <myungjoo.ham@samsung.com> wrote:
>>> On 2017년 07월 19일 06:42, Rob Herring wrote:
>>>> Now that we have a custom printf format specifier, convert users of
>>>> full_name to use %pOF instead. This is preparation to remove storing
>>>> of the full path string for each node.
>>>>
>>>> Signed-off-by: Rob Herring <robh@kernel.org>
>>>> Cc: Chanwoo Choi <cw00.choi@samsung.com>
>>>> Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
>>>> Cc: Kyungmin Park <kyungmin.park@samsung.com>
>>>> Cc: linux-pm@vger.kernel.org
>>>> ---
>>>>  drivers/devfreq/devfreq-event.c | 4 ++--
>>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/devfreq/devfreq-event.c b/drivers/devfreq/devfreq-event.c
>>>> index 8648b32ebc89..d67242d87744 100644
>>>> --- a/drivers/devfreq/devfreq-event.c
>>>> +++ b/drivers/devfreq/devfreq-event.c
>>>> @@ -277,8 +277,8 @@ int devfreq_event_get_edev_count(struct device *dev)
>>>>                                             sizeof(u32));
>>>>     if (count < 0) {
>>>>             dev_err(dev,
>>>> -                   "failed to get the count of devfreq-event in %s node\n",
>>>> -                   dev->of_node->full_name);
>>>> +                   "failed to get the count of devfreq-event in %pOF node\n",
>>>> +                   dev->of_node);
>>>>             return count;
>>>>     }
>>>>
>>>
>>> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
>>>
>>
>> Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>
> 
> Please take this thru the devfreq tree.

This patch was merged on devfreq tree.
https://git.kernel.org/pub/scm/linux/kernel/git/mzx/devfreq.git/commit/?h=for-next&id=7f46535e8a2e3c3e415e55eaadcb9d9a153a5300

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
