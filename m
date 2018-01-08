From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [BUG] s2idle: Surface Pro 3 suspend/resume issues
Date: Mon, 8 Jan 2018 12:03:00 +0100
Message-ID: <CAJZ5v0hFc931y1bFWPUgc+Ybx+YnP0sget_1PXd=DLTogzHxyg@mail.gmail.com>
References: <85be1584-5260-e7e1-2eda-23607f5a93c2@mrs.ro> <d1c1bab6e2b343abf9105a892dc06c49@mrs.ro>
 <1515399224.2578.17.camel@intel.com> <f9aed3f0e77fc7d3f663fb913e1bb5aa@mrs.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ot0-f174.google.com ([74.125.82.174]:44208 "EHLO
        mail-ot0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756423AbeAHLDB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 Jan 2018 06:03:01 -0500
Received: by mail-ot0-f174.google.com with SMTP id g59so8907417otg.11
        for <linux-pm@vger.kernel.org>; Mon, 08 Jan 2018 03:03:00 -0800 (PST)
In-Reply-To: <f9aed3f0e77fc7d3f663fb913e1bb5aa@mrs.ro>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Valentin Manea <linux-pm@mrs.ro>
Cc: Zhang Rui <rui.zhang@intel.com>, Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

On Mon, Jan 8, 2018 at 9:21 AM, Valentin Manea <linux-pm@mrs.ro> wrote:
>
> On 2018-01-08 08:13, Zhang Rui wrote:
>>
>> On Mon, 2018-01-08 at 07:55 +0000, Valentin Manea wrote:
>>>
>>> Again with correct linux-pm
>>>
>>> Hi,
>>>
>>>    Somewhere between 4.12 and 4.13 the s2idle doesn't work anymore on
>>> the
>>> Surface Pro 3.
>>
>>
>> will you please be more specific about the symptom?
>> what command do you use to do s2idle, and how do you wake it up?
>
>
> Sure, sorry for not being more specific. I tried both the DE(KDE) suspend
> functionality but also:
> echo memory  > /sys/power/state
> and the behaviour is the same: display goes dark, system is not responding -
> the power button which previously wakes up the system doesn't work anymore.
> It needs a hard reset from this point
>
> The home button has a slight vibration when device is fully running, in this
> state the vibration doesn't happen at all so I suppose it went through some
> sleep stages.
>
> For reference I tried with iommu=off booting because of another bug that
> made the rounds but that never helped. The problem seems to be in the 3
> patches I mentioned in my top email

I think what happens is that the events from the power button are
treated as spurious now.

The easiest way to debug this would be to find an alternative wakeup
device and then see what happens with the button wakeup.

Please open a BZ entry for this at bugzilla.kernel.org (in the
suspend/hibernation category) and add rjw@rjwysocki.net to the CC list
in it.  I'll get back to you then.

Thanks,
Rafael
