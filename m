From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Subject: Re: [PATCH v5 2/6] powerpc/powernv: Add definition of OPAL_MSG_OCC
 message type
Date: Mon, 10 Aug 2015 13:01:22 +0530
Message-ID: <55C8534A.5040904@linux.vnet.ibm.com>
References: <1437033863-15864-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com> <1437033863-15864-3-git-send-email-shilpa.bhat@linux.vnet.ibm.com> <m31tfcf0td.fsf@oc8180480414.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <m31tfcf0td.fsf@oc8180480414.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Stewart Smith <stewart@linux.vnet.ibm.com>
Cc: rjw@rjwysocki.net, joel@jms.id.au, viresh.kumar@linaro.org, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
List-Id: linux-pm@vger.kernel.org

Hi Stewart,

On 08/10/2015 05:53 AM, Stewart Smith wrote:
> Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com> writes:
>> Add OPAL_MSG_OCC message definition to opal_message_type to receive
>> OCC events like reset, load and throttled. Host performance can be
>> affected when OCC is reset or OCC throttles the max Pstate.
>> We can register to opal_message_notifier to receive OPAL_MSG_OCC type
>> of message and report it to the userspace so as to keep the user
>> informed about the reason for a performance drop in workloads.
>>
>> The reset and load OCC events are notified to kernel when FSP sends
>> OCC_RESET and OCC_LOAD commands.  Both reset and load messages are
>> sent to kernel on successful completion of reset and load operation
>> respectively.
> 
> How is this done on OpenPower systems? Explanation involving just what
> OPAL does is likely better, rather than explaining in context of FSP,
> which Linux has no real knowledge of (OPAL provides all abstraction of
> it).
> 

In OpenPower systems, opal will only send OCC throttled event. OCC reset
and load messages are not sent to kernel.

How about the following git log message?

Add OPAL_MSG_OCC message definition to opal_message_type to receive
OCC events like reset, load and throttled. Host performance can be
affected when OCC is reset or OCC throttles the max Pstate.  We can
register to opal_message_notifier to receive OPAL_MSG_OCC type of
message and report it to the userspace so as to keep the user informed
about the reason for a performance drop in workloads.

Opal will send reset and load events to kernel on successful
completion of reset and load operation of OCC. During this duration
the cpu frequency will be throttled until OCC is started. Opal will
send a throttle message during the OCC reset-cycle to indicate that
OCC is active.

Opal will send throttle message to kernel when OCC is active to
indicate that the Pmax of the chip is reduced. The chip_id and
throttle reason for reducing Pmax is queued along with the message.

Thanks and Regards,
Shilpa
