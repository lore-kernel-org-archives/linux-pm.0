From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Sun, 25 Jun 2006 10:15:29 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606251012470.3747@g5.osdl.org>
References: <Pine.LNX.4.44L0.0606211219170.6700-100000@iolanthe.rowland.org>
	<20060624024230.GB3438@neo.rr.com>
	<Pine.LNX.4.64.0606231953560.6483@g5.osdl.org>
	<200606232104.11131.david-b@pacbell.net>
	<20060625082328.GC4264@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060625082328.GC4264@neo.rr.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Adam Belay <ambx1@neo.rr.com>
Cc: David Brownell <david-b@pacbell.net>, Kay Sievers <kay.sievers@vrfy.org>, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org



On Sun, 25 Jun 2006, Adam Belay wrote:
> =

> P.S.:  Linus, what are your thoughts on passing a mirror image of the sus=
pend
> callbacks we provide (or will provide) for the device interface to the cl=
ass
> device interface?  In other words, allow it to also get suspend_prepare(),
> resume_finish(), etc. to encourage the sort of abstraction suggested abov=
e.

I don't think the suspend_late() case in particular makes much sense (what =

could a class do at that late a point?), but I'm certainly not against it =

if people figure out a real use.

I'd like the current single entry-point to be made usable first, though. =

Right now it "exists", but I don't think you can necessarily use it =

because the class doesn't necessarily have a mapping from "struct device" =

to whatever class instance it's a class of.

(That might depend on the class, of course, I didn't really look into it)

		Linus
