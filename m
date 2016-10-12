From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PM / devfreq: Skip status update on uninitialized previous_freq
Date: Wed, 12 Oct 2016 22:11:09 +0200
Message-ID: <1528210.2n5m7HzmGy@vostro.rjw.lan>
References: <1475152596-7892-1-git-send-email-tjakobi@math.uni-bielefeld.de> <CAJ0PZbSOrkdNM4c0qhkboMU5JmyHLCcnw0wKA54JJruSxWqU5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:48151 "HELO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S1755972AbcJLUEZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Oct 2016 16:04:25 -0400
In-Reply-To: <CAJ0PZbSOrkdNM4c0qhkboMU5JmyHLCcnw0wKA54JJruSxWqU5g@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@gmail.com
Cc: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, Linux PM list <linux-pm@vger.kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>

On Friday, September 30, 2016 11:09:34 PM MyungJoo Ham wrote:
> On Thu, Sep 29, 2016 at 9:36 PM, Tobias Jakobi
> <tjakobi@math.uni-bielefeld.de> wrote:
> > In case devfreq->previous_freq is still uninitialized in
> > devfreq_update_status(), i.e. it has value '0', the lookups in
> > that function fail, eventually leading to some error message:
> > [    3.041292] devfreq bus_dmc: Couldn't update frequency transition information.
> >
> > Just skip the statup update in this situation.
> >
> > Signed-off-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
> > ---
> >  drivers/devfreq/devfreq.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> > index 478006b..1bb300f 100644
> > --- a/drivers/devfreq/devfreq.c
> > +++ b/drivers/devfreq/devfreq.c
> > @@ -137,6 +137,10 @@ static int devfreq_update_status(struct devfreq *devfreq, unsigned long freq)
> >
> >         cur_time = jiffies;
> >
> > +       /* Immediately exit if previous_freq is not initialized yet. */
> > +       if (!devfreq->previous_freq)
> > +               goto out;
> > +
> 
> Thanks!
> 
> 
> Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>

Applied.

Thanks,
Rafael

