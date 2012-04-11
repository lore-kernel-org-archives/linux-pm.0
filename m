From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC] Runtime PM for host controllers
Date: Wed, 11 Apr 2012 10:30:07 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1204111019390.1351-100000@iolanthe.rowland.org>
References: <CAJiQ=7A=744EZ1pW0vmpW=+CgdoDBYT0vc-=182Y8eU-3pZqvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <CAJiQ=7A=744EZ1pW0vmpW=+CgdoDBYT0vc-=182Y8eU-3pZqvg@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Kevin Cernekee <cernekee@gmail.com>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Tue, 10 Apr 2012, Kevin Cernekee wrote:

> > PCI devices have two different power wells, one for normal use and one
> > for use during suspend.  As far as I know, there is no way to turn off
> > power to the auxiliary well short of turning off the entire computer.
> > Rafael may have a more complete picture.
> 
> That may be the case on PCs,

It should be true on any system -- PC, SoC, or anything else -- that 
uses PCI.  But again, my knowledge is limited.

>  but on many embedded systems (mine
> included), entire hardware blocks can be clock-gated or power-gated
> without shutting off the rest of the system.

Then why isn't there a way to clock-gate or power-gate the parts of a 
hardware block used for data communication while leaving the circuits 
involved in wakeup detection active?  Such a capability is part of the 
EHCI specification.

> Going back to the NAS example I mentioned earlier - I would imagine
> that merely resuming the USB/SATA controller + HDD when a new request
> arrives is going to provide a much faster recovery time than rebinding
> + redetecting + remounting.

Certainly.  And leaving the USB controller suspended but powered up
would be even faster.

Furthermore, what happens when the user plugs in a new USB device, or
unplugs one that is already attached?  The USB specification is very
clear about what device suspend entails; completely turning off the
power violates the spec.

> (Of course that raises issues like: what if somebody unplugs the
> current HDD, then plugs in a different HDD, while the USB/SATA core is
> asleep?)

Right.  Although we do try to detect that sort of thing, since it can
also happen during hibernation.  But our detection methods are not 100%
accurate.

Alan Stern
