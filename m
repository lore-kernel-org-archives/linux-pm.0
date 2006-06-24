From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Fri, 23 Jun 2006 21:04:10 -0700
Message-ID: <200606232104.11131.david-b@pacbell.net>
References: <Pine.LNX.4.44L0.0606211219170.6700-100000@iolanthe.rowland.org>
	<20060624024230.GB3438@neo.rr.com>
	<Pine.LNX.4.64.0606231953560.6483@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606231953560.6483@g5.osdl.org>
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
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On Friday 23 June 2006 8:12 pm, you wrote:

> For example, on the run-time management, if we shut things down not as a =

> "pci_device" but as a "network device" (which just happens to be _bound_ =

> to a pci device), we could very easily do the highlevel network device =

> crap to make sure that we don't get entered that way _first_. And do it i=
n =

> just one place.

Heh, I said as much in a recent note.  The issue is that the network
stack doesn't know suspend from joe.  If "eth0" had a real "struct device",
that solution should work ... and simplify lots of driver suspend and
resume methods.  Backwards compat would be an issue though.


> > One thing that might help us get there is if we passed a suspend notifi=
cation
> > to the class devices (i.e. the higher level subsystems).
> =

> Good point. We probably should. That really really makes sense, and that =

> also automagically solves the "network device" issue.

I'm not sure doing that with class devcies is the right idea, at least
until they show up in the driver model tree as physical children of the
parent hardware (so that the driver model tree automatically handles
sequence constraints.

- Dave
