From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Thu, 15 Jun 2006 11:31:09 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606151125060.5498@g5.osdl.org>
References: <20060614103404.GC28536@elf.ucw.cz>
	<200606141846.55839.david-b@pacbell.net>
	<20060615084153.GC9423@elf.ucw.cz>
	<200606150957.42449.david-b@pacbell.net>
	<20060615180350.GG23859@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060615180350.GG23859@elf.ucw.cz>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@ucw.cz>
Cc: David Brownell <david-b@pacbell.net>, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org



On Thu, 15 Jun 2006, Pavel Machek wrote:
> =

> Okay, you _can_ do =

> =

> suspend whole tree but disk and video
> freeze disk and video
> create snapshot
> unfreeze disk and video

I really think that's totalyl unnecessary.

At most, you could make the "save_state()" also say "stop listening to =

external stuff" for devices that otherwise do things on their own. That's =

not a "freeze" - the device would still obey commands coming from the =

host - and it would need a "unsave" logic when a suspend fails, but it =

doesn't change the fundamental "save means _save_, not suspend" logic.

And we currently don't have _anything_ like that. Playing games with =

sending different commands down the "suspend()" thing is not ever going to =

work. Drivers are going to do it wrong. We really need to add a =

"save_state()" callback, and it needs to be called that, so that people =

realize that they should not suspend in it.

It would actually simplify and clarify a lot of the confusion we have now. =


I already fixed one driver (sky2) that simply didn't save it's PCI state, =

it just suspended (and then in resume it tried to "restore" the state =

that had never been saved). And I _bet_ that was because it's just a very =

natural thing to do when you look at "suspend()" as an independent op.

So it's actually important - _especially_ for device drivers - to have =

logical and _distinct_ operations, because device driver writers seldom =

see the big picture. But if you tell a device driver writer that he needs =

to save the state, he'll understand that. He might even understand the =

notion of shutting down the receive side for devices that need it. But if =

you tell a device driver writer that they need to write a "suspend" =

function, that's exactly what he will do.

		Linus
