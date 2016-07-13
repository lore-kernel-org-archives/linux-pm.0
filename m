From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] PM / hibernate: Introduce snapshot test mode for hibernation
Date: Thu, 14 Jul 2016 00:18:28 +0200
Message-ID: <CAJZ5v0g5EC7gnYUpxnNUTOZhLP+xQxpWAcZYmKfZkq35xziotg@mail.gmail.com>
References: <1467873658-31986-1-git-send-email-yu.c.chen@intel.com>
 <20160713095005.GA27870@amd> <578615D5.3060501@intel.com> <20160713102156.GA14505@atrey.karlin.mff.cuni.cz>
 <57861A70.9090606@intel.com> <20160713170123.GA13546@amd> <CAJZ5v0jfFFKs09sQC0Fq2iiL30tJxKtaie7tWCaczO+Dm3Aa+w@mail.gmail.com>
 <20160713202611.GA32111@amd> <CAJZ5v0hsero4EhCwjo2mz4tN4aHj=bhsgcVJUYjHF9Kem=6M6g@mail.gmail.com>
 <20160713214546.GA26692@amd> <CAJZ5v0im+eGWFKTn_BMdW34WpOKxO2P_jkzTeAHGrM1mDaGabw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35318 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751092AbcGMWSb (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 13 Jul 2016 18:18:31 -0400
In-Reply-To: <CAJZ5v0im+eGWFKTn_BMdW34WpOKxO2P_jkzTeAHGrM1mDaGabw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>, Chen Yu <yu.c.chen@intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Thu, Jul 14, 2016 at 12:00 AM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Wed, Jul 13, 2016 at 11:45 PM, Pavel Machek <pavel@ucw.cz> wrote:
>> On Wed 2016-07-13 22:44:24, Rafael J. Wysocki wrote:
>>> On Wed, Jul 13, 2016 at 10:26 PM, Pavel Machek <pavel@ucw.cz> wrote:
>>> > On Wed 2016-07-13 22:04:27, Rafael J. Wysocki wrote:
>>> >> On Wed, Jul 13, 2016 at 7:01 PM, Pavel Machek <pavel@ucw.cz> wrote:
>>> >> > Hi!
>>> >> >
>>> >> >> >>and then swapon the swap device, and do a testing. This should be safer?
>>> >> >> >Yeah, that's the way. Read-only root is other option.
>>> >> >> >
>>> >> >> >>>I guess updating documentation would be welcome from my side,
>>> >> >> >>>otherwise it should be ok.
>>> >> >> >>OK, I'll  update the documents.
>>> >> >> >Just add fat warning into the documentation.
>>> >> >> OK.
>>> >> >
>>> >> > Actually... If you could add
>>> >> >
>>> >> > printk(KERN_ALERT "Hibernation image written. If you have any
>>> >> > filesystems mounted read-write and attempt to resume, you'll corrupt
>>> >> > your data. To prevent that, remove the hibernation image.\n")
>>> >> >
>>> >> > ...I guess that would save someone's filesystem. (Yes, very high
>>> >> > loglevel. If you attempt to do this from anything else then singleuser
>>> >> > or initrd, you are asking for problems, so... lets make sure user sees
>>> >> > it.)
>>> >>
>>> >> Please see the new version of this patch:
>>> >> https://patchwork.kernel.org/patch/9226837/
>>> >
>>> > New version changes nothing, right? You still need to be sure
>>> > filesystems are not mounted r/w. So I would still like to see printk()
>>> > with warning.
>>>
>>> It shouldn't matter how they are mounted, because the contents of
>>> persistent storage don't change.
>>
>> @@ -721,6 +724,9 @@  int hibernate(void)
>>    atomic_inc(&snapshot_device_available);
>>      Unlock:
>>         unlock_system_sleep();
>>         +       if (snapshot_test)
>>         +          software_resume();
>>         +
>>                 return error;
>>                  }
>>
>> Aha, I see, immediate wakeup here. Makes sense. ... ...
>>
>> No.
>>
>> AFAICT, freezer is used in hibernation_snapshot, which means at
>> Unlock:, kernel threads are running; software_resume() freezes them
>> again, but they had chance to run and potentially corrupt the
>> persistent storage... right?
>
> OK, there is a bug.
>
> The thawing of user space is potentially dangerous, so in the
> "snapshot" test mode hibernate() should just call
> free_basic_memory_bitmaps() and from there invoke the code below the
> Check_image label in software_resume(), roughly.

Or rather call free_basic_memory_bitmaps() and
unlock_device_hotplug(), then do swsusp_check() and invoke the code
starting with the "PM: Loading hibernation image.\n" message in
software_resume().

Thanks,
Rafael
