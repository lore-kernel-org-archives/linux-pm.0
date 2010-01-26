From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: syncing the disks when entering sleep
Date: Tue, 26 Jan 2010 19:17:37 +0100
Message-ID: <201001261917.37194.rjw@sisk.pl>
References: <76FA3B279DD9DA48896E2B404944957204E0B241@USA7061MS02.na.xerox.net>
	<201001222149.46839.rjw@sisk.pl> <20100126135942.GD1764@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100126135942.GD1764@ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@lists.linux-foundation.org, "Leisner,
	Martin" <Martin.Leisner@xerox.com>
List-Id: linux-pm@vger.kernel.org

On Tuesday 26 January 2010, Pavel Machek wrote:
> Hi!
> 
> > > I noticed when we enter sleep states, it seems there's always a
> > > sys_sync given.
> > > 
> > > When having an embedded system doing WOL (already in laptop mode to
> > > cache
> > > all the writes), it reasonable to wake up dozens of times of day and
> > > quickly go back to sleep.  If the disk is not spun up,
> > > and there's some work to be done, won't the sys_sync spin up the disk
> > > before going to sleep?
> > > 
> > > It would be good to have a knob (in /sys) you can tweak from usespace to
> > > 
> > > configure the behavior of whether you want to do a sync when entering
> > > sleep.
> > > 
> > > The ideal behavior would be:
> > > 
> > >     if(disk is spun up)
> > >         then let the sync happen
> > 
> > I'm not against that.  Patch welcome. :-)
> 
> I'd say such knob would be ugly.

Define "ugly", please.

> But maybe acceptable way would be echo mem-nosync > power, or maybe it can
> already be done using s2disk ioctl interface...?

Nope.

Rafael
