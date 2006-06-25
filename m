From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Sat, 24 Jun 2006 18:34:34 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606241831060.6483@g5.osdl.org>
References: <1150946286.947.50.camel@localhost.localdomain>
	<Pine.LNX.4.64.0606221641180.6483@g5.osdl.org>
	<20060622235100.GA4940@elf.ucw.cz>
	<200606231115.21265.david-b@pacbell.net>
	<20060624213522.GE2777@elf.ucw.cz>
	<Pine.LNX.4.64.0606241454030.6483@g5.osdl.org>
	<1151197051.4547.5.camel@localhost.localdomain>
	<Pine.LNX.4.64.0606241802460.6483@g5.osdl.org>
	<1151197953.4547.13.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1151197953.4547.13.camel@localhost.localdomain>
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



On Sun, 25 Jun 2006, Benjamin Herrenschmidt wrote:
> =

> Ah good. Does the driver actuall re-POST the chip completely or is it
> not necessary ?

With integrated memory, it doesn't need to worry about the memory timings, =

so the biggest issue is just the monitor frequency stuff, and detecting =

all the attached monitors (and their types, of course). But I haven't =

actually looked at what all it does, I'm just a happy user.

The really good news being that Intel seems to really support this all (ie =

it's mainly done by people workign for Intel), and they have given up =

their old lying ways of saying that it can only be done by the BIOS, and =

admitted that they were just full of it..

So no reverse engineering needed, and the next generation should hopefully =

be supported right out the gate, with no need to play games.

			Linus
