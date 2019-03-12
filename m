From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 1/2] PM / wakeup: Remove timer from wakeup_source_remove()
Date: Tue, 12 Mar 2019 10:03:13 +0100
Message-ID: <CAJZ5v0iP5Gv2i36qUx9NFJ4YjrcsvGiwu0gO7i79L0K2LOQZzA@mail.gmail.com>
References: <621452804d6d22f72438614b6687f37282d883f5.1552038717.git.viresh.kumar@linaro.org>
 <3100371.t8xxUOTPUa@aspire.rjw.lan> <20190312032802.gsheaosu2dtawiyu@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190312032802.gsheaosu2dtawiyu@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Linux PM <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Zhaosheng Sun <sunzhaosheng@hisilicon.com>, jean.xupeng@hisilicon.com, yuwei3@hisilicon.com, gengyanping@hisilicon.com, peter.panshilin@hisilicon.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Mar 12, 2019 at 4:28 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 11-03-19, 13:05, Rafael J. Wysocki wrote:
> > On Friday, March 8, 2019 10:53:11 AM CET Viresh Kumar wrote:
> > > wakeup_source_remove() is the counterpart of wakeup_source_add() helper
> > > and must undo the initializations done by wakeup_source_add(). Currently
> > > the timer is initialized by wakeup_source_add() but removed from
> > > wakeup_source_drop(), which doesn't look logically correct. Also it
> > > should be okay to call wakeup_source_add() right after calling
> > > wakeup_source_remove(), and in that case we may end up calling
> > > timer_setup() for a potentially scheduled timer which is surely
> > > incorrect.
> > >
> > > Move the timer removal part to wakeup_source_remove() instead.
> > >
> > > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > > ---
> > >  drivers/base/power/wakeup.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
> > > index f1fee72ed970..18333962e3da 100644
> > > --- a/drivers/base/power/wakeup.c
> > > +++ b/drivers/base/power/wakeup.c
> > > @@ -118,7 +118,6 @@ void wakeup_source_drop(struct wakeup_source *ws)
> > >     if (!ws)
> > >             return;
> > >
> > > -   del_timer_sync(&ws->timer);
> > >     __pm_relax(ws);
> > >  }
> > >  EXPORT_SYMBOL_GPL(wakeup_source_drop);
> > > @@ -205,6 +204,8 @@ void wakeup_source_remove(struct wakeup_source *ws)
> > >     list_del_rcu(&ws->entry);
> > >     raw_spin_unlock_irqrestore(&events_lock, flags);
> > >     synchronize_srcu(&wakeup_srcu);
> > > +
> > > +   del_timer_sync(&ws->timer);
> > >  }
> > >  EXPORT_SYMBOL_GPL(wakeup_source_remove);
> > >
> > >
> >
> > I've merged it with the [2/2], rewritten the subject and changelog and
> > queued the result as commit d856f39ac1cc ("PM / wakeup: Rework wakeup
> > source timer cancellation").
>
> Okay, thanks. We (Android guys) want this to be backported into 4.4+
> kernels via the stable tree. Can we mark this for stable in the commit
> itself ? Else I would be required to send this separately for all the
> kernels. I should have marked it for stable initially though, sorry
> about forgetting then.

Queued up with a CC-stable tag for 4.4 an later, thanks!
