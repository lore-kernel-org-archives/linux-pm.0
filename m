From: =?UTF-8?Q?Stefan_Riedm=c3=bcller?= <s.riedmueller@phytec.de>
Subject: Re: [PATCH] cpufreq: imx6q-cpufreq: Fix speed grading check for
 imx6qp
Date: Thu, 21 Dec 2017 08:34:39 +0100
Message-ID: <55b1d40f-1973-ad6a-d01c-1ee063daedcb@phytec.de>
References: <1513698982-13560-1-git-send-email-s.riedmueller@phytec.de>
 <1513702940.14526.11.camel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.visioncatalog.com ([217.6.246.34]:57106 "EHLO
        root.phytec.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750797AbdLUHel (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 21 Dec 2017 02:34:41 -0500
In-Reply-To: <1513702940.14526.11.camel@pengutronix.de>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lucas Stach <l.stach@pengutronix.de>, rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, fabio.estevam@nxp.com

Hi,

On 19.12.2017 18:02, Lucas Stach wrote:
> Am Dienstag, den 19.12.2017, 16:56 +0100 schrieb Stefan Riedmueller:
>> Add compatibility for the i.MX 6QuadPlus to make it behave like the
>> i.MX 6Quad, as both SOCs use the same operating points. Otherwise the
>> i.MX 6QuadPlus tries to run with 1.2 GHz even though it only
>> supports 1 GHz.
> There is already an applied patch to fix this issue:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/?h=bleeding-edge&id=ccc153a6de1f7741b5ef7c996f9be133772b2092
>
> Regards,
> Lucas
Sorry, I missed that.
So please drop this patch.

Thanks,
Stefan
>> Signed-off-by: Stefan Riedmueller <s.riedmueller@phytec.de>
>> ---
>>   drivers/cpufreq/imx6q-cpufreq.c | 8 +++++---
>>   1 file changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
>> index 628fe89..5ca1988 100644
>> --- a/drivers/cpufreq/imx6q-cpufreq.c
>> +++ b/drivers/cpufreq/imx6q-cpufreq.c
>> @@ -218,7 +218,7 @@ static void imx6q_opp_check_speed_grading(struct device *dev)
>>>   	 * SPEED_GRADING[1:0] defines the max speed of ARM:
>>>   	 * 2b'11: 1200000000Hz;
>>>   	 * 2b'10: 996000000Hz;
>>> -	 * 2b'01: 852000000Hz; -- i.MX6Q Only, exclusive with 996MHz.
>>> +	 * 2b'01: 852000000Hz; -- i.MX6Q/QP Only, exclusive with 996MHz.
>>>   	 * 2b'00: 792000000Hz;
>>>   	 * We need to set the max speed of ARM according to fuse map.
>>>   	 */
>> @@ -227,13 +227,15 @@ static void imx6q_opp_check_speed_grading(struct device *dev)
>>>   	val &= 0x3;
>>   
>>>   	if ((val != OCOTP_CFG3_SPEED_1P2GHZ) &&
>>> -	     of_machine_is_compatible("fsl,imx6q"))
>>> +	    (of_machine_is_compatible("fsl,imx6q") ||
>>> +	     of_machine_is_compatible("fsl,imx6qp")))
>>>   		if (dev_pm_opp_disable(dev, 1200000000))
>>>   			dev_warn(dev, "failed to disable 1.2GHz OPP\n");
>>>   	if (val < OCOTP_CFG3_SPEED_996MHZ)
>>>   		if (dev_pm_opp_disable(dev, 996000000))
>>>   			dev_warn(dev, "failed to disable 996MHz OPP\n");
>>> -	if (of_machine_is_compatible("fsl,imx6q")) {
>>> +	if (of_machine_is_compatible("fsl,imx6q") ||
>>> +	    of_machine_is_compatible("fsl,imx6qp")) {
>>>   		if (val != OCOTP_CFG3_SPEED_852MHZ)
>>>   			if (dev_pm_opp_disable(dev, 852000000))
>>>   				dev_warn(dev, "failed to disable 852MHz OPP\n");
