From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Sun, 8 Jul 2007 23:01:58 +0200
Message-ID: <20070708210158.GB5401__27518.2325196967$1183928567$gmane$org@elf.ucw.cz>
References: <1183871661.3388.282.camel@localhost.localdomain>
	<Pine.LNX.4.44L0.0707081517540.11049-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0707081517540.11049-100000@netrider.rowland.org>
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
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-kernel@vger.kernel.org, Kyle Moffett <mrmacman_g4@mac.com>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi!

> > There are two things I believe. There's a generic issue with usermode
> > helpers that make no sense to call between pre-suspend and
> > post-resume, and there's the specific issue of adding/removing
> > devices.
> > 
> > I believe that "bus" drivers such as USB should indeed get a first
> > round of notifications to tell them to stop performing bus
> > plug/unplug operations (it's debatable whether we want to keep unplug
> > going provided we can stack up the usermode events and re-send them
> > later though, but let's say no for the sake of simplicity).
> 
> Yes.  Rafael, how close is your new notifier chain to mainline?  Can it 
> at least be added to Greg KH's development tree so that I can start 
> using it?

It should be in -mm, IIRC.

> > I think it's a fairly significant change from the current freezer and I
> > also think it's a very good idea. The more I think about it, the more I
> > like it, in the sense that it's a simple drop-in that you could put in a
> > lot of the ioctl path of drivers to just block tasks that are trying to
> > call in while suspending, and could be used selectively by things like
> > the USB hub threads.
> 
> That's what I had in mind.  Rafael, can we add an "icebox" routine?  
> Like Ben says, it doesn't need to be much more than a waitqueue
> that the current task puts itself on if a suspend is in progress.  
> Callers arriving at a time when the icebox isn't activated should
> simply return without blocking.  Basically the icebox should be active 
> at the same times as the existing freezer.

You could use try_to_freeze(), but you want it to be separate routine
so it can be grepped for... Can you #define icebox_me try_to_freeze
for testing?
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
