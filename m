From: Michal Simek <michal.simek@xilinx.com>
Subject: Re: [RFC PATCH] ARM: zynq: cpuidle: convert to platform driver
Date: Fri, 27 Sep 2013 10:14:55 +0200
Message-ID: <f6e8e5b8-38f7-4cbc-86c4-dd0d6a91449f@CO9EHSMHS028.ehs.local>
References: <1380212138-4020-1-git-send-email-daniel.lezcano@linaro.org>
 <22edc518-27ad-4dcf-918a-def23df93bcc@DB9EHSMHS022.ehs.local>
 <52453210.6090606@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <52453210.6090606@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Michal Simek <michal.simek@xilinx.com>, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 09/27/2013 09:21 AM, Daniel Lezcano wrote:
> On 09/27/2013 07:12 AM, Michal Simek wrote:
>> Hi Daniel,
>>
>> On 09/26/2013 06:15 PM, Daniel Lezcano wrote:
>>> As the ux500 and the kirkwood driver, make the zynq driver a platform driver
>>>
>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>> ---
>>>   arch/arm/mach-zynq/common.c    |    7 +++++++
>>>   drivers/cpuidle/cpuidle-zynq.c |   15 ++++++++++-----
>>>   2 files changed, 17 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-zynq/common.c b/arch/arm/mach-zynq/common.c
>>> index 5f25256..0f0d88f 100644
>>> --- a/arch/arm/mach-zynq/common.c
>>> +++ b/arch/arm/mach-zynq/common.c
>>> @@ -44,6 +44,10 @@ static struct of_device_id zynq_of_bus_ids[] __initdata = {
>>>       {}
>>>   };
>>>
>>> +static struct platform_device zynq_cpuidle_device = {
>>> +    .name = "cpuidle-zynq",
>>> +};
>>> +
>>>   /**
>>>    * zynq_init_machine - System specific initialization, intended to be
>>>    *               called from board specific initialization.
>>> @@ -56,6 +60,9 @@ static void __init zynq_init_machine(void)
>>>       l2x0_of_init(0x02060000, 0xF0F0FFFF);
>>>
>>>       of_platform_bus_probe(NULL, zynq_of_bus_ids, NULL);
>>> +
>>> +    if (of_machine_is_compatible("xlnx,zynq-7000"))
>>
>> This is not needed because all zynq platforms have this compatibility string
>> and there is no any other clone.
> 
> Ah, ok. So it is not needed in the current code. I will write its removal in a separate patch.

ok. Thanks.
Feel free to give there my ACK too.

Thanks,
Michal
