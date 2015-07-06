From: Javi Merino <javi.merino@arm.com>
Subject: Re: [PATCH 2/4] PM / devfreq: cache the last call to get_dev_status()
Date: Mon, 6 Jul 2015 10:35:39 +0100
Message-ID: <20150706093539.GB2772@e104805>
References: <1435928310-15938-1-git-send-email-javi.merino@arm.com>
 <1435928310-15938-3-git-send-email-javi.merino@arm.com>
 <CAJ0PZbQV7t7DL3WYojPKwUc3B36juHZiv0kGANawhZYQ0VoH3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from fw-tnat.cambridge.arm.com ([217.140.96.140]:39886 "EHLO
	cam-smtp0.cambridge.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751065AbbGFJfs (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 6 Jul 2015 05:35:48 -0400
Content-Disposition: inline
In-Reply-To: <CAJ0PZbQV7t7DL3WYojPKwUc3B36juHZiv0kGANawhZYQ0VoH3g@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "myungjoo.ham@gmail.com" <myungjoo.ham@gmail.com>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>

On Sat, Jul 04, 2015 at 04:15:51AM +0100, MyungJoo Ham wrote:
> On Fri, Jul 3, 2015 at 9:58 PM, Javi Merino <javi.merino@arm.com> wrote:
> > The return value of get_dev_status() can be reused.  Cache it so that
> > other parts of the kernel can reuse it instead of having to call the
> > same function again.
> >
> > Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
> > Cc: Kyungmin Park <kyungmin.park@samsung.com>
> > Signed-off-by: Javi Merino <javi.merino@arm.com>
> > ---
> >  drivers/devfreq/devfreq.c                 |  5 +++++
> >  drivers/devfreq/governor_simpleondemand.c | 33 +++++++++++++++++--------------
> >  include/linux/devfreq.h                   |  7 +++++++
> >  3 files changed, 30 insertions(+), 15 deletions(-)
> >
> 
> What if there are two entities using the stat at the same time? If you
> are going to have the status at a shared object (struct devfreq), you
> need to consider racing conditions as well: two threads accessing
> last_status at the same time, resulting in calling
> devfreq_update_stats() while the other has called it beforehand and
> using the variables in the stat struct. By doing it locally (having
> stat as struct devfreq_dev_status, not a pointer), we can avoid such
> problems. The object (struct devfreq_dev_status) it not guaranteed to
> be accessed by the governor only.

The main problem with get_dev_status() is that, as I understand it,
its results are described to be an update "since the last call",
without taking into account who was the last caller.  Therefore, in
practice it can only be called from one entity.  For example imagine a
devfreq governor and a devfreq cooling device want to have access to
the stats and they both call get_dev_stats() on a 100ms cadence, you
may end up with the following situation:

Time (ms)      devfreq governor      devfreq cooling device
000.000        get_dev_status()
001.000                              get_dev_status()
.
.
100.000        get_dev_status()
101.000                              get_dev_status()
.
.
200.000        get_dev_status()
201.000                              get_dev_status()

The devfreq cooling device calls get_dev_status() on a 100ms cadence,
the status is getting is only for the last 1ms (the time since the
last call to get_dev_status()).

> Or do you intend to share the stat value with another entity, with the
> assumption that only one will be calling devfreq_update_stats() ?
> In that case, what if the one who's supposed to call
> devfreq_update_stats() is paused? For example, what if the user has
> switched the governor from simpleondemand to userspace or performance?

Ideally, the way to solve this would be to change the definition of
get_dev_status() to make it absolute: total_time and busy_time refer
to time since the system was booted.  That way, different components
can call get_dev_status() whenever they feel like and calculate the
values for whichever interval they want to, independently.

With the current definition of get_dev_status(), the only solution
that I can think of is to have one entity to call get_dev_status()
which shares the result by putting it on the devfreq status.  The
solution in this patch puts it in the governor because I preferred to
have a simple solution to kick off this discussion.

To summarize, the solutions that I can think of to solve multiple
entities having access to the status information are:

  1) Change get_dev_status() to return absolute values for busy_time
     and total_time
  2) Make core devfreq call get_dev_status() periodically (for
     example, before calling the governor) and all the entities that
     want access can do so via a pointer in devfreq
  3) Make the simple ondemand governor call get_dev_status()
     periodically and caching it, forcing all the other entities to
     rely on that governor being active

What do you prefer?  Is there a better one that I haven't thought
about?

Thanks,
Javi
