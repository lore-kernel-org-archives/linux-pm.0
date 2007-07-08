From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Sun, 8 Jul 2007 20:26:53 +0200
Message-ID: <200707082026.54145.rjw__27903.884164016$1183918849$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0707072218030.10912-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0707072218030.10912-100000@netrider.rowland.org>
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
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-kernel@vger.kernel.org, Kyle Moffett <mrmacman_g4@mac.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Sunday, 8 July 2007 04:24, Alan Stern wrote:
> On Sun, 8 Jul 2007, Benjamin Herrenschmidt wrote:
> 
> > > Which is exactly my point.  It _doesn't_ work fine without a freezer, 
> > > because the USB stack currently relies on the freezer to prevent plug 
> > > activity.
> > 
> > Putting on hold plug activity has nothing, NOTHING, to do with the half
> > assed piece of deadlocking crap we have now we call a freezer.
> 
> You're wrong; it _does_ have something to do with the freezer.  The 
> connection is that the code uses the freezer to put plug activity on 
> hold.
> 
> You probably meant to say that it _should_ have nothing to do with the 
> freezer.  That's a different matter.  But in any case you should write 
> what you actually mean, rather than just putting down something as 
> inflammatory as possible.
> 
> > As long as you guys keep mixing up all the issues and coming up with
> > totally bogus solutions that cannot work, we won't have a useful suspend
> > (either to RAM or to disk) in linux.
> 
> In my defense, you should realize that until Rafael's notifier chain
> was added (just a few weeks ago, still not in mainline I believe) there
> was no other way to do it.  Plug activity needs to be stopped before
> the child devices are suspended, and the PM core does not send any
> notification to drivers at that time.  All it does is activate the 
> freezer.

Exactly.

And if we really want to get rid of the freezer, we need to _prepare_ for
that.  At least, we need to have an idea of how we will do thing when the
freezer is not there.

For example, how will we check if the system is not in a state in which the
resume is likely to fail?

There are more questions like that, IMO, and we should at least have a list
of them _before_ we remove the freezer.

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
