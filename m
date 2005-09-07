From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: swsusp doesn't suspend devices
Date: Wed, 7 Sep 2005 22:40:42 +0200
Message-ID: <200509072240.42854.rjw@sisk.pl>
References: <431ECCE3.8080408@drzeus.cx> <200509072203.19283.rjw@sisk.pl>
	<431F4AC4.9030206@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <431F4AC4.9030206@drzeus.cx>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: linux-pm@osdl.org, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Wednesday, 7 of September 2005 22:17, Pierre Ossman wrote:
> Rafael J. Wysocki wrote:
> 
> >On Wednesday, 7 of September 2005 13:20, Pierre Ossman wrote:
> >  
> >
> >>It would seem that swsusp doesn't properly suspend devices, or more
> >>precisely it wakes them up again before suspending the machine.
> >>    
> >>
> >
> >Yes, it does.  By design.
> >
> >  
> >
> 
> That seems counter-productive, so I'm obviously missing something.

In swsusp, the suspend consists of freezing processes, suspending devices, turning off
interrupts, and creating a memory snapshot (the image) in that state (ie of the "frozen"
system).  Afterwards the image is in memory and it has to be written to a swap partition.
For this purpose we need to resume some devices, in particular the disk that contains
this swap partition, but it always relies on some other devices that have to be resumed
as well.  In principle we could check what devices have to be resumed, but currently
we just resume them all.  An additional upside of this approach is that the suspend
and resume code is (almost) identical.

Greetings,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
