From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 3/3] power: add a dummy wakeup_source to record statistics
Date: Mon, 18 May 2015 02:35:34 +0200
Message-ID: <1807534.3uAuvYPGo8@vostro.rjw.lan>
References: <1429750212-28659-1-git-send-email-jinqian@android.com> <2029445.LdfDNJdYNa@vostro.rjw.lan> <CA+yUs=ww4R9qyjr8rrVf70W+-hX2eja7EGtJqVn61CXb5NOypg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:54711 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751947AbbERAKR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 17 May 2015 20:10:17 -0400
In-Reply-To: <CA+yUs=ww4R9qyjr8rrVf70W+-hX2eja7EGtJqVn61CXb5NOypg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jin Qian <jinqian@android.com>
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Friday, May 15, 2015 06:25:41 PM Jin Qian wrote:
> Hi Rafael,
> 
> I made a minor change in [PATCHv3 3/3] power: add a dummy
> wakeup_source to record statistics. Sorry lkml seems down. I can send
> you the link later.
> 
> The only diff is that deleted_ws.max_time = max(deleted_ws.max_time,
> ws->max_time) instead of adding them up.

OK, I'll use the new version, thanks!


> On Fri, May 15, 2015 at 5:41 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > On Wednesday, April 22, 2015 05:50:12 PM Jin Qian wrote:
> >> After a wakeup_source is destroyed, we lost all information such as how
> >> long this wakeup_source has been active. Add a dummy wakeup_source to
> >> record such info.
> >>
> >> Signed-off-by: Jin Qian <jinqian@android.com>
> >
> > That's fine by me.  Queued up for 4.2, thanks!
> >
> >> ---
> >>  drivers/base/power/wakeup.c | 35 +++++++++++++++++++++++++++++++++++
> >>  1 file changed, 35 insertions(+)
> >>
> >> diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
> >> index bdb45f3..732683c 100644
> >> --- a/drivers/base/power/wakeup.c
> >> +++ b/drivers/base/power/wakeup.c
> >> @@ -59,6 +59,11 @@ static DECLARE_WAIT_QUEUE_HEAD(wakeup_count_wait_queue);
> >>
> >>  static ktime_t last_read_time;
> >>
> >> +static struct wakeup_source deleted_ws = {
> >> +     .name = "deleted",
> >> +     .lock =  __SPIN_LOCK_UNLOCKED(deleted_ws.lock),
> >> +};
> >> +
> >>  /**
> >>   * wakeup_source_prepare - Prepare a new wakeup source for initialization.
> >>   * @ws: Wakeup source to prepare.
> >> @@ -110,6 +115,33 @@ void wakeup_source_drop(struct wakeup_source *ws)
> >>  }
> >>  EXPORT_SYMBOL_GPL(wakeup_source_drop);
> >>
> >> +/*
> >> + * Record wakeup_source statistics being deleted into a dummy wakeup_source.
> >> + */
> >> +static void wakeup_source_record(struct wakeup_source *ws)
> >> +{
> >> +     unsigned long flags;
> >> +
> >> +     spin_lock_irqsave(&deleted_ws.lock, flags);
> >> +
> >> +     if (ws->event_count) {
> >> +             deleted_ws.total_time =
> >> +                     ktime_add(deleted_ws.total_time, ws->total_time);
> >> +             deleted_ws.max_time =
> >> +                     ktime_add(deleted_ws.max_time, ws->max_time);
> >> +             deleted_ws.prevent_sleep_time =
> >> +                     ktime_add(deleted_ws.prevent_sleep_time,
> >> +                               ws->prevent_sleep_time);
> >> +             deleted_ws.event_count += ws->event_count;
> >> +             deleted_ws.active_count += ws->active_count;
> >> +             deleted_ws.relax_count += ws->relax_count;
> >> +             deleted_ws.expire_count += ws->expire_count;
> >> +             deleted_ws.wakeup_count += ws->wakeup_count;
> >> +     }
> >> +
> >> +     spin_unlock_irqrestore(&deleted_ws.lock, flags);
> >> +}
> >> +
> >>  /**
> >>   * wakeup_source_destroy - Destroy a struct wakeup_source object.
> >>   * @ws: Wakeup source to destroy.
> >> @@ -122,6 +154,7 @@ void wakeup_source_destroy(struct wakeup_source *ws)
> >>               return;
> >>
> >>       wakeup_source_drop(ws);
> >> +     wakeup_source_record(ws);
> >>       kfree(ws->name);
> >>       kfree(ws);
> >>  }
> >> @@ -930,6 +963,8 @@ static int wakeup_sources_stats_show(struct seq_file *m, void *unused)
> >>               print_wakeup_source_stats(m, ws);
> >>       rcu_read_unlock();
> >>
> >> +     print_wakeup_source_stats(m, &deleted_ws);
> >> +
> >>       return 0;
> >>  }
> >>
> >>
> >
> > --
> > I speak only for myself.
> > Rafael J. Wysocki, Intel Open Source Technology Center.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
