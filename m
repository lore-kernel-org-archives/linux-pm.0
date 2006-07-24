From: David Brownell <david-b@pacbell.net>
Subject: Re: RFC -- updated Documentation/power/devices.txt
Date: Sun, 23 Jul 2006 20:22:23 -0700
Message-ID: <200607232022.24854.david-b@pacbell.net>
References: <Pine.LNX.4.44L0.0607230843160.31932-100000@netrider.rowland.org>
	<200607240045.13724.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200607240045.13724.rjw@sisk.pl>
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
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On Sunday 23 July 2006 3:45 pm, Rafael J. Wysocki wrote:
> On Sunday 23 July 2006 15:03, Alan Stern wrote:
> > On Sun, 23 Jul 2006, Rafael J. Wysocki wrote:
> > ... In other words, devices get restored to the state =

> > they were in before suspend.
> =

> Yes.
>
> > I don't see anything wrong with that.  It does raise some more question=
s.
> > =

> > 	Who should be responsible for remembering the device's state
> > 	from before the system suspend: the PM core or the driver?
> > 	(Note that the driver has a better idea of what that state
> > 	actually was.)
> =

> It seems to be easier to leave it to the driver.

Just the way any true runtime pm operation would be, yes?


> However, I think the core =

> needs to have at least some control over it.   Otherwise, for example,
> the detection of misbehaving drivers would be quite difficult, IMHO.

Remember that the definition of runtime PM under discussion is:

> > >    2   While the system is running, independently of other power mana=
gement
> > >        activity.  Upstream drivers will normally not know (or care) i=
f the
> > >        device is in some low power state when issuing requests; the d=
river
> > >        will auto-resume anything that's needed when it gets a request.

That excludes the core having any such "control", or the ability to "detect"
such misbehavior.  (And why would it be misbehavior, when the difference is
irrelevant to upstream drivers issuing requests to that device?)  No matter
what state the device resumes into, the only architectural requirement is
that it respond as if it were fully "on".  Because runtime low power states
are exactly equivalent to "fully operational" except they use less power.


> > 	Upon resuming from a system suspend, is it better to tell the
> > 	driver to "go directly to the saved state" or to turn the
> > 	device back fully ON and then change to the saved state (if it =

> > 	wasn't fully ON before the system suspend)?
> =

> I think the rule should be "go directly to the saved state", if possible.

Agreed, though as I described above it's not something that can be
detected outside of that driver without actually measuring the power
drain that driver imposes on the system.

- Dave
