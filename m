From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Subject: Re: [PATCH v4 3/6] cpufreq: powernv: Register for OCC related opal_message
 notification
Date: Wed, 15 Jul 2015 15:45:41 +0530
Message-ID: <55A632CD.7060500@linux.vnet.ibm.com>
References: <1436796602-10228-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com> <1436796602-10228-4-git-send-email-shilpa.bhat@linux.vnet.ibm.com> <1436941021.17171.12.camel@jms.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1436941021.17171.12.camel@jms.id.au>
Sender: linux-kernel-owner@vger.kernel.org
To: Joel Stanley <joel@jms.id.au>
Cc: rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: linux-pm@vger.kernel.org

Hi Joel,

On 07/15/2015 11:47 AM, Joel Stanley wrote:
> Hello,
> 
> On Mon, 2015-07-13 at 19:39 +0530, Shilpasri G Bhat wrote:
>> diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
>> index d0c18c9..1f59958 100644
>> --- a/drivers/cpufreq/powernv-cpufreq.c
>> +++ b/drivers/cpufreq/powernv-cpufreq.c
>> @@ -414,6 +415,71 @@ static struct notifier_block powernv_cpufreq_reboot_nb = {
>>  	.notifier_call = powernv_cpufreq_reboot_notifier,
>>  };
>>  
>> +static char throttle_reason[][30] = {
>> +					"No throttling",
>> +					"Power Cap",
>> +					"Processor Over Temperature",
>> +					"Power Supply Failure",
>> +					"Over Current",
>> +					"OCC Reset"
>> +				     };
>> +
>> +static int powernv_cpufreq_occ_msg(struct notifier_block *nb,
>> +				   unsigned long msg_type, void *_msg)
>> +{
>> +	struct opal_msg *msg = _msg;
>> +	struct opal_occ_msg omsg;
>> +
>> +	if (msg_type != OPAL_MSG_OCC)
>> +		return 0;
>> +
>> +	memcpy(&omsg, msg->params, sizeof(omsg));
> 
> You need to ensure the of the members of struct opal_occ_msg are in the
> correct byte order when copying them over.
> 
> Have you tested this code with in a little endian configuration?

Ah yes this wont work in LE.
I tested the below diff in both BE/LE configuration on Power8 box which has FSP.

-       memcpy(&omsg, msg->params, sizeof(omsg));
+       omsg.type = be64_to_cpu(msg->params[0]);
+       omsg.chip = be64_to_cpu(msg->params[1]);
+       omsg.throttle_status = be64_to_cpu(msg->params[2]);
> 
> Do the messages you're sending make sense for a system that has a BMC
> instead of a FSP?

For a system with BMC, only OCC_THROTTLE will be received by the host. The
remaining two (OCC_RESET and OCC_LOAD) are sent only in FSP based systems.
OCC_THROTTLE is sent by opal which polls on the throttle_status byte in the
OPAL-OCC shared memory region.

> 
> Cheers,
> 
> Joel
> 

Thanks and Regards,
Shilpa
