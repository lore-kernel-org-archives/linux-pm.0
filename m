From: Vincent Gerris <vgerris@gmail.com>
Subject: Re: [PATCH] intel_idle: work around errate VLP52 on Baytrail CPUs
Date: Wed, 28 Dec 2016 13:56:25 +0100
Message-ID: <CA+8K-gntePuqdij7SijqcT0RXPoKi163UPwoBnBCk04zBp0BvA@mail.gmail.com>
References: <838trb233m.fsf@echidna.jochen.org> <CAJZ5v0jkATWSrGuR_DOfiSUFguRJ1w7gMRth1kjwYh1bSWnvGw@mail.gmail.com>
 <CA+8K-g=fXN9TWWxkV1AEEjXJLhwJEQ2PB434gKQ9Z7bL=yf+zA@mail.gmail.com>
 <CA+8K-g=VVC-13J+jU+KGyk49xHPhm5uojj0h9FcWZiC91NTiQw@mail.gmail.com>
 <CAJvTdK=sFHRo3FQ-ebWM7qVY3iLadWUFA+iacB8jwfHtJyNWGA@mail.gmail.com>
 <83ful9yue7.fsf@echidna.jochen.org> <CAJvTdKkJv+WfvvibR9Ly9AS5ncp1UTsm74XMX=pg8uyV9Mxupw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33064 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751472AbcL1M42 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Dec 2016 07:56:28 -0500
Received: by mail-wm0-f65.google.com with SMTP id u144so61849947wmu.0
        for <linux-pm@vger.kernel.org>; Wed, 28 Dec 2016 04:56:27 -0800 (PST)
In-Reply-To: <CAJvTdKkJv+WfvvibR9Ly9AS5ncp1UTsm74XMX=pg8uyV9Mxupw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Jochen Hein <jochen@jochen.org>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Linux PM <linux-pm@vger.kernel.org>

Hi,

First of all I want to thank you for getting involved, it seems intel
is the one that knows best how to address this and get to the root
cause.

On Dec 27, 2016 22:28, "Len Brown" <lenb@kernel.org> wrote:
>
> It is not possible for Linux to enter idle from within an interrupt handler.
> Thus, it is not possible for the cited errata to be the root cause of
> this problem.
>
> > - all I can say is that for all Kernels < 4.9 I
> > had to disable C6 to have a stable system.
> > 4.9 seems stable for me now.

For me 4.9.0 is not stable either and at least someone with gentoo on
4.9.0 rc1 reported freezes too.
Although it takes longer before it happens, it still freezes (N3520 on
Lenovo Yoga 2 11 with latest BIOS).

> Linux-4.9 does not contain the patch do disable c6 on BYT.
> And so that patch can not be the reason for the reported change in stability.
>
> I understand that this stability problem is difficult to get one's
> hands around --
> many have reported that it was gone, only to later report that it
> wasn't really gone...
>
> If you have something that can quickly determine if the problem is present
> or if the problem is gone, that would be extremely valuable.

For me I can usually trigger the freeze by a combination playing video
and network/bluetooth traffic.
What usually freezes it in minutes, is playing video from a network
share, copying that file at the same time and stream audio over
bluetooth.
>
> It would also be very interesting to know what C-states are actually
> being used on your particular platform.  For example, your patch
> disabled c6, but did not disable c7.  I would be interested to know
> on a ststem such as yours, if disabling c67 was sufficient, and
> if the platform was still able to make use of c7.
>
> You can see if you are actually using c7 by running turbostat on an idle system:

If I am not mistaken, this is output from a patched 4.8 kernel from
powertop using Jochens patch :
          Package   |             Core    |            CPU 0
                    |                     | C0 active   0,8%
                    |                     | POLL        0,0%    0,0 ms
                    | C1 (cc1)   14,7%    | C1-BYT     10,4%    4,3 ms
C2 (pc2)    0,0%    |                     |
C3 (pc3)    0,0%    |                     |
C6 (pc6)    0,0%    | C6 (cc6)   81,7%    |
                    |                     | C7S-BYT     3,1%    6,5 ms

                    |             Core    |            CPU 1
                    |                     | C0 active   1,6%
                    |                     | POLL        0,0%    0,0 ms
                    | C1 (cc1)   89,1%    | C1-BYT     56,2%    2,7 ms
                    |                     |
                    |                     |
                    | C6 (cc6)    4,1%    |
                    |                     | C7S-BYT     0,0%    0,0 ms

                    |             Core    |            CPU 2
                    |                     | C0 active   0,3%
                    |                     | POLL        0,0%    0,0 ms
                    | C1 (cc1)   10,7%    | C1-BYT      5,8%    8,9 ms
                    |                     |
                    |                     |
                    | C6 (cc6)   88,1%    |
                    |                     | C7S-BYT    19,5%   31,9 ms

                    |             Core    |            CPU 3
                    |                     | C0 active   0,2%
                    |                     | POLL        0,0%    0,0 ms
                    | C1 (cc1)   17,3%    | C1-BYT     10,2%   11,3 ms
                    |                     |
                    |                     |
                    | C6 (cc6)   82,0%    |

>
> # turbostat --debug -o ts.out sleep 10
> and show the ts.out
>
> >> If the right strategy were to disable C6 for all of BYT, then the
> >> right implementation
> >> would be to delete those states from byt_cstates[], rather than for a
> >> routine to mark
> >> them as disabled.  Note that a user can not later enable a state that is marked
> >> as disabled here, it is never registered with cpuidle, and thus the effect
> >> is exactly the same as if the entry were never in the table in the first place.
I don't fully grasp this, but if the errata causes this, wouldn't it
be more transparent to mark it as such so disable it?
Are we really sure the errata does not cause this? If so, is there a
recommended way from intel on how to patch this?

> >
> > Would that be a useful workaround for older stable kernels? I think we
> > should try to get stable systems to the affected users.
>
> This workaround is already available in the form of cmdline:
> intel_idle.max_cstate=1
>
> not all systems need/want that workaround.

I think there are 2 main reasons why we do not want kernel parameters:
1. normal users will have difficulties doing this (I don't like it either :) )
2. it's not a structural solution

>
> thanks,
> Len Brown, Intel Open Source Technology Center

I saw your patch for auto-demotion, I will test it and report within a few days.
I will also do further testing with the 4.9 kernel. I hope we can get
things stable one way or the other :).

Thanks a lot,
Vincent Gerris
