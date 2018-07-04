From: Vivek Gautam <vivek.gautam@codeaurora.org>
Subject: Re: [PATCH 2/2] device core: Add flag to autoremove device link on
 supplier unbind
Date: Wed, 4 Jul 2018 16:49:26 +0530
Message-ID: <105f8027-782b-b16c-3267-cc07cde34d34@codeaurora.org>
References: <20180627125056.12851-1-vivek.gautam@codeaurora.org>
 <20180627125056.12851-2-vivek.gautam@codeaurora.org>
 <5b2d17e8-2224-512c-e01c-212828ecf74b@codeaurora.org>
 <2991909.NMIP74eIIJ@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2991909.NMIP74eIIJ@aspire.rjw.lan>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Robin Murphy <robin.murphy@arm.com>
Cc: linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: linux-pm@vger.kernel.org



On 7/4/2018 4:14 PM, Rafael J. Wysocki wrote:
> On Wednesday, July 4, 2018 9:16:20 AM CEST Vivek Gautam wrote:
>> Adding Ulf and Marek.
>>
>> On 6/27/2018 6:20 PM, Vivek Gautam wrote:
>>> Add a flag to autoremove the device links on supplier driver
>>> unbind. This obviates the need to explicitly delete the link
>>> in the remove path.
>>> We remove these links only when the supplier's link to its
>>> consumers has gone to DL_STATE_SUPPLIER_UNBIND state.
>>>
>>> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
>>> Suggested-by: Lukas Wunner <lukas@wunner.de>
>>> Cc: Jonathan Corbet <corbet@lwn.net>
>>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>> Cc: Robin Murphy <robin.murphy@arm.com>
>>> Cc: linux-doc@vger.kernel.org
>>> Cc: linux-arm-kernel@lists.infradead.org
>>> Cc: linux-pm@vger.kernel.org
>>> Cc: linux-arm-msm@vger.kernel.org
>>> ---
>> Hi Rafael, et al.
>>
>> Gentle ping.
>> Do you have comments on this series. I would really like to conclude these
>> device link additions sooner, and get things moving on the long awaited
>> arm-smmu clock/runtime support series.
>>
>> Thanks again for reviewing these patches.
> Hi Rafael,

> They are fine by me.

Cool.

>
> I can queue them up for 4.19 if no one has objections (Greg in
> particular).

Thanks for this.
Robin, If this approach is fine with you too, then I can go ahead and 
respin the
smmu patch series - updating the device link flag.

Best regards
Vivek

> Thanks,
> Rafael
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
