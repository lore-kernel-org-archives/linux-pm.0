From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Adding pm_schedule_idle(),
	maybe removing pm_schedule_suspend()
Date: Wed, 25 Nov 2009 23:47:59 +0100
Message-ID: <200911252347.59485.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0911251704580.2812-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0911251704580.2812-100000@iolanthe.rowland.org>
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
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday 25 November 2009, Alan Stern wrote:
> Rafael:
> 
> It turns out that I need a pm_schedule_idle() routine.  
> pm_schedule_suspend() just doesn't do what I want -- I need the 
> runtime_idle() callback to be invoked when the timer expires, not 
> runtime_suspend().
> 
> Adding the routine itself is easy enough, but the obvious way to
> implement it is to use dev->power.request to tell the timer function
> whether it should queue an idle or a suspend.  This leads to a problem:
> It becomes impossible to queue an idle request if there's a scheduled
> suspend.  The reason is that power.request has to remain set to
> indicate that a suspend should be queued when the timer expires, so it
> can't be changed to RPM_REQ_IDLE.
> 
> One possible way around this would be to have pm_schedule_idle() 
> completely replace pm_schedule_suspend().  This seems like a reasonable 
> approach -- at the time of the function call we don't know what 
> conditions will be like in the future, so when the timer expires we 
> should check again to see if a suspend is appropriate.
> 
> What do you think?

I'm against that.  In fact I have a usage case that would be broken by this
change.

What exactly is your usage scenario?

Rafael
