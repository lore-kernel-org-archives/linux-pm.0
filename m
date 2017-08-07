From: AceLan Kao <acelan.kao@canonical.com>
Subject: Re: [PATCH] intel-vbtn: match power button on press rather than release
Date: Mon, 7 Aug 2017 08:59:30 +0800
Message-ID: <CAFv23QnYwe5Foms1Ck8-hHKnftxNLN0K3L3waVrprbd2MUgSKw@mail.gmail.com>
References: <1501866006-24811-1-git-send-email-mario.limonciello@dell.com>
 <11471111.T3jHVeqpMT@aspire.rjw.lan> <20170805205753.GA1277@fury>
 <1700343.1Fm4iKlbcW@aspire.rjw.lan> <20170806232418.GA29692@fury> <CAJZ5v0g3v=fQ79P1WG-L7imNBMuvh30uHz0GcAnZJcwFKptYvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0g3v=fQ79P1WG-L7imNBMuvh30uHz0GcAnZJcwFKptYvQ@mail.gmail.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Darren Hart <dvhart@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mario Limonciello <mario.limonciello@dell.com>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, Len Brown <lenb@kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

Looks like I'm one hour late to ack the patch.
Thanks any way for the quick response.

2017-08-07 8:38 GMT+08:00 Rafael J. Wysocki <rafael@kernel.org>:
> On Mon, Aug 7, 2017 at 1:24 AM, Darren Hart <dvhart@infradead.org> wrote:
>> On Sun, Aug 06, 2017 at 12:20:22AM +0200, Rafael Wysocki wrote:
>>> On Saturday, August 5, 2017 10:57:53 PM CEST Darren Hart wrote:
>>> > On Sat, Aug 05, 2017 at 01:30:20AM +0200, Rafael Wysocki wrote:
>>> > > On Friday, August 4, 2017 7:29:53 PM CEST Darren Hart wrote:
>>> > > > On Fri, Aug 04, 2017 at 12:00:06PM -0500, Mario Limonciello wrote:
>>> > > > > This fixes a problem where the system gets stuck in a loop
>>> > > > > unable to wakeup via power button in s2idle.
>>> > > > >
>>> > > > > The problem happens because:
>>> > > > >  - press power button:
>>> > > > >    - system emits 0xc0 (power press), event ignored
>>> > > > >    - system emits 0xc1 (power release), event processed,
>>> > > > >      emited as KEY_POWER
>>> > > > >    - set wakeup_mode to true
>>> > > > >    - system goes to s2idle
>>> > > > >  - press power button
>>> > > > >    - system emits 0xc0 (power press), wakeup_mode is true,
>>> > > > >      system wakes
>>> > > > >    - system emits 0xc1 (power release), event processed,
>>> > > > >      emited as KEY_POWER
>>> > > > >    - system goes to s2idle again
>>> > > > >
>>> > > > > To avoid this situation, process the presses (which matches what
>>> > > > > intel-hid does too).
>>> > > > >
>>> > > > > Verified on an Dell XPS 9365
>>> > > > >
>>> > > > > Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
>>> > > >
>>> > > > This looks good to me - responding to the release is non-intuitive IMHO
>>> > > > anyway.  I'd like to see agreement from AceLan, but this should go into
>>> > > > the 4.13 rc cycle (at rc3 currently).
>>> > >
>>> > > Yes, it should, and I'm not sure if the original author's opinion matters here.
>>> > >
>>> > > The patch makes sense to everyone involved and fixes an annoying issue, so
>>> > > I don't see any real arguments against applying it.
>>> > >
>>> > > Please feel free to add my ACK to it if that helps.
>>> >
>>> > I always try to give those in MAINTAINERS a chance to respond, but I will queue
>>> > this up to fixes now.
>>>
>>> Thanks!
>>
>> Rafael,
>>
>> Merged to mainline (in case you were waiting on this for the dependent
>> patch you mentioned).
>
> Awesome, thanks!
