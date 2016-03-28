From: Prarit Bhargava <prarit@redhat.com>
Subject: Re: [PATCH 0/3] idle, Honor Hardware Disabled States
Date: Mon, 28 Mar 2016 10:48:25 -0400
Message-ID: <56F94439.3000908@redhat.com>
References: <1458564569-19672-1-git-send-email-prarit@redhat.com>	<CAJvTdKk0qsFsN7RPQGVQ7mWbd2N9jW7kZbH4htSnMBxvwo8M2w@mail.gmail.com>	<56F32BDB.1010107@redhat.com> <CAJvTdKmi2pfE+fn5-MVd8T5_0j+EbASJ992AYmVKG2osk762yQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56658 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752413AbcC1Os1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 28 Mar 2016 10:48:27 -0400
In-Reply-To: <CAJvTdKmi2pfE+fn5-MVd8T5_0j+EbASJ992AYmVKG2osk762yQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, Borislav Petkov <bp@suse.de>, Andi Kleen <ak@linux.intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Dasaratharaman Chandramouli <dasaratharaman.chandramouli@intel.com>, Linux PM list <linux-pm@vger.kernel.org>



On 03/24/2016 05:54 PM, Len Brown wrote:
> On Wed, Mar 23, 2016 at 7:50 PM, Prarit Bhargava <prarit@redhat.com> wrote:
>>
>>
>> On 03/23/2016 04:05 PM, Len Brown wrote:
>>> This patch assumes that if a package state is disabled,
>>> the corresponding core state must be disabled.
>>> That assumption is false.
>>> Indeed, that is a very popular and useful configuration.
>>>
>>> But even if that were not the case, this software is not necessary,
>>> since the hardware handles demotion "c-state clipping" automatically.
>>>
>>> Yes, there is a case where a certain version of a certain processor
>>> has broken demotion, but this isn't the right fix for that.
>>> The right fix for that is here:
>>>
>>> https://bugzilla.kernel.org/show_bug.cgi?id=109081
>>
>> Len, should I rebase on top of this?  Would that work for you?
> 
> 
> I guess I wasn't clear.
> I don't see the benefit of your patch.
> Please explain it to me.
> 

Len,

Your patch does

+	skl_cstates[5].disabled = 1;	/* C8-SKL */
+	skl_cstates[6].disabled = 1;	/* C9-SKL */

and I don't think that is correct for SKY-H.

Your patch does not take into account that the states are explicitly disabled
in MSR_NHM_SNB_PKG_CST_CFG_CTL.  That is the problem here and what you've done
is simply hammered a disable into those states.

Additionally, your patch does not show the user the correct state information:

    [root@dhcp40-125 ~]# egrep ^ /sys/devices/system/cpu/cpu0/cpuidle/state?/disable
    /sys/devices/system/cpu/cpu0/cpuidle/state0/disable:1:0
    /sys/devices/system/cpu/cpu0/cpuidle/state1/disable:1:0
    /sys/devices/system/cpu/cpu0/cpuidle/state2/disable:1:0
    /sys/devices/system/cpu/cpu0/cpuidle/state3/disable:1:0
    /sys/devices/system/cpu/cpu0/cpuidle/state4/disable:1:0
    /sys/devices/system/cpu/cpu0/cpuidle/state5/disable:1:0
    /sys/devices/system/cpu/cpu0/cpuidle/state6/disable:1:0
    /sys/devices/system/cpu/cpu0/cpuidle/state7/disable:1:0 << should be 1
    /sys/devices/system/cpu/cpu0/cpuidle/state8/disable:1:0 << should be 1

The fix is to honour the settings in MSR_NHM_SNB_PKG_CST_CFG_CTL.  I cannot say
for certain that ALL SKY-H are impacted (you are admittedly in better position
to say so or not).  I can say that on the 2 systems tested here the
MSR_NHM_SNB_PKG_CST_CFG_CTL do have the appropriate disable value set.

/me could be missing some important info  -- again, perhaps there are some
SKY-H's out there that do not have states disabled in
MSR_NHM_SNB_PKG_CST_CFG_CTL, and that's why I've proposed rebasing on top of
your change.

P.


> thanks,
> -Len
> 
