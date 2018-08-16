From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: Keyboard lost after exit s2idle on ASUS UX433FN
Date: Thu, 16 Aug 2018 12:16:32 +0200
Message-ID: <CAJZ5v0gsCLScuvPnAGdOMJFx77m=+25wQNX_S7LBwvsm08NpRw@mail.gmail.com>
References: <CAB4CAwfms8_zJ=xB5wJ0Sgr6gu9-mFnqwEz2cUR-sOHdEV5zqQ@mail.gmail.com>
 <CAJZ5v0gKfyB7=5ZGj9uXejoBjkuf2snsKwYJM2Ar1_Vg8A8SCg@mail.gmail.com>
 <CAB4CAwfdwU6FQVEWWO2dLw-RJHTpqWeuk_BiH04ssE=iCOrJ+A@mail.gmail.com>
 <CAJZ5v0i6PXg1rTjBTZy3tGVihmb84qZpqzmHrwSdACWZ+SOgYg@mail.gmail.com> <CAB4CAweumP0qZEJGsNNeEEH3-g13E1dGQD9+zsh1fKysA9MsuQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAB4CAweumP0qZEJGsNNeEEH3-g13E1dGQD9+zsh1fKysA9MsuQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chris Chiu <chiu@endlessm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Len Brown <lenb@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Upstreaming Team <linux@endlessm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Thu, Aug 16, 2018 at 12:05 PM Chris Chiu <chiu@endlessm.com> wrote:
>
> On Thu, Aug 16, 2018 at 4:54 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > On Thu, Aug 16, 2018 at 10:18 AM Chris Chiu <chiu@endlessm.com> wrote:
> >>
> >> On Thu, Aug 16, 2018 at 3:26 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> >> > On Thu, Aug 16, 2018 at 4:45 AM Chris Chiu <chiu@endlessm.com> wrote:
> >> >>
> >> >> Hi,
> >> >>     We recently hit a weird problem on the ASUS laptop UX433FN with
> >> >> latest Intel Core i7-8565U CPU on kernel 4.18. The keyboard stops
> >> >> functioning after exit s2idle. It stops firing interrupts after resume
> >> >> on any keypress. We thought it should be something wrong with i8042
> >> >> driver or even atkbd driver, so we tried to skip the suspend/resume
> >> >> path of i8042 and input devices but no luck.
> >> >>
> >> >>     Then we tried to hack the s2idle code to fail right before it goes
> >> >> into the idle state to find out which code really cause the keyboard
> >> >> broken. It comes with an interesting finding that if it aborts s2idle
> >> >> before cpuidle_resume() in s2idle_enter(), the keyboard is fine. If it
> >> >> aborts after cpuidle_resume, then the keyboard down. At least it
> >> >> proves that even with dpm_noirq_begin() and
> >> >> dpm_noirq_suspend_devices() executed, the keyboard is still alive.
> >> >> There should be something wrong with the cpuidle.
> >> >>
> >> >>     Going deeper into intel_idle_s2idle() which is invoked by
> >> >> cpuidle_enter_s2idle(), we found that the keyboard interrupt will no
> >> >> longer function after mwait_idle_with_hints() which just simply
> >> >> executing intel monitor and mwait instructions. So I don't know what
> >> >> should be the next step I can take. Can anyone give some pieces of
> >> >> advice?
> >> >
> >> > It may indicate that the deepest C-states used by s2idle simply don't
> >> > work correctly on the affected system.
> >> >
> >> > To verify this, you can try to disable the deepest C-states via sysfs
> >> > using the "disable" attribute under
> >> > /sys/devices/system/cpu/cpuX/cpuidle/stateX/
> >> >
> >> Thanks for the great help. I can have the keyboard work after s2idle with
> >> the following command
> >>
> >> echo 1 > /sys/devices/system/cpu/cpuX/cpuidle/state8/disable
> >>
> >> cpuX, X can be 0 to 7 on this CPU.
> >> And only state8 disable would work, it fails on state 0~7 disabled.
> >
> > Well, if you disable one of states 0-7 alone, it will still attempt to
> > use state8. :-)
> >
> > It generally uses the deepest one enabled.
> >
> >> There're 9 (0-8) states on the cpuidle of this machine. However, I have another
> >> laptop with the same CPU Intel Core i7-8565U which only have 4(0-3) states
> >> under the same '/sys/devices/system/cpu/cpuX/cpuidle/' entry. Sorry that I
> >> don't have enough background knowledge about cpuidle. I thought the #C
> >> state should be depend on CPU, but why the same i7-8565 has different
> >> number of C-states?
> >
> > What is there in /sys/devices/system/cpu/cpuidle/current_driver on
> > each of these systems?
> >
> >>  And for this case, should I just disable C-8 state or there
> >> should be a generic fix with it?
> >
> > No, it just doesn't work specifically on your system, unfortunately,
> > so you need to disable state8 manually, at least for the time being.
> > If all UX433FNs turn out to be affected, we may consider adding a
> > quirk for them, but for now we just don't know.
> >
> > Do the "name" and "desc" sysfs files of state8 on the affected system
> > contain "C10" and "MWAIT 0x60", respectively?
> >
> > To make a more persistent record of this issue, you can file a bug at
> > bugzilla.kernel.org against cpuidle and put all of the relevant
> > information into it.  It is possible that some special magic is needed
> > to make the deepest idle state safe on this system and it may be hard
> > to find out, but at least it is good to know that this happens.
> >
>
> Thanks. I've reported on https://bugzilla.kernel.org/show_bug.cgi?id=200829.
> Also, include information you request. Please let me know if anything missing.

OK, responded in the BZ entry.  Let's continue the discussion in there.

Thanks!
