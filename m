From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/2] Fix console handling
	during	suspend/resume
Date: Wed, 21 Jun 2006 08:47:45 +1000
Message-ID: <1150843666.1901.46.camel@localhost.localdomain>
References: <20060614103404.GC28536@elf.ucw.cz>
	<200606160704.34093.david-b@pacbell.net>
	<Pine.LNX.4.64.0606161114110.5498@g5.osdl.org>
	<200606181016.47561.david-b@pacbell.net>
	<Pine.LNX.4.64.0606181040200.5498@g5.osdl.org>
	<Pine.LNX.4.64.0606181113000.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606181113000.5498@g5.osdl.org>
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


> I think the first option is the one that actually works. Right now, to ge=
t =

> my machine to suspend successfully (with the current broken "suspend =

> everything"), I have to turn off the console much much _much_ too early. =

> That's what I'm trying to get away from.

I don't think you'll ever get anything stable if you separate freeze and
suspend. I've been implementing working suspend for some time now, and
I've seen it done on other operating systems, and I really think there
is no way out of the very simple fact that suspend is just a superset of
freeze. STD need a freeze pass, STR needs a freeze+suspend pass. You
might want to imagine all sort of reasons why it _would_ be theorically
possible for drivers to recover from STR on resume without having frozen
anything as part of the suspend process but I'm absolutely convinced
that all this will lead to is a suspend process that is even less stable
and more broken than what we have today.

Ben.
