From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/2] cpufreq: powernv: Register for OCC related opal_message
 notification
Date: Tue, 28 Apr 2015 11:06:17 +0530
Message-ID: <553F1C51.4060901@linux.vnet.ibm.com>
References: <1429722265-2953-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com> <1429722265-2953-2-git-send-email-shilpa.bhat@linux.vnet.ibm.com> <CAKohpo=8m=PAof-AF2AQ+rMu-0bF8CvGywb-YaN=u3sJXjLvnw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e23smtp03.au.ibm.com ([202.81.31.145]:58055 "EHLO
	e23smtp03.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751348AbbD1FhN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 28 Apr 2015 01:37:13 -0400
Received: from /spool/local
	by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <shilpa.bhat@linux.vnet.ibm.com>;
	Tue, 28 Apr 2015 15:37:11 +1000
In-Reply-To: <CAKohpo=8m=PAof-AF2AQ+rMu-0bF8CvGywb-YaN=u3sJXjLvnw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

Hi Viresh,

On 04/27/2015 10:02 AM, Viresh Kumar wrote:
> On 22 April 2015 at 22:34, Shilpasri G Bhat
> <shilpa.bhat@linux.vnet.ibm.com> wrote:
>> diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
> 
>> +static char throttle_reason[6][50] = { "No throttling",
> 
> Don't need to mention 6 here.
> 
> And the max length you need right now is 27, so maybe s/50/30 ?
> 
> Also, start 'No Throttling' in a new line, like below.

Will do.
> 
>> +                                       "Power Cap",
>> +                                       "Processor Over Temperature",
>> +                                       "Power Supply Failure",
>> +                                       "OverCurrent",
> 
> s/OverCurrent/Over Current/ ?

Okay.
> 
>> +                                       "OCC Reset"
>> +                                    };
>> +
>> +static int powernv_cpufreq_occ_msg(struct notifier_block *nb,
>> +               unsigned long msg_type, void *msg)
>> +{
>> +       struct opal_msg *occ_msg = msg;
>> +       uint64_t token;
>> +       uint64_t chip_id, reason;
>> +
>> +       if (msg_type != OPAL_MSG_OCC)
>> +               return 0;
> 
> Blank line here.

Okay
> 
>> +       token = be64_to_cpu(occ_msg->params[0]);
> 
> Here as well..
> 
>> +       switch (token) {
>> +       case 0:
>> +               occ_reset = true;
>> +               /*
>> +                * powernv_cpufreq_throttle_check() is called in
>> +                * target() callback which can detect the throttle state
>> +                * for governors like ondemand.
>> +                * But static governors will not call target() often thus
>> +                * report throttling here.
>> +                */
> 
> Now, do I understand correctly that this notifier will be called as
> soon as we switch throttling state ?
> 
> If yes, then do we still need the throttle_check() routine you added
> earlier ? Maybe not.

We cannot remove throttle_check() routine for the following reasons:
1) To report old firmware bugs which do not restore frequency control to host
after an OCC reset.
2) In BMC based boxes if OCC crashes currently firmware will not send 'reset'
and 'load' messages, in such cases throttle_check() will be sufficient to
monitor a throttled state caused by 'reset'.
3) Throttle reporting in old firmwares which do not have this notification.

> 
>> +               if (!throttled) {
>> +                       throttled = true;
>> +                       pr_crit("CPU Frequency is throttled\n");
>> +               }
>> +               pr_info("OCC in Reset\n");
>> +               break;
>> +       case 1:
>> +               pr_info("OCC is Loaded\n");
>> +               break;
>> +       case 2:
>> +               chip_id = be64_to_cpu(occ_msg->params[1]);
>> +               reason = be64_to_cpu(occ_msg->params[2]);
> 
> Blank line here.

Okay
> 
>> +               if (occ_reset) {
>> +                       occ_reset = false;
>> +                       throttled = false;
>> +                       pr_info("OCC is Active\n");
>> +                       /* Sanity check for static governors */
>> +                       powernv_cpufreq_throttle_check(smp_processor_id());
>> +               } else if (reason) {
>> +                       throttled = true;
>> +                       pr_info("Pmax reduced due to %s on chip %x\n",
>> +                                       throttle_reason[reason], (int)chip_id);
>> +               } else {
>> +                       throttled = false;
>> +                       pr_info("%s on chip %x\n",
>> +                                       throttle_reason[reason], (int)chip_id);
>> +               }
> 
> Run checkpatch with --strict option, and you will see some warnings.

Okay will do.

Thanks and Regards,
Shilpa

