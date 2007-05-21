From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Singlethread vs. freezable workqueues
Date: Mon, 21 May 2007 16:23:33 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0705211621000.5679-100000@iolanthe.rowland.org>
References: <200705212154.34490.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200705212154.34490.rjw@sisk.pl>
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
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Oleg Nesterov <oleg@tv-sign.ru>
List-Id: linux-pm@vger.kernel.org

On Mon, 21 May 2007, Rafael J. Wysocki wrote:

> Hi,
> 
> On Monday, 21 May 2007 21:33, Alan Stern wrote:
> > Raphael:
> > 
> > Are we now committed to making freezable workqueues always 
> > singlethreaded?  Is it at all likely to change back?  Or should I 
> > introduce a "create_singlethread_freezeable_workqueue" macro?
> 
> This was done as a quick fix of an issue with one driver that started to use
> (broken) freezable workqueues when we were not watching. ;-)
> 
> We are going to have multithread freezable workqueues as well, but that'll
> take some time.  We've discussed this a bit with Oleg and I believe he has an
> idea of how it can be done cleanly.

The reason I asked is because, prior to the release of 2.6.22, I sent 
in a patch which added a create_singlethread_freezeable_workqueue() 
macro.  Now it isn't needed, since create_freezeable_workqueue() does 
the same thing.  Is there any reason to keep the macro?

I'm worried that if I get rid of it and simply define the workqueue as 
freezable, then at some time in the future it might turn into a 
multithread workqueue without my knowledge.

Alan Stern
