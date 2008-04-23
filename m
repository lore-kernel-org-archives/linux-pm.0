From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: device_pm_add (was: Re: 2.6.25-git2: BUG: unable to
 handle kernel paging request at ffffffffffffffff)
Date: Wed, 23 Apr 2008 10:56:55 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0804231047500.2104-100000__11035.2553231225$1208962807$gmane$org@iolanthe.rowland.org>
References: <200804230250.26159.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200804230250.26159.rjw@sisk.pl>
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
Cc: Jiri Slaby <jirislaby@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Zdenek Kabelac <zdenek.kabelac@gmail.com>, pm list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, paulmck@linux.vnet.ibm.com, Linus Torvalds <torvalds@linux-foundation.org>, David Miller <davem@davemloft.net>, herbert@gondor.apana.org.au
List-Id: linux-pm@vger.kernel.org

On Wed, 23 Apr 2008, Rafael J. Wysocki wrote:

> > > Are drivers supposed to register children of suspended devices?  That doesn't
> > > make much sense IMO ...
> > 
> > Well, that's why I think the warning itself makes sense - and then we can 
> > decide whether it makes sense for that particular case or not. Clearly it 
> > happens (since it triggered), now we need to figure out _why_ it happened. 
> 
> Well, this particular case looks like a race to me.

I think the reason it happened is clear enough.  Call it a race if you 
want, but the window is so large that it hardly qualifies.

It's a result of the way the MMC core is written.  There's an
upper-level controller device, and below that is a host device, and
below that is the card itself.  The code that adds and removes children
of the host device runs as part of the controller driver.

Hence the problem: The driver adds children below the _host_ as soon as 
the _controller_ is resumed, even though the host is still suspended.  
It's not as big an error as it sounds -- the host was originally a 
class_device and then got converted over to a regular device.  It 
doesn't have a driver of its own.

This is one of the things that needs to be fixed up as part of the 
reworking of the system-sleep API.  I simply haven't had any time to 
work on it (and I'm not likely to in the near future).

You ought to be able to provoke this more or less at will, depending on
the order in which your PCI devices are probed, by inserting or
removing an MMC card during the disk spin-up interval while the system
is waking up.

Alan Stern
