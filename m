From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Thu, 15 Jun 2006 12:35:05 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606151219540.5498@g5.osdl.org>
References: <20060615083921.GB9423@elf.ucw.cz>
	<Pine.LNX.4.44L0.0606151047410.6879-100000@iolanthe.rowland.org>
	<20060615161446.GA23859@elf.ucw.cz>
	<Pine.LNX.4.64.0606150922200.5498@g5.osdl.org>
	<20060615182419.GA1711@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060615182419.GA1711@elf.ucw.cz>
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
Cc: David Brownell <david-b@pacbell.net>, linux-pm@lists.osdl.org, Nigel Cunningham <ncunningham@linuxmail.org>
List-Id: linux-pm@vger.kernel.org



On Thu, 15 Jun 2006, Pavel Machek wrote:
> =

> Okay, console switches are really needed -- so that X gets it chance
> to save graphics state. Try your version from accelerated X -- it
> would break AFAICS.
> =

> So we basically need the old code -- to switch consoles -- and then
> your new code -- to prevent writing to console that is suspended.

No.

You're DOING THE SAME MISTAKE AGAIN!

You're confusing "shutdown" with "save state". The two are totally =

separate, and they MUST be separate. Trying to combine the two is wrong, =

wrong, wrong.

Repeat after me: we must save the state of a device before we shut _any_ =

device down. =


That is as true for X and the console as it is for _any_ other device.

So it's a slight improvement (because now the functions are at least =

separate), but by putting the console state saving in the path that does =

the suspend, you're again mixing up the issue of suspending the devices, =

and actually saving their state.

The console switch itself is actually wrong, but at least it works (we =

should just initiate the "give me back the console" part, not the actual =

_switching_, but that would require some cleanup in vt_ioctl.c), but the =

_position_ is wrong.

The state save should be done early (probably where we currently do =

"prepare_console()" - I did the "shut it up" there too, not because I =

wanted to, but because we don't have the "save_state()" phase). And the =

_suspend_ should be done late.

So I think that whole VT switch (or properly waiting for the release even =

on the same VT) should happen before the save-state in my earlier diagram =

of the different stages. It is, in fact, part of the "prepare user space =

for shutdown" stage. It has nothing to do with the "suspend" stage.

			Linus
