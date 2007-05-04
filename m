From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Re: [PATCH] swsusp: do not use pm_ops (was: Re:
	suspend2 merge (was: Re: CFS and suspend2: hang in atomic copy))
Date: Fri, 4 May 2007 23:11:22 +0200
Message-ID: <200705042311.23557.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0705041054520.3417-100000@iolanthe.rowland.org>
	<200705042250.29760.rjw@sisk.pl>
	<1178311750.7408.34.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1178311750.7408.34.camel@johannes.berg>
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
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-pm@lists.linux-foundation.org, Pekka Enberg <penberg@cs.helsinki.fi>, Nigel Cunningham <nigel@nigel.suspend2.net>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Friday, 4 May 2007 22:49, Johannes Berg wrote:
> On Fri, 2007-05-04 at 22:50 +0200, Rafael J. Wysocki wrote:
> 
> > To prevent this from happening, we need a separate set of hibernation callbacks
> > in device drivers.
> 
> You *can* actually do that now with prethaw and all that afaict.

Actually, prethaw is to prevent drivers loaded before the image is restored
from doing unreasonable things.  It doesn't have any effect on the drivers'
.resume() routines.

Besides, if the drivers in question are compiled as modules and not loaded
before the image is restored, prethaw doesn't have any effect on them and
on their devices at all. ;-)

> But all the more argument for splitting up the callbacks as discussed
> previously.

Yes.

Greetings,
Rafael
