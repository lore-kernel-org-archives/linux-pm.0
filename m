From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Sat, 7 Jul 2007 22:24:12 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0707072218030.10912-100000__36848.8424610861$1183861503$gmane$org@netrider.rowland.org>
References: <1183855362.3388.233.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1183855362.3388.233.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-kernel@vger.kernel.org, Kyle Moffett <mrmacman_g4@mac.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Sun, 8 Jul 2007, Benjamin Herrenschmidt wrote:

> > Which is exactly my point.  It _doesn't_ work fine without a freezer, 
> > because the USB stack currently relies on the freezer to prevent plug 
> > activity.
> 
> Putting on hold plug activity has nothing, NOTHING, to do with the half
> assed piece of deadlocking crap we have now we call a freezer.

You're wrong; it _does_ have something to do with the freezer.  The 
connection is that the code uses the freezer to put plug activity on 
hold.

You probably meant to say that it _should_ have nothing to do with the 
freezer.  That's a different matter.  But in any case you should write 
what you actually mean, rather than just putting down something as 
inflammatory as possible.

> As long as you guys keep mixing up all the issues and coming up with
> totally bogus solutions that cannot work, we won't have a useful suspend
> (either to RAM or to disk) in linux.

In my defense, you should realize that until Rafael's notifier chain
was added (just a few weeks ago, still not in mainline I believe) there
was no other way to do it.  Plug activity needs to be stopped before
the child devices are suspended, and the PM core does not send any
notification to drivers at that time.  All it does is activate the 
freezer.

Alan Stern
