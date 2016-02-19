From: Ryan <ryanphilips19@googlemail.com>
Subject: Re: suspend resume query
Date: Sat, 20 Feb 2016 01:27:30 +0530
Message-ID: <CANMsd01ZDQACG0Hn6_eNVUcxx1e4C3BdbwZ1+2raUZ34wXENzA@mail.gmail.com>
References: <CANMsd03Y67iVEtUZaWnjywNxVVSvmpQfh72y8uJeqqgP=PrH=g@mail.gmail.com>
	<1455700241.7626.10.camel@suse.com>
	<CANMsd02oPfRZ4dRRF8R61VtN+h62ROfmNCDK=NohKjYWhOL4Hg@mail.gmail.com>
	<1455702015.7626.13.camel@suse.com>
	<CANMsd03xShJ4hMajaahTaSQfZyCww+9me-e7X3F2=z1oUPN0Cg@mail.gmail.com>
	<1455703562.7626.14.camel@suse.com>
	<CAN2waFtS2cuWw2oY54-DQN_Nt5c=YvXg9nEn2x4vhzZMru9Vrw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ig0-f180.google.com ([209.85.213.180]:36677 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752369AbcBST5a (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 19 Feb 2016 14:57:30 -0500
Received: by mail-ig0-f180.google.com with SMTP id xg9so42254831igb.1
        for <linux-pm@vger.kernel.org>; Fri, 19 Feb 2016 11:57:30 -0800 (PST)
In-Reply-To: <CAN2waFtS2cuWw2oY54-DQN_Nt5c=YvXg9nEn2x4vhzZMru9Vrw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhaoyang Huang <zhaoyang.huang@linaro.org>
Cc: Oliver Neukum <oneukum@suse.com>, linux-pm@vger.kernel.org

Hi zhaoyang,

On Thu, Feb 18, 2016 at 12:24 PM, Zhaoyang Huang
<zhaoyang.huang@linaro.org> wrote:
> Hi Ryan,
> As we already known, STR will let all cores power down after store the
> context(GPR, idmap_gpd, sp etc) of primary core in DDR. It is
> different between ARMv7 and ARMv8
> For ARMv7,
> The boot vector can just be located in 0x00000000 or 0xffff0000, which
> is chosen by sampling VINITHI domain within PMU register during
> bootup. For some SOCs, one of them is used for cold boot while another
> is used for recover from STR or CPU IDLE, which is referred as warm
> reset. For this scenario, an AON RAM is usually placed in one of the
> region mentioned above. Meanwhile, the vendor will place some code
> there for bring the core back to the context where it is powered down.
>

I understand that, when the wakeup interrupt arrives - it is not
actually an interrupt but
a reset which executes the code from 0x00000000 and then what happens?

Does it execute the Boot rom and bootloaders all over again - this
does not happen right?

My Question is what happens when the wakeup interrupt arrives and how
is it related to
bootloaders/booting process.

>From what i understand - Warm restart is when the reboot command is
issues. How different
is it from cpuidle wakeup or suspend 2 ram wakeup.


Thanks for your help.



> For ARMv8,
> All things are covered by PSCI, you can refer the process from ARM's archive.
>
> On 17 February 2016 at 18:06, Oliver Neukum <oneukum@suse.com> wrote:
>> On Wed, 2016-02-17 at 15:19 +0530, Ryan wrote:
>>> Suspend to ram. I am sorry - I did not provide complete information.
>>
>> STR on ARM is peculiar. I have no idea.
>>
>>         Sorry
>>                 Oliver
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
