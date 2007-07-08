From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Sun, 08 Jul 2007 10:42:42 +1000
Message-ID: <1183855362.3388.233.camel__37743.3223221034$1183855411$gmane$org@localhost.localdomain>
References: <Pine.LNX.4.44L0.0707071215140.19734-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0707071215140.19734-100000@netrider.rowland.org>
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

On Sat, 2007-07-07 at 12:17 -0400, Alan Stern wrote:
> On Sat, 7 Jul 2007, Benjamin Herrenschmidt wrote:
> 
> > > > And guess what ? It's what we do on powerbooks, and it works fine,
> > > > without a freezer :-)
> 
> > If you remember, one of the things I've been advocating has always been
> > that we should put on hold all plug activity (unplug might be alright as
> > long as the user events are just delayed) when we start suspending. No
> > new devices, no new bindings. "hub" type devices are respondible for
> > bringing in the new stuff after resume.
> 
> Which is exactly my point.  It _doesn't_ work fine without a freezer, 
> because the USB stack currently relies on the freezer to prevent plug 
> activity.

Putting on hold plug activity has nothing, NOTHING, to do with the half
assed piece of deadlocking crap we have now we call a freezer.

As long as you guys keep mixing up all the issues and coming up with
totally bogus solutions that cannot work, we won't have a useful suspend
(either to RAM or to disk) in linux.

Ben.
