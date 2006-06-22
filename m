From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Thu, 22 Jun 2006 09:10:04 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606220909220.5498@g5.osdl.org>
References: <Pine.LNX.4.44L0.0606211219170.6700-100000@iolanthe.rowland.org>
	<Pine.LNX.4.64.0606210937090.5498@g5.osdl.org>
	<1150938119.16303.99.camel@localhost.localdomain>
	<Pine.LNX.4.64.0606211844590.5498@g5.osdl.org>
	<1150946286.947.50.camel@localhost.localdomain>
	<Pine.LNX.4.64.0606212105220.5498@g5.osdl.org>
	<1150952298.3633.20.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1150952298.3633.20.camel@localhost.localdomain>
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



On Thu, 22 Jun 2006, Benjamin Herrenschmidt wrote:
> =

> How so ? What is insane in expecting that settings you have done to your
> controller are restored to the last settings you did when you resume ?

No. It's insane to do controller setup while a suspend is going on. We can =

make it impossible if you want (easy enough - just stop user land), but =

the point is that you're worrying about ALL THE WRONG THINGS.

The fact that worries me is that suspend-to-ram DOES NOT WORK FOR PEOPLE. =

I have never _ever_ met a laptop or machine of mine that "just worked". =

I've always had to fix something, and people always end up having to do =

something ridiculous like unlink all modules etc.

If that isn't what worries you, you're on the wrong page. =


Bah. I don't care. =


		Linus
