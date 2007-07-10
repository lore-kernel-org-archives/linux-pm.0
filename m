From: Oleg Nesterov <oleg@tv-sign.ru>
Subject: Re: [RFC][PATCH -mm 2/6] Freezer: Do not send signals to
	kernel threads
Date: Wed, 11 Jul 2007 01:22:17 +0400
Message-ID: <20070710212217.GA191@tv-sign.ru>
References: <200707092229.08898.rjw@sisk.pl> <200707092232.01603.rjw@sisk.pl>
	<20070710150050.GA158@tv-sign.ru> <200707102308.03223.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200707102308.03223.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Miklos Szeredi <miklos@szeredi.hu>, Pavel Machek <pavel@ucw.cz>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On 07/10, Rafael J. Wysocki wrote:
>
> On Tuesday, 10 July 2007 17:00, Oleg Nesterov wrote:
> > > --- linux-2.6.22-rc6-mm1.orig/drivers/input/gameport/gameport.c
> > > +++ linux-2.6.22-rc6-mm1/drivers/input/gameport/gameport.c
> > > @@ -448,9 +448,8 @@ static int gameport_thread(void *nothing
> > >  	set_freezable();
> > >  	do {
> > >  		gameport_handle_event();
> > > -		wait_event_interruptible(gameport_wait,
> > > +		wait_event_freezable(gameport_wait,
> > >  			kthread_should_stop() || !list_empty(&gameport_event_list));
> > > -		try_to_freeze();
> > >  	} while (!kthread_should_stop());
> > 
> > Isn't it better to break this patch into 2 separate ones? The first adds
> > wait_event_freezable() and "fixes" gameport_thread() and friends in advance,
> > the second deals with TIF_SIGPENDING. (please ignore if this is not convenient).
> 
> Not really.  I thought about that, but the change in gameport_thread() and
> friends is actually necessary _because_ we don't send signals to kernel
> threads any more.

Yes sure. But this change looks correct even if we do send the signal, so it
can go first. It would be nice to have the actual "do not send the signal"
change in a separate patch.

But again, this is minor, please ignore if you don't like this for whatever
reason.

Oleg.
