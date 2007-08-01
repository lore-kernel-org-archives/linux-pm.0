From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Re: Hibernation considerations
Date: Wed, 1 Aug 2007 09:34:37 +0000
Message-ID: <20070801093437.GC4808__45343.5390991673$1186070628$gmane$org@ucw.cz>
References: <200707202335.05519.oliver@neukum.org>
	<Pine.LNX.4.44L0.0707201820050.5241-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0707201820050.5241-100000@iolanthe.rowland.org>
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
Cc: David Lang <david@lang.hm>, LKML <linux-kernel@vger.kernel.org>, Milton Miller <miltonm@bga.com>, Ying Huang <ying.huang@intel.com>, linux-pm <linux-pm@lists.linux-foundation.org>, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

Hi!

> >  Do we have to block module loading?
> 
> No.  Registering new drivers is okay, registering new devices is bad.
> 
> Of course, some modules do want to register a new device in their init 
> method.  I don't know what we should do about them.  Force the 
> registration to fail, I suppose.  How often will people suspend while a 
> module is loading?

Well... plug this pcmcia card into the slot so that I do not have to
carry it separately, close the lid and go?

...not that impossible to imagine...
							Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
