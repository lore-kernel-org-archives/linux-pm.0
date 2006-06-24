From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Fri, 23 Jun 2006 21:35:35 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606232132311.6483@g5.osdl.org>
References: <Pine.LNX.4.44L0.0606211219170.6700-100000@iolanthe.rowland.org>
	<20060624024230.GB3438@neo.rr.com>
	<Pine.LNX.4.64.0606231953560.6483@g5.osdl.org>
	<200606232104.11131.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200606232104.11131.david-b@pacbell.net>
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
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org



On Fri, 23 Jun 2006, David Brownell wrote:
> =

> > Good point. We probably should. That really really makes sense, and tha=
t =

> > also automagically solves the "network device" issue.
> =

> I'm not sure doing that with class devcies is the right idea, at least
> until they show up in the driver model tree as physical children of the
> parent hardware (so that the driver model tree automatically handles
> sequence constraints.

See the example (admittedly untested) patch.

You obviously have to walk the devices in _bus_ order, but once you do, =

there's nothing that prevents you from them using the _class_ suspend to =

help suspend that device.

The fact that we can suspend with a class function does not mean that we =

have to _walk_ with a class order.

So in a very real sense, the classes _do_ show up as physical children of =

the parent hardware: they show up as instances of devices.

				Linus
