From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Thu, 22 Jun 2006 16:41:07 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606221636210.6483@g5.osdl.org>
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
	<1151017911.4046.55.camel@localhost.localdomain>
	<Pine.LNX.4.64.0606221614280.6483@g5.osdl.org>
	<1151019097.4046.69.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1151019097.4046.69.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: David Brownell <david-b@pacbell.net>, linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org



On Fri, 23 Jun 2006, Benjamin Herrenschmidt wrote:
> > =

> > So you say. Have you actually ever done anything to make debugging easi=
er?
> =

> I've implemented suspend/resume for a whole range of machiens where
> everything goes down and all I have to debug on resume is ... sending
> commands to a chip to blink a LED. So yes, I have.

That's not what I asked.

I didn't ask whether you had debugged suspend/resume.

I asked whether you had tried to make it easier.

> None of the problems I've had were ever related to something that would =

> be in save_state.

Ok, I've had very different things happen.

Here's a _fact_:

 - we currently walk the device chain to suspend different devices
 - one device returns an error
 - we've now suspended half the machine, done major things, and we need to =

   undo it
 - the thing fails.

Are you seriously claiming this has never happened to you? It sure has =

happened to me.

And YES, THIS WOULD BE IMPROVED BY MY SCHEME. Instead of getting a machine =

that has suspended partly, and may be effectively dead and unable to even =

tell the user that it failed half-way through, it would not have suspended =

anything at all, and just say "Sorry, I can't do that".

Adn yes, this is a _direct_ result of THE BROKEN CONVENTION OF DOING =

EVERYTHING IN SUSPEND()!

But yeah, you go on and ignore it. Because the current scheme is obviously =

all right.

Gahh.

		Linus
