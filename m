From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Thu, 15 Jun 2006 19:36:49 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606151927580.5498@g5.osdl.org>
References: <20060614103404.GC28536@elf.ucw.cz>
	<200606141846.55839.david-b@pacbell.net>
	<20060615084153.GC9423@elf.ucw.cz>
	<200606150957.42449.david-b@pacbell.net>
	<20060615180350.GG23859@elf.ucw.cz>
	<Pine.LNX.4.64.0606151125060.5498@g5.osdl.org>
	<20060615191925.GA1849@elf.ucw.cz>
	<Pine.LNX.4.64.0606151235380.5498@g5.osdl.org>
	<1150421189.7725.81.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1150421189.7725.81.camel@localhost.localdomain>
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



On Fri, 16 Jun 2006, Benjamin Herrenschmidt wrote:
> =

> Well, solving that problem is exactly why we have the PM callbacks in
> bus hierarchy.

No. That's a separate thing. =


We have PM callbacks in the bus hierarchy because we need that just to =

turn them off. You can't turn off the device after you've turned off the =

bus it is attached to.

But that's _totally_ orthogonal to the issue that a complex state save may =

need a totally unrelated device - along dependancies we don't even _know_.

For example, when a device save needs to allocate memory, that in turn can =

end up needing to write to just about _any_ device - and there simply _is_ =

no hierarchy for that. No such hierarchy is even possible, because it's a =

circular problem.

Btw, one final note:

If people who do STD really do want to suspend all devices and then wake =

up devices that lead to the STD device, in the end, I personally simply =

don't care.

I _guarantee_ you that the ordering I've shown is the right one for STR. =

And since STR is the one _I_ care about, I want STR to work right. If =

people want to have a totally screwed-up suspend-to-disk, that's _your_ =

problem, I don't really care. I never have.

But as it is, the _broken_ decisions that the current PM does makes it =

harder to do a proper STR and also debug it while doing it (so that it =

will some day actually work not just on the few machines somebody decides =

are important). I want STR to "work by default", rather than "work by =

accident, sometimes" like it does now.

And in order to do STR sanely, that "save_state()" needs to be separate =

from "suspend()". No ifs, buts, maybe's about it. With a separate =

save_state, I can keep the console open until it's really time to finally =

shut it off, and debug the sequence to the bitter end. And STR doesn't =

have any atomicity issues, since the memory image just doesn't _go_ =

anywhere.

So if this means that STR is just done sanely, and STD is done in the same =

old totally broken manner, I personally do not care one whit. =


			Linus
