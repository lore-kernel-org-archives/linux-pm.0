From: Chirantan Ekbote <chirantan@chromium.org>
Subject: Re: A desktop environment[1] kernel wishlist
Date: Tue, 5 May 2015 12:22:01 -0700
Message-ID: <CAJFHJrr=TMuP2fz99=tRE6ev9AZokM2Y9NQdP4JhGOyExXgwvg@mail.gmail.com>
References: <1413881397.30379.7.camel@hadess.net>
	<CAOesGMg6UBuF=OJ-JdAUx-sD5MnLL8+Ag=xeJFmr-Dxezti2YA@mail.gmail.com>
	<CAJFHJrp8R+Na73W2Jx6BJ+JnHTGZfd61d+EracgehS+ZQoZOcg@mail.gmail.com>
	<286173531.vzKW1UoxJJ@vostro.rjw.lan>
	<CAJFHJrrYhOtjQENR2-_v2XDeYUJCB1tw7MnZbWjC0d-Mz3Z15g@mail.gmail.com>
	<1430822800.7954.5.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1430822800.7954.5.camel@hadess.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, John Stultz <john.stultz@linaro.org>, Olof Johansson <olof@lixom.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, snanda@chromium.org, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, May 5, 2015 at 3:46 AM, Bastien Nocera <hadess@hadess.net> wrote:
> On Mon, 2015-05-04 at 16:30 -0700, Chirantan Ekbote wrote:
>>
> <snip>
>> In the interest of brevity, I didn't go into the design of suspend /
>> resume in userspace in my last email but it seems like there's no way
>> around it.
>>
>> Ignoring lucid sleep for a moment, here is how a regular suspend
>> works
>> in the power manager.  The power manager sees a suspend request
>> either
>> because the user has been idle for X amount of time (usually 15
>> minutes) or the user explicitly requested it by closing the lid.  The
>> power manager reads the value of /sys/power/wakeup_count and then
>> announces an imminent suspend to the rest of the system via DBus.
>> Interested applications (like the network manager and Chrome) will
>> have registered with the power manager to be informed about this when
>> they started up.  For example, this is when Chrome would freeze its
>> renderer processes.  The power manager will now wait for them to
>> report back their readiness to suspend.  Once all applications have
>> reported ready (or the maximum timeout occurs), the power manager
>> performs some final preparations (like setting the resume brightness
>> for the display).
>
> logind in systemd also does this, using block or delay inhibitors over
> D-Bus:
> http://www.freedesktop.org/wiki/Software/systemd/inhibit/
>
>>   The last thing the power manager does, right before
>> writing "mem" to /sys/power/state, is write the wakeup_count that it
>> read earlier to /sys/power/wakeup_count.  If the write fails, the
>> power manager considers the suspend attempt failed, reads the new
>> wakeup_count, and starts a timer (usually 10 seconds) to retry the
>> suspend.  The same thing happens if the write to /sys/power/state
>> fails.
>
> Is this something that logind should do as well?
>

We do it to avoid a race condition where a wakeup event occurs after
userspace has started the suspend process but before anything writes
"mem" to /sys/power/state.  I'm guessing that this is something logind
should be doing as well since the chances of missing a wakeup event
increase the longer any given delay inhibitor takes to delay a
suspend.

>> It may be the case that the event that incremented the count happened
>> because a user was trying to cancel the suspend.  The user could have
>> pressed some keys on the keyboard, touched the trackpad, opened the
>> lid, pressed the power button, etc, etc.  For the keyboard and
>> trackpad these events make their way up to Chrome, which sends a user
>> activity message to the power manager.  This is a message that Chrome
>> sends to the power manager even during regular activity, up to five
>> times a second, to prevent the idle timeout from occuring.  When the
>> power manager sees this user activity message while waiting to retry
>> the suspend, it cancels the retry and sends out a DBus signal
>> informing the system that the suspend is now complete.  For events
>> like opening the lid or pressing the power button, the power manager
>> monitors those events in /dev/input and simulates a user activity
>> message from chrome if any of them fire.
>>
>> <snip>
>>
>> So that was a little long-winded but hopefully I've addressed all
>> your
>> concerns about potential race conditions in this code.  I simplified
>> a
>> few bits because would just complicate the discussion but for the
>> most
>> part this is how the feature works now.  Having the kernel emit a
>> uevent with the wakeup event type would take the place of the power
>> manager reading from /sys/power/wakeup_type in this system but
>> wouldn't really affect anything else.
>
> Could you or Tomeu explain the driver changes that are necessary? Do
> only drivers that we want to be usable as wakeup sources need to be
> changed? Do you have examples of such a patch?
>

You will need driver support for anything that needs to trigger a
wakeup event.  The RTC already supports this but for wifi we needed
both driver and firmware support from Intel.  Assuming you choose to
go down the "runtime-suspend devices to keep them suspended on resume"
path, then you would also need runtime suspend support in all the
drivers that you wanted to leave off.  In our case, we only do this
for the display and the USB ports because we don't want the screen to
flash or the lights on any USB-connected device to start blinking.

Here are some of the patches for wifi that we needed to get this working:

6abb9cb cfg80211: make WoWLAN configuration available to drivers
cd8f7cb cfg80211/mac80211: support reporting wakeup reason
a92eecb cfg80211: fix WoWLAN wakeup tracing
8cd4d45 cfg80211: add wowlan net-detect support


> Cheers
>
