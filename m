From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [update] Re: [PATCH] PM: Make it possible to avoid
	wakeup events from being lost
Date: Wed, 30 Jun 2010 21:27:37 +0200
Message-ID: <201006302127.37432.rjw__22940.135250292$1277926224$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.1006301351530.1707-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1006301351530.1707-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: mark gross <640e9920@gmail.com>, Neil Brown <neilb@suse.de>, linux-pci@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arve@smtp1.linux-foundation.org, Florian Mickler <florian@mickler.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Wednesday, June 30, 2010, Alan Stern wrote:
> On Mon, 28 Jun 2010, Rafael J. Wysocki wrote:
> 
> > +/*
> > + * The functions below use the observation that each wakeup event starts a
> > + * period in which the system should not be suspended.  The moment this period
> > + * will end depends on how the wakeup event is going to be processed after being
> > + * detected and all of the possible cases can be divided into two distinct
> > + * groups.
> > + *
> > + * First, a wakeup event may be detected by the same functional unit that will
> > + * carry out the entire processing of it and possibly will pass it to user space
> > + * for further processing.  In that case the functional unit that has detected
> > + * the event may later "close" the "no suspend" period associated with it
> > + * directly as soon as it has been dealt with.  The pair of pm_stay_awake() and
> > + * pm_relax(), balanced with each other, is supposed to be used in such
> > + * situations.
> > + *
> > + * Second, a wakeup event may be detected by one functional unit and processed
> > + * by another one.  In that case the unit that has detected it cannot really
> > + * "close" the "no suspend" period associated with it, unless it knows in
> > + * advance what's going to happen to the event during processing.  This
> > + * knowledge, however, may not be available to it, so it can simply specify time
> > + * to wait before the system can be suspended and pass it as the second
> > + * argument of pm_wakeup_event().
> > + */
> 
> Since there's no longer any way to cancel a call to pm_wakeup_event()  
> or close the "no suspend" period early, there is no need to use
> dynamically-allocated delayed_work structures.  You can make do with a
> single static timer; always keep it set to expire at the latest time
> passed to pm_wakeup_event().

The decremenations of events_in_progress wouldn't be balanced with
incrementations this way.  Or do you have any clever way of dealing with
that in mind?

Rafael
