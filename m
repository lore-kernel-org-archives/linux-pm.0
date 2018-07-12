From: Amit Kucheria <amit.kucheria@linaro.org>
Subject: Re: [PATCH v6 2/7] thermal: tsens: Add support to split up register
 address space into two
Date: Thu, 12 Jul 2018 10:10:34 +0530
Message-ID: <CAHLCerNcoXuDi0MF5q8fzmegMZfGwAxSkv4czndVa0a-ov6ZVg@mail.gmail.com>
References: <cover.1531135999.git.amit.kucheria@linaro.org>
 <e7c5c74bd5ad1820f0f015d8e9b3d7c7b24854a4.1531135999.git.amit.kucheria@linaro.org>
 <CAD=FV=UGjf+qSfzYbQ1OEydEWJH2e8vhNiOPAytPH_rnkabq3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAD=FV=UGjf+qSfzYbQ1OEydEWJH2e8vhNiOPAytPH_rnkabq3Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Doug Anderson <dianders@chromium.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Rajendra Nayak <rnayak@codeaurora.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, Eduardo Valentin <edubezval@gmail.com>, smohanad@codeaurora.org, Vivek Gautam <vivek.gautam@codeaurora.org>, Andy Gross <andy.gross@linaro.org>, Zhang Rui <rui.zhang@intel.com>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Jul 12, 2018 at 12:07 AM, Doug Anderson <dianders@chromium.org> wrote:
> Hi,
>
> On Mon, Jul 9, 2018 at 4:43 AM, Amit Kucheria <amit.kucheria@linaro.org> wrote:
>> There are two banks of registers for v2 TSENS IPs: SROT and TM. On older
>> SoCs these were contiguous, leading to DTs mapping them as one register
>> address space of size 0x2000. In newer SoCs, these two banks are not
>> contiguous anymore.
>>
>> Fixing old DTs to split the address space into allows us to have cleaner
>> common code e.g. get_temp() that is shared across new and old platforms.
>
> This makes it sound like old DTs won't be supported anymore.  ...but
> the code says otherwise.  I'd just remove the above paragraph.

OK.

>
>> @@ -126,11 +127,21 @@ static const struct regmap_config tsens_config = {
>>  int __init init_common(struct tsens_device *tmdev)
>>  {
>>         void __iomem *base;
>> +       struct platform_device *op = of_find_device_by_node(tmdev->dev->of_node);
>>
>> +       if (!op)
>> +               return -EINVAL;
>>         base = of_iomap(tmdev->dev->of_node, 0);
>>         if (!base)
>>                 return -EINVAL;
>>
>> +       if (op->num_resources > 1) {
>
> Maybe add a comment here that says that we don't actually map the SROT
> yet because you don't read anything from there?  I kept getting
> confused about how this patch could possibly work with no code to map
> SROT...

OK. The SROT comment got separated (patch 3) during patch refactoring.
Will add a comment.

>> +               tmdev->tm_offset = 0;
>> +       } else {
>> +               /* old DTs where SROT and TM were in a contiguous 2K block */
>> +               tmdev->tm_offset = 0x1000;
>
> This patch without patch #4 will break compatibility.  You should
> squash part of patch #4 into this one, specifically:
>
> -#define STATUS_OFFSET 0x10a0
> -#define LAST_TEMP_MASK 0xfff
> +#define STATUS_OFFSET 0xa0
> +#define LAST_TEMP_MASK 0xfff
>
> Without that you break bisect-ability and also confuse anyone trying
> to look at this patch.

Thanks. Will fix.
