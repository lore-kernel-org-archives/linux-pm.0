From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Wed, 21 Jun 2006 21:08:47 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606212105220.5498@g5.osdl.org>
References: <Pine.LNX.4.44L0.0606211219170.6700-100000@iolanthe.rowland.org>
	<Pine.LNX.4.64.0606210937090.5498@g5.osdl.org>
	<1150938119.16303.99.camel@localhost.localdomain>
	<Pine.LNX.4.64.0606211844590.5498@g5.osdl.org>
	<1150946286.947.50.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1150946286.947.50.camel@localhost.localdomain>
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

> I never said your thing was introducing those problems, we are
> misunderstanding each other there. I want that prepare() thing and
> wanted it for some time now to fix an existing problem :) I still
> disagree with the save_state/suspend split for the reason I exposed
> later in the email.

You can use save_state() for your "prepare()" if you want to, but I don't =

see what you are disagreeing or arguing about then.

> With a split save_state/suspend, you can end up with the scenario where
> =

>  1- save state saves the device "state", that includes the keys in the
> controller
>  2- client above calls you to change the keys
>  3- suspend
>  4- restore_state
> =

> At that point, what keys are you restoring ?

You don't _do_ that, Ben.

If you did that, you'd get the old keys. =


Your complaint is like

  "Doctor, doctor, it hurts when I dig out my eyes with a dull spool"

OF COURSE it hurts. Don't do it.

Your example is insane.

			Linus
