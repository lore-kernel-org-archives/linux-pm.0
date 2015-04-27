From: Jin Qian <jinqian@android.com>
Subject: Re: [PATCH 2/3] power: increment wakeup_count when save_wakeup_count failed.
Date: Mon, 27 Apr 2015 11:01:20 -0700
Message-ID: <CA+yUs=xXAWEbPTfriE7oMeUXjCgGi7A=paQ7OXOKhZ3LcKx-rA@mail.gmail.com>
References: <1429750212-28659-1-git-send-email-jinqian@android.com>
	<1429750212-28659-3-git-send-email-jinqian@android.com>
	<20150425201034.GA3008@amd>
	<CA+yUs=xip9zgZ2w1Tzr3xs93XcBT06=DF7jyQcak96WJH9wpSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f179.google.com ([209.85.217.179]:36544 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932817AbbD0SBV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 27 Apr 2015 14:01:21 -0400
Received: by lbbqq2 with SMTP id qq2so88431852lbb.3
        for <linux-pm@vger.kernel.org>; Mon, 27 Apr 2015 11:01:20 -0700 (PDT)
In-Reply-To: <CA+yUs=xip9zgZ2w1Tzr3xs93XcBT06=DF7jyQcak96WJH9wpSg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Sorry about duplicate email. Sent in text mode so that it's delivered
to mailing list.

write fails when there's any new wakeup event after previous read.

https://www.kernel.org/doc/Documentation/ABI/testing/sysfs-power

What: /sys/power/wakeup_count
Date: July 2010
Contact: Rafael J. Wysocki <rjw@rjwysocki.net>
Description:
The /sys/power/wakeup_count file allows user space to put the
system into a sleep state while taking into account the
concurrent arrival of wakeup events.  Reading from it returns
the current number of registered wakeup events and it blocks if
some wakeup events are being processed at the time the file is
read from.  Writing to it will only succeed if the current
number of wakeup events is equal to the written value and, if
successful, will make the kernel abort a subsequent transition
to a sleep state if any wakeup events are reported after the
write has returned.


Thanks,

jin

On Mon, Apr 27, 2015 at 10:53 AM, Jin Qian <jinqian@android.com> wrote:
> write fails when there's any new wakeup event after previous read.
>
> https://www.kernel.org/doc/Documentation/ABI/testing/sysfs-power
>
> What:		/sys/power/wakeup_count
> Date:		July 2010
> Contact:	Rafael J. Wysocki <rjw@rjwysocki.net>
> Description:
> 		The /sys/power/wakeup_count file allows user space to put the
> 		system into a sleep state while taking into account the
> 		concurrent arrival of wakeup events.  Reading from it returns
> 		the current number of registered wakeup events and it blocks if
> 		some wakeup events are being processed at the time the file is
> 		read from.  Writing to it will only succeed if the current
> 		number of wakeup events is equal to the written value and, if
> 		successful, will make the kernel abort a subsequent transition
> 		to a sleep state if any wakeup events are reported after the
> 		write has returned.
>
>
> Thanks,
>
> jin
>
>
> On Sat, Apr 25, 2015 at 1:10 PM, Pavel Machek <pavel@ucw.cz> wrote:
>>
>> On Wed 2015-04-22 17:50:11, Jin Qian wrote:
>> > user-space aborts suspend attempt if writing wakeup_count failed.
>> > Count the write failure towards wakeup_count.
>>
>> Why should writing wakeup_count fail? Can you make sure it does not
>> happen, instead?
>>                                                                 Pavel
>>
>> > Signed-off-by: Jin Qian <jinqian@android.com>
>> > ---
>> >  drivers/base/power/wakeup.c | 17 +++++++++++++++++
>> >  1 file changed, 17 insertions(+)
>> >
>> > diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
>> > index f24c622..bdb45f3 100644
>> > --- a/drivers/base/power/wakeup.c
>> > +++ b/drivers/base/power/wakeup.c
>> > @@ -57,6 +57,8 @@ static LIST_HEAD(wakeup_sources);
>> >
>> >  static DECLARE_WAIT_QUEUE_HEAD(wakeup_count_wait_queue);
>> >
>> > +static ktime_t last_read_time;
>> > +
>> >  /**
>> >   * wakeup_source_prepare - Prepare a new wakeup source for
>> > initialization.
>> >   * @ws: Wakeup source to prepare.
>> > @@ -771,10 +773,15 @@ void pm_wakeup_clear(void)
>> >  bool pm_get_wakeup_count(unsigned int *count, bool block)
>> >  {
>> >       unsigned int cnt, inpr;
>> > +     unsigned long flags;
>> >
>> >       if (block) {
>> >               DEFINE_WAIT(wait);
>> >
>> > +             spin_lock_irqsave(&events_lock, flags);
>> > +             last_read_time = ktime_get();
>> > +             spin_unlock_irqrestore(&events_lock, flags);
>> > +
>> >               for (;;) {
>> >                       prepare_to_wait(&wakeup_count_wait_queue, &wait,
>> >                                       TASK_INTERRUPTIBLE);
>> > @@ -806,6 +813,7 @@ bool pm_save_wakeup_count(unsigned int count)
>> >  {
>> >       unsigned int cnt, inpr;
>> >       unsigned long flags;
>> > +     struct wakeup_source *ws;
>> >
>> >       events_check_enabled = false;
>> >       spin_lock_irqsave(&events_lock, flags);
>> > @@ -813,6 +821,15 @@ bool pm_save_wakeup_count(unsigned int count)
>> >       if (cnt == count && inpr == 0) {
>> >               saved_count = count;
>> >               events_check_enabled = true;
>> > +     } else {
>> > +             rcu_read_lock();
>> > +             list_for_each_entry_rcu(ws, &wakeup_sources, entry) {
>> > +                     if (ws->active ||
>> > +                         ktime_compare(ws->last_time, last_read_time) >
>> > 0) {
>> > +                             ws->wakeup_count++;
>> > +                     }
>> > +             }
>> > +             rcu_read_unlock();
>> >       }
>> >       spin_unlock_irqrestore(&events_lock, flags);
>> >       return events_check_enabled;
>>
>> --
>> (english) http://www.livejournal.com/~pavelmachek
>> (cesky, pictures)
>> http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
>
>
