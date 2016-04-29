From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 0/3] idle, Honor Hardware Disabled States
Date: Fri, 29 Apr 2016 05:36:25 -0400
Message-ID: <CAJvTdK=tuqYo_YaOFCTZZbF9VWGo1CjqXSavod4LKb3vNfBS2w@mail.gmail.com>
References: <1458564569-19672-1-git-send-email-prarit@redhat.com>
	<CAJvTdKk0qsFsN7RPQGVQ7mWbd2N9jW7kZbH4htSnMBxvwo8M2w@mail.gmail.com>
	<56F32BDB.1010107@redhat.com>
	<CAJvTdKmi2pfE+fn5-MVd8T5_0j+EbASJ992AYmVKG2osk762yQ@mail.gmail.com>
	<56F94439.3000908@redhat.com>
	<CAJvTdKmmoZFJ83dx6vS6D8FasrHKdgpxMEC_rVM-_6tZe2s6dg@mail.gmail.com>
	<570B8C7E.2030504@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f66.google.com ([209.85.215.66]:35503 "EHLO
	mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751303AbcD2Jg1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 29 Apr 2016 05:36:27 -0400
In-Reply-To: <570B8C7E.2030504@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Prarit Bhargava <prarit@redhat.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, Borislav Petkov <bp@suse.de>, Andi Kleen <ak@linux.intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Dasaratharaman Chandramouli <dasaratharaman.chandramouli@intel.com>, Linux PM list <linux-pm@vger.kernel.org>

On Mon, Apr 11, 2016 at 7:37 AM, Prarit Bhargava <prarit@redhat.com> wrote:
>
>
> On 03/31/2016 12:59 AM, Len Brown wrote:
>>> Len,
>>>
>>> Your patch does
>>>
>>> +       skl_cstates[5].disabled = 1;    /* C8-SKL */
>>> +       skl_cstates[6].disabled = 1;    /* C9-SKL */
>>>
>>> and I don't think that is correct for SKY-H.
>>
>> For https://bugzilla.kernel.org/show_bug.cgi?id=109081
>> it is correct.
>>
>>> Your patch does not take into account that the states are explicitly disabled
>>> in MSR_NHM_SNB_PKG_CST_CFG_CTL.  That is the problem here and what you've done
>>> is simply hammered a disable into those states.
>>
>> ENOPARSE.
>> Are we talking about the failure in
>> https://bugzilla.kernel.org/show_bug.cgi?id=109081
>> or a different problem?
>>
>
> I see now.  There are two bugs.  The first is your case where the deep c-states
> should be disabled but are not disabled, and the my case where the states *are*
> disabled but not indicated as such in sysfs.
>
>>>
>>> Additionally, your patch does not show the user the correct state information:
>>>
>>>     [root@dhcp40-125 ~]# egrep ^
> /sys/devices/system/cpu/cpu0/cpuidle/state?/disable
>>>     /sys/devices/system/cpu/cpu0/cpuidle/state0/disable:1:0
>>>     /sys/devices/system/cpu/cpu0/cpuidle/state1/disable:1:0
>>>     /sys/devices/system/cpu/cpu0/cpuidle/state2/disable:1:0
>>>     /sys/devices/system/cpu/cpu0/cpuidle/state3/disable:1:0
>>>     /sys/devices/system/cpu/cpu0/cpuidle/state4/disable:1:0
>>>     /sys/devices/system/cpu/cpu0/cpuidle/state5/disable:1:0
>>>     /sys/devices/system/cpu/cpu0/cpuidle/state6/disable:1:0
>>>     /sys/devices/system/cpu/cpu0/cpuidle/state7/disable:1:0 << should be 1
>>>     /sys/devices/system/cpu/cpu0/cpuidle/state8/disable:1:0 << should be 1
>>
>> the 'disabled' attribute you see in sysfs is not
>> struct cpuidle_state.disabled
>> it is
>> struct cpuidle_state_usage.disabled
>
> Yes.  I know that.  But the problem is that your patch should take that
> into account.

When the patch to disable C8/C9 takes effect,
cpuidle_state.disabled is at intel_idle initizliation time.
That causes it to skip registering C8/C9 with cpuidle.
So  those states  do not appear in sysfs
and so cpuidle_state_usage.disabled does not exist for them.

In the example above, the patch to disable C8/C9 was not invoked,
or else C8 would not be present in sysfs at all.

>>> The fix is to honour the settings in MSR_NHM_SNB_PKG_CST_CFG_CTL.  I cannot say
>>> for certain that ALL SKY-H are impacted (you are admittedly in better position
>>> to say so or not).  I can say that on the 2 systems tested here the
>>> MSR_NHM_SNB_PKG_CST_CFG_CTL do have the appropriate disable value set.
>>>
>>> /me could be missing some important info  -- again, perhaps there are some
>>> SKY-H's out there that do not have states disabled in
>>> MSR_NHM_SNB_PKG_CST_CFG_CTL, and that's why I've proposed rebasing on top of
>>> your change.
>>
>> Do you see this debug message when you run current upstream on this hardware?
>>
>>                 /* if state marked as disabled, skip it */
>>                 if (cpuidle_state_table[cstate].disabled != 0) {
>>                         pr_debug(PREFIX "state %s is disabled",
>>                                 cpuidle_state_table[cstate].name);
>>                         continue;
>>                 }
>>
>>
>> If no, then my patch is not disabling C8/C9 on your system.
>>
>> Also, if it were, the code above causes the states to not appear
>> at all in sysfs, because they are not registered.
>>
>> Re: MSR_NHM_SNB_PKG_CST_CFG_CTL
>>
>> if PC10 is disabled there, then functionally, it doesn't matter what we do,
>> which is why my patch does nothing when PC10 is disabled.
>>
>> In such a scenario, pc10 presence in sysfs (and cpufreq)
>> is cosmetic.  The hardware knows what to do.
>>
>> Do you think that cosmetic issue is worth dealing with?
>
> The bug reported is that the system will not go into the deep
> c-states.  This is because the c-states are disabled by hardware.  This
> means that turbostat shows only transitions to C7, while sysfs (and the
> monitoring software) indicates deeper c-states are available.
> So yes, I do think that it is worth dealing with.

Please reply with the URL of the bug you are referring to.

Note that somebody who looks in just sysfs will be dumb and happy - as
it will show
what states were requested, and everything will be requested, eventually...

Somebody who looks at turbostat output will sometimes see columns that are 0%,
as it is showing the underlying HW residency counters.  There is also
a line at the top that decodes pkg-cstate-limit, which may or may not
explain why those columns are 0.

So the most useful way to pretty this up would be for turbostat to assume that
users don't understand the pkg-cstate-limit decoding, and to hide
disabled columns.
Sure, I can do that.

Yes, we could delete the redundant states from cpuidle, but on current HW,
we can only do it for package states that have no corresponding core state.
eg. PC8, PC9, PC10.  This will have no effect on the operation of the hardware,
but I agree it would look more tidy to a user who is under the impression
that the counters in sysfs reflect closely what the hardware is doing,
rather than the permission that Linux is giving the HW to do.

But above is all cosmetic.  The real "bug" that users are running into is
that they can't get into deep c-states when they are enabled.
Linux (and Intel) need to do a much better job enabling diagnosis of
that condition.

Len Brown, Intel Open Source Technology Center
