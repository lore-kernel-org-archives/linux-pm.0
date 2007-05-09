From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Re: [PATCH] swsusp: do not use pm_ops (was: Re: ...))
Date: Wed, 9 May 2007 11:21:27 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0705091114540.3207-100000@iolanthe.rowland.org>
References: <20070509081717.GA7741@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070509081717.GA7741@elf.ucw.cz>
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
Cc: Nigel Cunningham <nigel@nigel.suspend2.net>, Pekka Enberg <penberg@cs.helsinki.fi>, linux-pm@lists.linux-foundation.org, Johannes Berg <johannes@sipsolutions.net>
List-Id: linux-pm@vger.kernel.org

On Wed, 9 May 2007, Pavel Machek wrote:

> Hi!
> 
> > We give the user a chance to decide how this tradeoff should go when 
> > entering hibernation.  Why not also give the user a chance to decide the 
> > tradeoff during normal shutdown?
> > 
> > Yes, it violates the spec in the sense that we would be entering S4 
> > without saving a memory image.  
> 
> I think you already replied to yourself :-).

Yes -- but going to S5 during hibernation (which is what "echo shutdown 
>/sys/power/disk" does, right?) also violates the spec.  So I don't feel 
too guilty about this.

> There are more reasons, like we getting useless code paths to
> debug. So far you demonstrated that S4-on-shutdown is probably
> possible, and while violating specs, it should probably work.
> 
> What do you expect now? Me jumping with joy and implementing
> S4-on-shutdown because it should be possible?

Actually all I wanted was someone to look over my reasoning and check that 
it was correct.  You and Raphael have now done so, thank you.

And when I first began contributing to this thread, the main purpose was 
to point out that hibernation_ops (or anything else related to the 
shutdown method) should not be involved in the steps responsible for 
creating and storing the snapshot image.

> Now... if you feel very strongly about S4-on-shutdown, you may try to
> create a patch. If it is not-too-ugly, and if it is really good for
> something, we may merge it.

At some time I might just do that...

Alan Stern
