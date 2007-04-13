From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH][RFC] Kill off legacy power management stuff.
Date: Fri, 13 Apr 2007 02:51:50 -0700
Message-ID: <200704130251.50655.david-b@pacbell.net>
References: <Pine.LNX.4.64.0704122025380.3628@CPE00045a9c397f-CM001225dbafb6>
	<200704131022.45315.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200704131022.45315.rjw@sisk.pl>
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
To: linux-pm@lists.linux-foundation.org
Cc: "Robert P. J. Day" <rpjday@mindspring.com>, Pavel Machek <pavel@ucw.cz>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Friday 13 April 2007 1:22 am, Rafael J. Wysocki wrote:
> [appropriate CCs added]
> =

> On Friday, 13 April 2007 02:33, Robert P. J. Day wrote:
> > =

> > just something i threw together, not in final form, but it represents
> > tossing the legacy PM stuff.  at the moment, the menuconfig entry for
> > PM_LEGACY lists it as "DEPRECATED", while the help screen calls it
> > "obsolete."  that's a good sign that it's getting close to the time
> > for it to go, and the removal is fairly straightforward, but there's
> > no mention of its removal in the feature removal schedule file.
> =

> It's been like this for a long long time.  I think you're right that it c=
an be
> dropped, but I don't know the details (eg. why it hasn't been dropped yet=
).

I was just thinking about this the other day.  I did an inventory of
the actual _users_ of this code when I added the deprecation to Kconfig,
and the only driver that would catch the notification was for some
old m68k platform serial driver (Amiga?) ... that won't have changed.

So the only reason not to remove it at that time was to make sure that
folk had a chance to squawk about it going away.  I think it's past
time for this ancient stuff to vanish, since it's been obsolete for
most of 2.5..2.6 and there's only that one event consumer left.

Go for it!

- Dave
