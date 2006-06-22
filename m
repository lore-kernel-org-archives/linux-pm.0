From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Thu, 22 Jun 2006 16:19:46 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606221614280.6483@g5.osdl.org>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1151017911.4046.55.camel@localhost.localdomain>
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
> =

> The main reason is the video problem (chips not coming back on resume
> and needing a POST). This has always been the main issue and that's what
> is causing STR not to work for a lot of people.

No.

Not for me. Every single time something doesn't work for me, I just plug =

it into the network and try to debug it over the net.

Not on _one_ laptop has that helped. Ever.

Maybe I just happen to have screwy laptops, but I don't believe so.

It wasn't the reason on the mac mini either.

> The model does and I think your model would 1- break all existing
> drivers that got it right since they have to be changed

Actually, it won't break a single driver for STR.

Why? Because if you do it the old way, STR will still happen to work. I'm =

just giving you a separate phase.

But you're not interested in facts, are you? Nope.

>					 and 2- won't
> help with the actual problems :)

So you say. Have you actually ever done anything to make debugging easier?

Nope. In the years I've been frustrated with suspend, nobody has ever done =

anything to this. And now I have to push through changes, just because =

people think that "status quo" is acceptable.

> I've brought a real concern that you'll resume devices in a different
> state than what was last set at suspend time and change a model that
> isn't broken.

And I've explained several times that your concerns aren't problems. You =

just ignore it.

		Linus
