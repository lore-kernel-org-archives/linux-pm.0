From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [Linux v4.10.0-rc1] call-traces after suspend-resume (pm? i915? cpu/hotplug?)
Date: Wed, 28 Dec 2016 16:28:21 -0800
Message-ID: <001d01d2616a$78fefc50$6afcf4f0$@net>
References: <CA+icZUVdjS8Wjjw5WxLZmv6JHV3ybFGnG8fi6TuafXDgGSV4SQ@mail.gmail.com> <20161227211329.GA8195@amd> <CA+icZUVb+zDRWV8SNVWx-U6w+i794OQ=ua4a+fTL2y5KihFAGA@mail.gmail.com> <87r34sjw29.fsf@intel.com> <CA+icZUWtOMcr0cE_S8Zbqsce1ETX2i_3hboj+suVoZSgXprZTA@mail.gmail.com> MMlxcy4WIL5mtMMlycGjUh
Mime-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cmta19.telus.net ([209.171.16.92]:56342 "EHLO cmta19.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752252AbcL2AeA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 28 Dec 2016 19:34:00 -0500
In-Reply-To: MMlxcy4WIL5mtMMlycGjUh
Content-Language: en-ca
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "'Rafael J. Wysocki'" <rafael@kernel.org>, sedat.dilek@gmail.com, 'Thomas Gleixner' <tglx@linutronix.de>
Cc: 'Jani Nikula' <jani.nikula@intel.com>, 'Pavel Machek' <pavel@ucw.cz>, "'Rafael J. Wysocki'" <rafael.j.wysocki@intel.com>, 'Daniel Vetter' <daniel.vetter@ffwll.ch>, 'Chris Wilson' <chris@chris-wilson.co.uk>, 'intel-gfx' <intel-gfx@lists.freedesktop.org>, 'LKML' <linux-kernel@vger.kernel.org>, 'the arch/x86 maintainers' <x86@kernel.org>, 'Mika Kuoppala' <mika.kuoppala@linux.intel.com>, 'Linux PM' <linux-pm@vger.kernel.org>

On 2016.12.28 14:33 Rafael J. Wysocki wrote:
> On Wed, Dec 28, 2016 at 11:00 AM, Sedat Dilek <sedat.dilek@gmail.com> wrote:
>> On Wed, Dec 28, 2016 at 9:29 AM, Jani Nikula <jani.nikula@intel.com> wrote:
>>> On Wed, 28 Dec 2016, Sedat Dilek <sedat.dilek@gmail.com> wrote:
>>>> On Tue, Dec 27, 2016 at 10:13 PM, Pavel Machek <pavel@ucw.cz> wrote:
>>>>
>>>> P.S.: Revert "cpu/hotplug: Prevent overwriting of callbacks"
>>>>
>>>> This reverts commit dc280d93623927570da279e99393879dbbab39e7
>>>> Author: Thomas Gleixner <tglx@linutronix.de>
>>>> Date: Wed Dec 21 20:19:49 2016 +0100
>>>> cpu/hotplug: Prevent overwriting of callbacks

With respect to kernel 4.10-rc1 and the above referenced commit:

On my computer rdmsr was not working, and therefore many tools
that use it (i.e. turbostat) were also broken.

I bisected the kernel down to the same above referenced commit.
After finding some potentially related e-mails, I built a
4.10-rc1+ kernel with these:

0dad3a3 x86/mce/AMD: Make the init code more robust
b9d9d69 smp/hotplug: Undo tglxs brainfart
b4b8664 arm64: don't pull uaccess.h into *.S
7ce7d89 Linux 4.10-rc1

And now rdmsr is working fine, as is trubostat.


