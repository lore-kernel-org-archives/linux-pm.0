From: Jani Nikula <jani.nikula@intel.com>
Subject: Re: [Linux v4.10.0-rc1] call-traces after suspend-resume (pm? i915? cpu/hotplug?)
Date: Thu, 29 Dec 2016 11:50:42 +0200
Message-ID: <8760m33vyl.fsf@intel.com>
References: <CA+icZUVdjS8Wjjw5WxLZmv6JHV3ybFGnG8fi6TuafXDgGSV4SQ@mail.gmail.com> <20161227211329.GA8195@amd> <CA+icZUVb+zDRWV8SNVWx-U6w+i794OQ=ua4a+fTL2y5KihFAGA@mail.gmail.com> <87r34sjw29.fsf@intel.com> <CA+icZUWtOMcr0cE_S8Zbqsce1ETX2i_3hboj+suVoZSgXprZTA@mail.gmail.com> <CAJZ5v0hzUzPQGZxeU3W-jEAx6338qbNoJ7MAtwv_UtnSkXP=5w@mail.gmail.com> <CA+icZUXzuC+SxjQS=ZUYvx8f6kVjbrqUfKEa0uHKXC6a3b2=ug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CA+icZUXzuC+SxjQS=ZUYvx8f6kVjbrqUfKEa0uHKXC6a3b2=ug@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: sedat.dilek@gmail.com, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Pavel Machek <pavel@ucw.cz>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Chris Wilson <chris@chris-wilson.co.uk>, intel-gfx <intel-gfx@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, Mika Kuoppala <mika.kuoppala@linux.intel.com>, Linux PM <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 29 Dec 2016, Sedat Dilek <sedat.dilek@gmail.com> wrote:
> On Wed, Dec 28, 2016 at 11:32 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
>> On Wed, Dec 28, 2016 at 11:00 AM, Sedat Dilek <sedat.dilek@gmail.com> wrote:
>>> On Wed, Dec 28, 2016 at 9:29 AM, Jani Nikula <jani.nikula@intel.com> wrote:
>>>> On Wed, 28 Dec 2016, Sedat Dilek <sedat.dilek@gmail.com> wrote:
>>>>> On Tue, Dec 27, 2016 at 10:13 PM, Pavel Machek <pavel@ucw.cz> wrote:
>>>>>> Hi!
>>>>>>
>>>>>>> [ Add some pm | i915 | x86 folks ]
>>>>>>>
>>>>>>> Hi,
>>>>>>>
>>>>>>> I have built Linux v4.10-rc1 today on my Ubuntu/precise AMD64 system
>>>>>>> and I see some call-traces.
>>>>>>> It is reproducible on suspend and resume.
>>>>>>>
>>>>>>> I cannot say which area touches the problem or if these are several
>>>>>>> independent problems.
>>>>>>>
>>>>>>> For a full dmesg-log see attachments (my linux-config is attached, too).
>>>>>>>
>>>>>>> Here some hunks...
>>>>>>>
>>>>>>> [   29.003601] BUG: sleeping function called from invalid context at
>>>>>>> drivers/base/power/runtime.c:1032
>>>>>>> [   29.003608] in_atomic(): 1, irqs_disabled(): 0, pid: 1469, name: Xorg
>>>>>>> [   29.003610] 1 lock held by Xorg/1469:
>>>>>>> [   29.003611]  #0:  (&dev->struct_mutex){+.+.+.}, at:
>>>>>>> [<ffffffffa0623c13>] i915_mutex_lock_interruptible+0x43/0x140 [i915]
>>>>>>> [   29.003653] CPU: 0 PID: 1469 Comm: Xorg Not tainted
>>>>>>> 4.10.0-rc1-1-iniza-small #1
>>>>>>> [   29.003655] Hardware name: SAMSUNG ELECTRONICS CO., LTD.
>>>>>>> 530U3BI/530U4BI/530U4BH/530U3BI/530U4BI/530U4BH, BIOS 13XK 03/28/2013
>>>>>>> [   29.003656] Call Trace:
>>>>>>
>>>>>> Just a note, at least 2 machines here refuse to resume with
>>>>>> v4.10-rc1. One has intel graphics, one has AMD. It may or may not have
>>>>>> common cause...
>>>>>>
>>>>>
>>>>> [ Correct linux-pm ML and add Mika & Jani ]
>>>>>
>>>>> Thanks for the feedback.
>>>>>
>>>>> There are some cpu/hotplug fixes post-v4.10-rc1.
>>>>> Give that a try.
>>>>>
>>>>> Yesterday, after answers from drm-intel folks I have seen that a
>>>>> cpu/hotplug commit [1] was reverted in
>>>>> drm-intel.git#drm-intel-nightly.
>>>>> I haven't tried that.
>>>>>
>>>>> It's good when Thomas knows of this and gets in contact with drm-intel folks.
>>>>>
>>>>> Regards,
>>>>> - Sedat -
>>>>>
>>>>> [1] https://cgit.freedesktop.org/drm-intel/commit/?h=drm-intel-nightly&id=e558f178f5390185b7324ff4b816b52c6ae3a928
>>>>> [2] https://cgit.freedesktop.org/drm-intel/log/?h=drm-intel-nightly
>>>>>
>>>>> P.S.: Revert "cpu/hotplug: Prevent overwriting of callbacks"
>>>>>
>>>>> This reverts commit dc280d93623927570da279e99393879dbbab39e7
>>>>> Author: Thomas Gleixner <tglx@linutronix.de>
>>>>> Date: Wed Dec 21 20:19:49 2016 +0100
>>>>> cpu/hotplug: Prevent overwriting of callbacks
>>>>>
>>>>> It started hanging all machines in CI s3 test:
>>>>> https://intel-gfx-ci.01.org/CI/igt@gem_exec_suspend@basic-s3.html
>>>>>
>>>>> Bisected-by: Mika Kuoppala <mika.kuoppala@linux.intel.com>
>>>>> Signed-off-by: Jani Nikula <jani.nikula@intel.com>
>>>>
>>>> Thomas -
>>>>
>>>> Indeed, basically all of the boxes in the intel-gfx CI hang at the
>>>> suspend/resume test with dc280d936239 ("cpu/hotplug: Prevent overwriting
>>>> of callbacks"), and after the revert in the tree that feeds to the CI,
>>>> we're back on track.
>>>>
>>>> I found [1], was hoping to get feedback from Mika whether that helps
>>>> before reporting. Chris also suggested [2] as a quick fix but I don't
>>>> know if anyone tried that.
>>>>
>>>
>>> Hi Jani,
>>>
>>> I know you were not CCed in the original thread, please see [5].
>>>
>>> The patchset from Thomas you mention [1] does fix one of the problems
>>> I have seen, please see [6].
>>> With these post-v4.10-rc1 patches applied a clean revert of Revert
>>> "cpu/hotplug: Prevent overwriting of callbacks" is not possible.
>>>
>>> Can you give a clear statement if the quick-fix from Chris is in
>>> combination with the above revert or not?
>>> Against v4.10-rc1?
>>> Tested together with the patchset of Thomas?
>>
>> Please test the Linus' tree from today, it should work.
>>
>
> Latest Linus tree (v4.10-rc1-17-g2d706e790f05) does not fix it.

It seems to me there are more than one bug at play here.

BR,
Jani.


>
> - Sedat -

-- 
Jani Nikula, Intel Open Source Technology Center
