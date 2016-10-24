From: Matt Ranostay <mranostay@gmail.com>
Subject: Re: [PATCH 1/2] power: bq27xxx_battery: add configurable
 poll_interval by sysfs
Date: Mon, 24 Oct 2016 12:55:17 -0700
Message-ID: <CAKzfze-4RR3=iWrfRV3=KAiQUzS-18TfFSC_p9SivSub1aOpGQ@mail.gmail.com>
References: <1474083775-30185-1-git-send-email-matt@ranostay.consulting>
 <1474083775-30185-2-git-send-email-matt@ranostay.consulting>
 <20161007184910.GF19976@amd> <CAKzfze95nJMcRU2=FivDa72MX4P0md1VoWbUjUnt-75Vs_ektQ@mail.gmail.com>
 <20161024195151.GA5989@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34537 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S938739AbcJXTz7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Oct 2016 15:55:59 -0400
In-Reply-To: <20161024195151.GA5989@amd>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: "Andrew F . Davis" <afd@ti.com>, Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Matt Ranostay <matt@ranostay.consulting>

On Mon, Oct 24, 2016 at 12:51 PM, Pavel Machek <pavel@ucw.cz> wrote:
> On Sun 2016-10-23 20:08:22, Matt Ranostay wrote:
>> On Fri, Oct 7, 2016 at 11:49 AM, Pavel Machek <pavel@ucw.cz> wrote:
>> > On Fri 2016-09-16 20:42:54, Matt Ranostay wrote:
>> >> Allow the poll_interval to be runtime configurable via an sysfs entry.
>> >> This is needed for udev control of the poll interval.
>> >>
>> >> Signed-off-by: Matt Ranostay <matt@ranostay.consulting>
>> >
>> > working mail address would be nice here.
>> >
>> > sysfs files should be documented.
>> >
>>
>> Ok can do in next revision
>>
>> > Also... what is it good for?
>> >
>> > Do you have a device that needs non-standard interval?
>>
>> Basically we need to have the ability to dynamically change the
>> intervals. So closer to a battery drain we need to up the reporting
>> intervals.
>
> Umm, there seems to be mechanism there to change that already...?
>

Ah right. Commenting on the wrong patchset oops :).

> static const struct kernel_param_ops param_ops_poll_interval = {
>         .get = param_get_uint,
>         .set = poll_interval_param_set,
> };
>
>
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
