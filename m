From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] sched: idle: Avoid retaining the tick when it has been stopped
Date: Mon, 20 Aug 2018 23:21:13 +0200
Message-ID: <CAJZ5v0hATzs2NqPEdPSJFcSNWXVu+jkE-KoToCEr-c-y1yphtw@mail.gmail.com>
References: <2161372.IsD4PDzmmY@aspire.rjw.lan> <20180816132723.GA6010@lerouge>
 <10817203.8q7neLTJVD@aspire.rjw.lan> <20180817141252.GA12426@lerouge>
 <CAJZ5v0gD79NuTgr3dVS_3cBFz5Q1JtQTP8mDfSM1tvwDcYkFAQ@mail.gmail.com> <20180820144249.GA9770@lerouge>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180820144249.GA9770@lerouge>
Sender: linux-kernel-owner@vger.kernel.org
To: Frederic Weisbecker <frederic@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Peter Zijlstra <peterz@infradead.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, Leo Yan <leo.yan@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Aug 20, 2018 at 4:42 PM Frederic Weisbecker <frederic@kernel.org> wrote:
>
> On Sat, Aug 18, 2018 at 11:57:00PM +0200, Rafael J. Wysocki wrote:
> > On Fri, Aug 17, 2018 at 4:12 PM Frederic Weisbecker <frederic@kernel.org> wrote:

[cut]

> >
> > Now, in general, there are two reasons for the idle governor (whatever
> > it is) to select an idle state with a target residency below the tick
> > period length.  The first reason is when the governor knows that the
> > closest timer event is going to occur in this time frame, but in that
> > case (as stated above), it is not necessary to worry about the tick,
> > because the other timer will trigger soon enough anyway.  The second
> > reason is when the governor predicts a wakeup which is not by a timer
> > in this time frame and it is quite arguable what the governor should
> > do then.  IMO it at least is not unreasonable to throw the prediction
> > away and still go for the closest timer event in that case (which is
> > the current approach).
>
> Then in this case, when you say you throw away that prediction, does it
> mean you select an idle state that only takes the next timer event into
> consideration?

Yes, it does.

> So for example we predict a wake up event TICK_NSEC ahead but the next
> timer event is a few seconds, you're going to select an idle state
> according to that "few seconds" ahead next event, right? (which in
> practice is likely to be deep I guess).
>
> I guess so but, just want to be sure I understand you correctly.

More precisely, if the original predicted idle duration is less than
TICK_USEC and the tick has been stopped, the governor takes the time
till the next timer event instead of the predicted value (so
effectively the predicted value is discarded).

If the original predicted idle duration is TICK_USEC or more, the tick
would have been stopped anyway (had it not been stopped already), so
it may as well be used for idle state selection in the stopped tick
case.

Cheers,
Rafael
