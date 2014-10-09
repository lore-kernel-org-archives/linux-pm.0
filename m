From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v8 1/7] qcom: spm: Add Subsystem Power Manager driver
Date: Thu, 09 Oct 2014 18:23:39 +0100
Message-ID: <5436C49B.3010705@arm.com>
References: <1412718106-17049-1-git-send-email-lina.iyer@linaro.org> <1412718106-17049-2-git-send-email-lina.iyer@linaro.org> <5436BD8C.2050601@arm.com> <20141009171216.GE1277@ilina-mac.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:43630 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751439AbaJIRXg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 9 Oct 2014 13:23:36 -0400
In-Reply-To: <20141009171216.GE1277@ilina-mac.local>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "khilman@linaro.org" <khilman@linaro.org>, "sboyd@codeaurora.org" <sboyd@codeaurora.org>, "galak@codeaurora.org" <galak@codeaurora.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, "msivasub@codeaurora.org" <msivasub@codeaurora.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>



On 09/10/14 18:12, Lina Iyer wrote:
> On Thu, Oct 09 2014 at 10:53 -0600, Sudeep Holla wrote:
>>
>>
>> On 07/10/14 22:41, Lina Iyer wrote:
>>> SPM is a hardware block that controls the peripheral logic surrounding
>>> the application cores (cpu/l$). When the core executes WFI instruction,
>>> the SPM takes over the putting the core in low power state as
>>> configured. The wake up for the SPM is an interrupt at the GIC, which
>>> then completes the rest of low power mode sequence and brings the core
>>> out of low power mode.
>>>
>>> The SPM has a set of control registers that configure the SPMs
>>> individually based on the type of the core and the runtime conditions.
>>> SPM is a finite state machine block to which a sequence is provided and
>>> it interprets the bytes  and executes them in sequence. Each low power
>>> mode that the core can enter into is provided to the SPM as a sequence.
>>>
>>> Configure the SPM to set the core (cpu or L2) into its low power mode,
>>> the index of the first command in the sequence is set in the SPM_CTL
>>> register. When the core executes ARM wfi instruction, it triggers the
>>> SPM state machine to start executing from that index. The SPM state
>>> machine waits until the interrupt occurs and starts executing the rest
>>> of the sequence until it hits the end of the sequence. The end of the
>>> sequence jumps the core out of its low power mode.
>>>
>>> Based on work by: Mahesh Sivasubramanian <msivasub@codeaurora.org>,
>>> Ai Li <ali@codeaurora.org>, Praveen Chidambaram <pchidamb@codeaurora.org>
>>> Original tree available at -
>>> git://codeaurora.org/quic/la/kernel/msm-3.10.git
>>>
>>> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
>>> ---
>>>   .../devicetree/bindings/arm/msm/qcom,saw2.txt      |  31 ++-
>>>   drivers/soc/qcom/Kconfig                           |   8 +
>>>   drivers/soc/qcom/Makefile                          |   1 +
>>>   drivers/soc/qcom/spm.c                             | 223 +++++++++++++++++++++
>>>   4 files changed, 257 insertions(+), 6 deletions(-)
>>>   create mode 100644 drivers/soc/qcom/spm.c
>>>
>>
>> [...]
>>
>>> +
>>> +static struct spm_driver_data *spm_get_drv(struct platform_device *pdev)
>>> +{
>>> +       struct spm_driver_data *drv = NULL;
>>> +       struct device_node *cpu_node, *saw_node;
>>> +       u32 cpu;
>>> +
>>> +       for_each_possible_cpu(cpu) {
>>> +               if (drv)
>>> +                       break;
>>> +               cpu_node = of_get_cpu_node(cpu, NULL);
>>
>> I have not looked at the patch in detail, just this caught my attention
>> as I removed most of these unnecessary parsing in ARM code. Unless you
>> need this before topology_init, you need not parse DT to get cpu_node.
>> You can use of_cpu_device_node_get instead.
> Thanks. But in this usecase, I may need to iterate through all possible
> cpus and do a get of the cpu and then get the SAW instance from that and
> compare against the SPM instance that is being probed.
> SPM does not have a reference to the CPU.

No that shouldn't matter. If spm_get_drv is called after topology_init 
(which if IIRC is subsys_initcall), then what I meant is you need not
parse DT(via of_get_cpu_node) instead fetch the stashed cpu_node using
of_cpu_device_node_get(cpu_num)

Regards,
Sudeep

