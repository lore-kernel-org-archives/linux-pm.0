From: Sedat Dilek <sedat.dilek@gmail.com>
Subject: Re: [Linux v4.10.0-rc1] call-traces after suspend-resume (pm? i915? cpu/hotplug?)
Date: Wed, 28 Dec 2016 09:07:13 +0100
Message-ID: <CA+icZUVb+zDRWV8SNVWx-U6w+i794OQ=ua4a+fTL2y5KihFAGA@mail.gmail.com>
References: <CA+icZUVdjS8Wjjw5WxLZmv6JHV3ybFGnG8fi6TuafXDgGSV4SQ@mail.gmail.com>
 <20161227211329.GA8195@amd>
Reply-To: sedat.dilek@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ua0-f193.google.com ([209.85.217.193]:34046 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750895AbcL1IHO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Dec 2016 03:07:14 -0500
In-Reply-To: <20161227211329.GA8195@amd>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Chris Wilson <chris@chris-wilson.co.uk>, Thomas Gleixner <tglx@linutronix.de>, intel-gfx <intel-gfx@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, Mika Kuoppala <mika.kuoppala@linux.intel.com>, Jani Nikula <jani.nikula@intel.com>, linux-pm@vger.kernel.org

On Tue, Dec 27, 2016 at 10:13 PM, Pavel Machek <pavel@ucw.cz> wrote:
> Hi!
>
>> [ Add some pm | i915 | x86 folks ]
>>
>> Hi,
>>
>> I have built Linux v4.10-rc1 today on my Ubuntu/precise AMD64 system
>> and I see some call-traces.
>> It is reproducible on suspend and resume.
>>
>> I cannot say which area touches the problem or if these are several
>> independent problems.
>>
>> For a full dmesg-log see attachments (my linux-config is attached, too).
>>
>> Here some hunks...
>>
>> [   29.003601] BUG: sleeping function called from invalid context at
>> drivers/base/power/runtime.c:1032
>> [   29.003608] in_atomic(): 1, irqs_disabled(): 0, pid: 1469, name: Xorg
>> [   29.003610] 1 lock held by Xorg/1469:
>> [   29.003611]  #0:  (&dev->struct_mutex){+.+.+.}, at:
>> [<ffffffffa0623c13>] i915_mutex_lock_interruptible+0x43/0x140 [i915]
>> [   29.003653] CPU: 0 PID: 1469 Comm: Xorg Not tainted
>> 4.10.0-rc1-1-iniza-small #1
>> [   29.003655] Hardware name: SAMSUNG ELECTRONICS CO., LTD.
>> 530U3BI/530U4BI/530U4BH/530U3BI/530U4BI/530U4BH, BIOS 13XK 03/28/2013
>> [   29.003656] Call Trace:
>
> Just a note, at least 2 machines here refuse to resume with
> v4.10-rc1. One has intel graphics, one has AMD. It may or may not have
> common cause...
>

[ Correct linux-pm ML and add Mika & Jani ]

Thanks for the feedback.

There are some cpu/hotplug fixes post-v4.10-rc1.
Give that a try.

Yesterday, after answers from drm-intel folks I have seen that a
cpu/hotplug commit [1] was reverted in
drm-intel.git#drm-intel-nightly.
I haven't tried that.

It's good when Thomas knows of this and gets in contact with drm-intel folks.

Regards,
- Sedat -

[1] https://cgit.freedesktop.org/drm-intel/commit/?h=drm-intel-nightly&id=e558f178f5390185b7324ff4b816b52c6ae3a928
[2] https://cgit.freedesktop.org/drm-intel/log/?h=drm-intel-nightly

P.S.: Revert "cpu/hotplug: Prevent overwriting of callbacks"

This reverts commit dc280d93623927570da279e99393879dbbab39e7
Author: Thomas Gleixner <tglx@linutronix.de>
Date: Wed Dec 21 20:19:49 2016 +0100
cpu/hotplug: Prevent overwriting of callbacks

It started hanging all machines in CI s3 test:
https://intel-gfx-ci.01.org/CI/igt@gem_exec_suspend@basic-s3.html

Bisected-by: Mika Kuoppala <mika.kuoppala@linux.intel.com>
Signed-off-by: Jani Nikula <jani.nikula@intel.com>

- EOT -
