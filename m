From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] intel_idle: work around errate VLP52 on Baytrail CPUs
Date: Tue, 27 Dec 2016 16:27:59 -0500
Message-ID: <CAJvTdKkJv+WfvvibR9Ly9AS5ncp1UTsm74XMX=pg8uyV9Mxupw@mail.gmail.com>
References: <838trb233m.fsf@echidna.jochen.org> <CAJZ5v0jkATWSrGuR_DOfiSUFguRJ1w7gMRth1kjwYh1bSWnvGw@mail.gmail.com>
 <CA+8K-g=fXN9TWWxkV1AEEjXJLhwJEQ2PB434gKQ9Z7bL=yf+zA@mail.gmail.com>
 <CA+8K-g=VVC-13J+jU+KGyk49xHPhm5uojj0h9FcWZiC91NTiQw@mail.gmail.com>
 <CAJvTdK=sFHRo3FQ-ebWM7qVY3iLadWUFA+iacB8jwfHtJyNWGA@mail.gmail.com> <83ful9yue7.fsf@echidna.jochen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f195.google.com ([209.85.220.195]:35502 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753189AbcL0V2B (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Dec 2016 16:28:01 -0500
Received: by mail-qk0-f195.google.com with SMTP id u25so29590975qki.2
        for <linux-pm@vger.kernel.org>; Tue, 27 Dec 2016 13:28:00 -0800 (PST)
In-Reply-To: <83ful9yue7.fsf@echidna.jochen.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jochen Hein <jochen@jochen.org>
Cc: Vincent Gerris <vgerris@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Hans de Goede <hdegoede@redhat.com>

It is not possible for Linux to enter idle from within an interrupt handler.
Thus, it is not possible for the cited errata to be the root cause of
this problem.

> - all I can say is that for all Kernels < 4.9 I
> had to disable C6 to have a stable system.
> 4.9 seems stable for me now.

Linux-4.9 does not contain the patch do disable c6 on BYT.
And so that patch can not be the reason for the reported change in stability.

I understand that this stability problem is difficult to get one's
hands around --
many have reported that it was gone, only to later report that it
wasn't really gone...

If you have something that can quickly determine if the problem is present
or if the problem is gone, that would be extremely valuable.

It would also be very interesting to know what C-states are actually
being used on your particular platform.  For example, your patch
disabled c6, but did not disable c7.  I would be interested to know
on a ststem such as yours, if disabling c67 was sufficient, and
if the platform was still able to make use of c7.

You can see if you are actually using c7 by running turbostat on an idle system:

# turbostat --debug -o ts.out sleep 10
and show the ts.out

>> If the right strategy were to disable C6 for all of BYT, then the
>> right implementation
>> would be to delete those states from byt_cstates[], rather than for a
>> routine to mark
>> them as disabled.  Note that a user can not later enable a state that is marked
>> as disabled here, it is never registered with cpuidle, and thus the effect
>> is exactly the same as if the entry were never in the table in the first place.
>
> Would that be a useful workaround for older stable kernels? I think we
> should try to get stable systems to the affected users.

This workaround is already available in the form of cmdline:
intel_idle.max_cstate=1

not all systems need/want that workaround.

thanks,
Len Brown, Intel Open Source Technology Center
