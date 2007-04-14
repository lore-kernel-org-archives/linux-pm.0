From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Linux 2.6.21-rc6
Date: Sat, 14 Apr 2007 11:05:55 +0200
Message-ID: <200704141105.56265.rjw@sisk.pl>
References: <Pine.LNX.4.64.0704051944230.6730@woody.linux-foundation.org>
	<20070413235017.GR5907@stusta.de>
	<20070414081619.GA24909@melchior.yamamaya.is-a-geek.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070414081619.GA24909@melchior.yamamaya.is-a-geek.org>
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
To: Tobias Diedrich <ranma+kernel@tdiedrich.de>
Cc: linux-pm@lists.osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Adrian Bunk <bunk@stusta.de>
List-Id: linux-pm@vger.kernel.org

On Saturday, 14 April 2007 10:16, Tobias Diedrich wrote:
> Adrian Bunk wrote:
> > On Fri, Apr 13, 2007 at 11:29:55PM +0200, Tobias Diedrich wrote:
> > > Linus Torvalds wrote:
> > > =

> > > > We should be getting close to a 2.6.21 release, so please update an=
y =

> > > > regression reports you've done,
> > > =

> > > For me, suspend to disk works only once (has been the case for all
> > > .21-rcs IIRC, but I didn't get around to report it so far).
> > > There are some threads about an issue like this, which is supposed
> > > to be fixed by disabling CONFIG_PCI_MSI, but on my system the
> > > problem persists nonetheless.
> > > =

> > > On the second suspend attempt, the last message I see is
> > > "Suspending console(s)"
> > > =

> > > If I find the time, I'll try to bisect it this weekend.
> > >...
> > =

> > Does the latest -git work?
> =

> Still no luck with
> Linux melchior 2.6.21-rc6-gd791d413-dirty #4 PREEMPT Sat Apr 14 09:34:21 =
CEST 2007 x86_64 GNU/Linux

Can you boot with init=3D/bin/bash and see if the problem is present in this
configuration?

Rafael
