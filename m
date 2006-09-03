From: Pavel Machek <pavel@ucw.cz>
Subject: Re: So, what's the status on the recent patches here?
Date: Mon, 4 Sep 2006 00:25:13 +0200
Message-ID: <20060903222513.GG9991@elf.ucw.cz>
References: <200609032212.k83MCMdR010881@olwen.urbana.css.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <200609032212.k83MCMdR010881@olwen.urbana.css.mot.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
Cc: scott.preece@motorola.com, matthew.a.locke@comcast.net, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On Sun 2006-09-03 17:12:22, Scott E. Preece wrote:
> | From: Pavel Machek<pavel@ucw.cz>

> | > But, surely that distinction can be handled in the implementation beh=
ind
> | > the interface, rather than exsposed in the interface.  Does that
> | > distinction matter to the policy manager?  I would argue that it
> | > increases the latency, which would be important to the policy manager,
> | > but that the nature of the latency isn't important to making a policy
> | > decision,  and the proposed interface already exposes the latency as
> | > something that can be used in making transition decisions.
> | =

> | Are we talking about the same thing?
> | =

> | If policy manager decides to suspend-to-RAM, it will freeze
> | itself. Puff, it is not running any more.
> ---
> =

> Well, I assume the policy manager is telling something in the kernel to
> actually set the operating point. Once it has made that request, it
> doesn't need to run any longer.

And how will it tell the kernel to get back to some _operating_
point? (As opposed to "off-suspended-to-disk"?)

You see, that interface even causes problems in our (human!)
comunication. Some of operating points are not really operating!

> | Of course, we could use same interface for both. No, it is not good
> | idea. We want reasonably clean interface. If it means rewriting
> | powerop two or three times... we'll need to do it.
> ---
> =

> Not speaking to either of the current code submissions, I would say that
> having a kernel interface for defining OPs and a kernel interface for
> setting the OP, was a reasonably clean interface.

Well, me and Rafael disagree, and you do not really listen to
arguments. Now you can either fix the interface, or try to submit code
to lkml despite our NAKs. Go ahead and prepare for some flaming...

(But I'd rather have you fix the interface.)

									Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
