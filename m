From: David Brownell <david-b@pacbell.net>
Subject: Re: Re: [PATCH] swsusp: do not use pm_ops (was: Re: ...))
Date: Sun, 6 May 2007 18:10:40 -0700
Message-ID: <200705061810.40499.david-b@pacbell.net>
References: <Pine.LNX.4.44L0.0705051139580.1976-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0705051139580.1976-100000@netrider.rowland.org>
Content-Disposition: inline
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
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Pekka Enberg <penberg@cs.helsinki.fi>, Johannes Berg <johannes@sipsolutions.net>, Pavel Machek <pavel@ucw.cz>, Nigel Cunningham <nigel@nigel.suspend2.net>
List-Id: linux-pm@vger.kernel.org

On Saturday 05 May 2007, Alan Stern wrote:

> But who says that hibernate has to use "Non-Volatile Sleep" and normal 
> shutdown has to use software-controlled "poweroff"?  Why shouldn't the 
> user be able to do it the other way 'round?

Well, the definition of NVS matches hibernation, and
the definition of soft-off matches poweroff.


> > > No, I'm suggesting that the user should be able to control whether Linux 
> > > uses S4 vs. S5 at poweroff time.  If the user selected always to use S4 
> > > then wakeup devices would function in both hibernation and normal 
> > > shutdown.  If the user selected always to use S5 then wakeup devices would 
> > > not function in either hibernation or normal shutdown.
> > 
> > That's a different suggestion, yes.  I'm not sure I see any
> > benefit of that flexibility for "soft off" states though,
> > especially if it made "off" consume more power.
> 
> The benefit is that it allows more devices to function as wakeup sources, 
> right?

With downsides of "more power consumed during 'off' states"
and "invalidating documentation, training, and expectations".

This is a case where the fact that something could technically
be done doesn't recommend it to me.

- Dave
