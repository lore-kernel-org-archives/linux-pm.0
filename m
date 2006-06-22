From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/2] Fix console handling
	during	suspend/resume
Date: Fri, 23 Jun 2006 09:11:51 +1000
Message-ID: <1151017911.4046.55.camel@localhost.localdomain>
References: <Pine.LNX.4.44L0.0606211219170.6700-100000@iolanthe.rowland.org>
	<Pine.LNX.4.64.0606210937090.5498@g5.osdl.org>
	<1150938119.16303.99.camel@localhost.localdomain>
	<Pine.LNX.4.64.0606211844590.5498@g5.osdl.org>
	<1150946286.947.50.camel@localhost.localdomain>
	<Pine.LNX.4.64.0606212105220.5498@g5.osdl.org>
	<1150952298.3633.20.camel@localhost.localdomain>
	<Pine.LNX.4.64.0606220909220.5498@g5.osdl.org>
	<1151014893.4046.24.camel@localhost.localdomain>
	<Pine.LNX.4.64.0606221527590.6483@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606221527590.6483@g5.osdl.org>
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

On Thu, 2006-06-22 at 15:31 -0700, Linus Torvalds wrote:
> =

> On Fri, 23 Jun 2006, Benjamin Herrenschmidt wrote:
> > =

> > The problem is that what you call "controller setup" might well happen
> > as part of normal operations of a given device.
> =

> Give one _reasonable_ example.

automatic rotating keys is one that came to mind, automatic controller
timing demotion is another,
I could certainly find more... damn even hard disks have that sort of
state (think about host protected area setting.. ok unlikely that this
changed in the middle of a suspend cycle unless you hotswap just at the
wrong time).

However there aren't that many examples tho becasue there is not that
many state that need to be saved ! (which adds to my argument that
save_state is generally not even needed and thus by splitting it out,
you won't really help your debugging problem).

> > I think you are trying to change a model that is not broken...
> =

> Bzzt. Thank you for playing. =


I really think it's not that model that is broken :)

> The fact is, this thing has been broken for years. At some point, we have =

> to just accept the fact that it's not just "drivers". There's something =

> else that is broken, and I bet it's the model.

Why ? I have fixed drivers used on powermac and it works like a charm.
Drivers are broken, the model is sane. really.

> The fact that drivers don't get fixed should be a big hint.

The main reason is the video problem (chips not coming back on resume
and needing a POST). This has always been the main issue and that's what
is causing STR not to work for a lot of people.

> And yes, maybe I'm wrong, but even if I am, what have we got to lose? =

> Nothing. The thing doesn't work reliably now.

The model does and I think your model would 1- break all existing
drivers that got it right since they have to be changed and 2- won't
help with the actual problems :)

> And you haven't actually answered any of my fundamental issues, which =

> boils down to
> =

>  - debuggability
>  - not doing five things in the same routine.

I'm confident you won't get help on the first one, by splitting
save_state since that's not that which is a problem, but the actual
suspend.

The later, well, it just has to be that way. (And it's not 5, it's 3 and
actually boils down to 2 in most drivers since there is nothing to save
and the first one, blocking of userland activity, usually tends to be a
one liner with the appropriate support from the subsystem).
  =

> but instead you have brought up total red herrings that have nothing to d=
o =

> with either (including apparently the totally ludicrous claim that it's =

> "easier" for drivers to have just one complicated function).

I've brought a real concern that you'll resume devices in a different
state than what was last set at suspend time and change a model that
isn't broken.

Ben.
