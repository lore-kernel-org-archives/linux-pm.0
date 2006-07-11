From: Pavel Machek <pavel@ucw.cz>
Subject: Re: RFC -- updated Documentation/power/devices.txt
Date: Tue, 11 Jul 2006 16:40:15 +0200
Message-ID: <20060711144015.GA1616@elf.ucw.cz>
References: <200607101525.43507.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <200607101525.43507.david-b@pacbell.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: David Brownell <david-b@pacbell.net>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

Hi!

> When I did those PM_EVENT_PRETHAW updates I did the Right Thing and
> started to update its in-tree documentation too.  Seems I'm the first
> person to do that in a long time ... anyway, once I tossed in =

> =

> 	- PM_EVENT_PRETHAW
> 	- Linus' suspend_late/resume_early and suspend_prepare
> 	- ... and class suspend/resume
> 	- Wakeup events
> 	- Fixes to the existing docs (confusions, obsolete stuff, ...)
> =

> This turned into more of a rewrite.  So here's my current version,
> which I'm circulating for comments; I'll send it as a patch after
> a few days, for merging when those patches from MM go upstream.
> =

> The focus here was just to have the current ("in MM") methods, parameters,
> and models presented, with enough context to help readers understand the
> "why" as well as the "what" and "when" (and the "huh?").
> =

> Yes, seeing it written out this way does beg some questions.  Like
> what can be done with that (here-deprecated) sysfs attribute thing,
> since it's starting to look even more obviously broken.

Few minor comments:

> Bus driver methods
> ------------------
> The core methods to suspend and resume devices reside in struct bus_type.
> These are mostly of interest to people writing infrastructure for busses
> like PCI or USB, or because they define the primitives that device drivers

", or to people defining the primitives" ?

> struct bus_type {
>        ...
>        int  (*suspend_prepare)(struct device * dev, pm_message_t state);
>        int  (*suspend)(struct device * dev, pm_message_t state);
>        int  (*suspend_late)(struct device * dev, pm_message_t state);
> =

>        int  (*resume)(struct device * dev);
>        int  (*resume_early)(struct device * dev);

Swap last two lines, and order will be nicely chronological.

It would be nice to kill space between * and dev to stay consistent.

> For more information on these driver calls, see the description later;
> they are called in phases for every device, respecting the parent-child
> sequencing in the driver model treee.  Note that at this writing,
> not

"at time of this writing"?
								Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
