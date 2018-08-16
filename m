From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: Keyboard lost after exit s2idle on ASUS UX433FN
Date: Thu, 16 Aug 2018 09:26:41 +0200
Message-ID: <CAJZ5v0gKfyB7=5ZGj9uXejoBjkuf2snsKwYJM2Ar1_Vg8A8SCg@mail.gmail.com>
References: <CAB4CAwfms8_zJ=xB5wJ0Sgr6gu9-mFnqwEz2cUR-sOHdEV5zqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAB4CAwfms8_zJ=xB5wJ0Sgr6gu9-mFnqwEz2cUR-sOHdEV5zqQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chris Chiu <chiu@endlessm.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>, Len Brown <lenb@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Upstreaming Team <linux@endlessm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Thu, Aug 16, 2018 at 4:45 AM Chris Chiu <chiu@endlessm.com> wrote:
>
> Hi,
>     We recently hit a weird problem on the ASUS laptop UX433FN with
> latest Intel Core i7-8565U CPU on kernel 4.18. The keyboard stops
> functioning after exit s2idle. It stops firing interrupts after resume
> on any keypress. We thought it should be something wrong with i8042
> driver or even atkbd driver, so we tried to skip the suspend/resume
> path of i8042 and input devices but no luck.
>
>     Then we tried to hack the s2idle code to fail right before it goes
> into the idle state to find out which code really cause the keyboard
> broken. It comes with an interesting finding that if it aborts s2idle
> before cpuidle_resume() in s2idle_enter(), the keyboard is fine. If it
> aborts after cpuidle_resume, then the keyboard down. At least it
> proves that even with dpm_noirq_begin() and
> dpm_noirq_suspend_devices() executed, the keyboard is still alive.
> There should be something wrong with the cpuidle.
>
>     Going deeper into intel_idle_s2idle() which is invoked by
> cpuidle_enter_s2idle(), we found that the keyboard interrupt will no
> longer function after mwait_idle_with_hints() which just simply
> executing intel monitor and mwait instructions. So I don't know what
> should be the next step I can take. Can anyone give some pieces of
> advice?

It may indicate that the deepest C-states used by s2idle simply don't
work correctly on the affected system.

To verify this, you can try to disable the deepest C-states via sysfs
using the "disable" attribute under
/sys/devices/system/cpu/cpuX/cpuidle/stateX/

Is s2idle the default suspend method on that system?  If so, have you
checked whether or not suspend-to-RAM works too?

Thanks,
Rafael
