From: David Brownell <david-b@pacbell.net>
Subject: Re: Fwd: Re: [Suspend-devel] s2both on powerpc
Date: Thu, 5 Apr 2007 14:38:50 -0700
Message-ID: <200704051438.50653.david-b@pacbell.net>
References: <200704011837.16014.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200704011837.16014.rjw@sisk.pl>
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
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: =?iso-8859-1?q?C=E9dric_Boutillier?= <cedric.boutillier@gmail.com>, pm list <linux-pm@lists.linux-foundation.org>, Johannes Berg <johannes@sipsolutions.net>
List-Id: linux-pm@vger.kernel.org

On Sunday 01 April 2007 9:37 am, Rafael J. Wysocki wrote:
> Alan, Dave, could you please have a look at this?
> =

> Rafael
> =

> =

> ----------  Forwarded Message  ----------
> =

> Subject: Re: [Suspend-devel] s2both on powerpc
> Date: Sunday, 1 April 2007 18:18
> From: "C=E9dric Boutillier" <cedric.boutillier@gmail.com>
> To: "Johannes Berg" <johannes@sipsolutions.net>
> Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, "Tim Dijkstra" <newsuser@famdijkst=
ra.org>,
>	 suspend-devel@lists.sourceforge.net =

> =

> Hi !
> On 4/1/07, Johannes Berg <johannes@sipsolutions.net> wrote:
> > Have you gotten it to resume?
> > I'd test s2both but I haven't gotten s2disk to resume yet... Need to
> > test that patch.
> =

> Yes it resumes, but I am stuck at some point because after the image
> is reloaded from swap, the system freezes when (usb) modules are
> reloaded.

Which module?  I'm guessing just ehci-hcd, but you should try each
of the relevant HCDs by themselves.  (And if you have any external
USB devices connected, their drivers ... and also see whether the
connection of the external device is itself a factor.)

There's something platform-specific going on, and some clues will
be needed to sort it out.

All this used to work, as I recall...

- Dave




> That is a problem I got with suspend-to-disk with recent =

> kernels : 2.6.18 leads to oops, and 2.6.20 / 2.6.21-rc5 lead to
> lockup.
> =

> If I unload usb modules before suspending, the system resumes and I
> get a prompt, but I get also some errors from usb (root hub lost power
> or was reset). (see
> http://marc.info/?l=3Dlinux-usb-devel&m=3D117528005511118&w=3D2)
> I would appreciate If you had an idea on that .
> =

> =

> Cedric
> =
