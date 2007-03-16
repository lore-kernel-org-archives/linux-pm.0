From: David Brownell <david-b@pacbell.net>
Subject: Re: Alternative Concept
Date: Thu, 15 Mar 2007 23:17:12 -0700
Message-ID: <200703152317.13398.david-b@pacbell.net>
References: <44ECFF94.3030506@gmail.com>
	<200703151921.55310.david-b@pacbell.net>
	<484380240703152056w44d14c71tff4457c07c6bdbbc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <484380240703152056w44d14c71tff4457c07c6bdbbc@mail.gmail.com>
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
To: Ikhwan Lee <dlrghks@gmail.com>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>, Pavel Machek <pavel@ucw.cz>, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On Thursday 15 March 2007 8:56 pm, Ikhwan Lee wrote:
> Hi,
> =

> Although I agree that the current clock framework can handle power or
> voltage domains in many platforms, having something like (struct clk
> powerdomain1, powerdomain2;) does not seem like a good implementation,
> a struct for clocks representing a power domain.

Good thing that's not what I suggested then, right?  :)

The point was that in the examples I've seen, the power domains
are associated with clock domains, so that each clock is tied
to one power domain.  And since you can't use the power domain
without having a clock ... the implementation can tell if it's
got to activate a power domain by looking at the clock.

There may be other models of power domain, but that's the one
I've had reason to look at (which isn't synonymous with a straight
voltage/current supply).


> If a new framework is more straighforward and introduces a negligible
> overhead to the current kernel, I think it is worthwhile to have a
> look at it. Plus this new framework might be able to take care of
> those platforms that are not nicely supported by the current clock
> framework.

Perhaps when we see one, we could discuss that as somethong other
than pure handwaving.  But that still won't address the basic point
that it's wrong to assume the clock framework should be written out
of the picture.

- Dave
