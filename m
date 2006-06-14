From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Wed, 14 Jun 2006 15:59:00 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606141557100.5498@g5.osdl.org>
References: <Pine.LNX.4.64.0606131418580.5498@g5.osdl.org>
	<Pine.LNX.4.64.0606131435400.5498@g5.osdl.org>
	<20060614103404.GC28536@elf.ucw.cz>
	<Pine.LNX.4.64.0606140820420.5498@g5.osdl.org>
	<Pine.LNX.4.64.0606141042260.5498@g5.osdl.org>
	<20060614214048.GG4950@ucw.cz>
	<Pine.LNX.4.64.0606141501070.5498@g5.osdl.org>
	<20060614221235.GA7751@elf.ucw.cz>
	<1150324014.21941.23.camel@localhost.localdomain>
	<Pine.LNX.4.64.0606141537570.5498@g5.osdl.org>
	<20060614224436.GF7751@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060614224436.GF7751@elf.ucw.cz>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@suse.cz>
Cc: Power management list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org



On Thu, 15 Jun 2006, Pavel Machek wrote:
>
> Console subsystem should be stopped when console device is stopped,
> and restarted when console device is restarted.

There is no "console device".

There are potentially _many_ console devices.

And you don't even know which ones they are.

The old setup is BROKEN. The new setup is less so. It really is that =

simple.

That's not to say that the new setup cannot be improved upon, though. I'm =

just telling you that the old one was not fixable, not the way it thought =

it could do things.

		Linus
