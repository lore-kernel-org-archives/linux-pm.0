From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Re: [PATCH] swsusp: do not use pm_ops (was: Re:
	suspend2 merge (was: Re: CFS and suspend2: hang in atomic copy))
Date: Sat, 5 May 2007 12:15:41 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0705051208350.1976-100000@netrider.rowland.org>
References: <1178313830.7408.43.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1178313830.7408.43.camel@johannes.berg>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-pm@lists.linux-foundation.org, Pekka Enberg <penberg@cs.helsinki.fi>, Nigel Cunningham <nigel@nigel.suspend2.net>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Fri, 4 May 2007, Johannes Berg wrote:

> On Fri, 2007-05-04 at 23:11 +0200, Rafael J. Wysocki wrote:
> 
> > Actually, prethaw is to prevent drivers loaded before the image is restored
> > from doing unreasonable things.  It doesn't have any effect on the drivers'
> > .resume() routines.
> 
> Oh, but it can, you could have a flag in your driver saying "the next
> resume is after restore" and you set that flag in prethaw.

You're both wrong.  PRETHAW is to prevent drivers present in the image
from doing reasonable-but-wrong things (because they were misled by
actions taken by the boot kernel or the BIOS before the image was
restored).  It gives the boot kernel's driver a chance to put the device
in a state which won't be misleading.

And while you could have a flag in your driver saying "the next resume is
after restore", setting it during PRETHAW would accomplish nothing.  
PRETHAW occurs immediately before the image is restored, which means the
flag would get overwritten by the contents of the image.

Alan Stern
