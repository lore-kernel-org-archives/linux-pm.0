From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Thu, 22 Jun 2006 15:31:06 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606221527590.6483@g5.osdl.org>
References: <Pine.LNX.4.44L0.0606211219170.6700-100000@iolanthe.rowland.org>
	<Pine.LNX.4.64.0606210937090.5498@g5.osdl.org>
	<1150938119.16303.99.camel@localhost.localdomain>
	<Pine.LNX.4.64.0606211844590.5498@g5.osdl.org>
	<1150946286.947.50.camel@localhost.localdomain>
	<Pine.LNX.4.64.0606212105220.5498@g5.osdl.org>
	<1150952298.3633.20.camel@localhost.localdomain>
	<Pine.LNX.4.64.0606220909220.5498@g5.osdl.org>
	<1151014893.4046.24.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1151014893.4046.24.camel@localhost.localdomain>
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

> The problem is that what you call "controller setup" might well happen
> as part of normal operations of a given device.

Give one _reasonable_ example.

> I think you are trying to change a model that is not broken...

Bzzt. Thank you for playing. =


The fact is, this thing has been broken for years. At some point, we have =

to just accept the fact that it's not just "drivers". There's something =

else that is broken, and I bet it's the model.

The fact that drivers don't get fixed should be a big hint.

And yes, maybe I'm wrong, but even if I am, what have we got to lose? =

Nothing. The thing doesn't work reliably now.

And you haven't actually answered any of my fundamental issues, which =

boils down to

 - debuggability
 - not doing five things in the same routine.

but instead you have brought up total red herrings that have nothing to do =

with either (including apparently the totally ludicrous claim that it's =

"easier" for drivers to have just one complicated function).

		Linus
