From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/2] Fix console handling
	during	suspend/resume
Date: Sat, 24 Jun 2006 10:29:27 +1000
Message-ID: <1151108967.16946.43.camel@localhost.localdomain>
References: <Pine.LNX.4.44L0.0606211219170.6700-100000@iolanthe.rowland.org>
	<200606221130.30614.david-b@pacbell.net>
	<Pine.LNX.4.64.0606221210350.5498@g5.osdl.org>
	<200606231106.46863.david-b@pacbell.net>
	<Pine.LNX.4.64.0606231216290.6483@g5.osdl.org>
	<20060623233244.GB4264@neo.rr.com>
	<Pine.LNX.4.64.0606231622580.6483@g5.osdl.org>
	<1151108543.16946.41.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1151108543.16946.41.camel@localhost.localdomain>
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
Cc: David Brownell <david-b@pacbell.net>, linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

> That's bullshit. How can USB operate without interrupts ? It can't. Thus
> the final suspend will not be useable for anything below a USB
> controller. Among others... That means that every driver that needs to
> talk to it's hardware will have to run with "interrupts off"... thus
> every driver will need some kind of demoted polled mode that they don't
> necessarily have.
> =

> Thus your "final suspend" ends up only being useful for a small subset
> of drivers
> =

> Also there is nothing magic about "interrupts have been turned off".
> It's no magic, it won't prevent everything from happening. How do you
> make sure you weren't in the middle of driver routine already ? You
> can't. Thus you need your driver to _also_ be able to recover of suspend
> being called at any fucking time while it was doing something and not be
> able to synchrnize with things like semaphores etc...

And the total non-applicability of this model to runtime suspend of
individual devices of course..

Ben.
