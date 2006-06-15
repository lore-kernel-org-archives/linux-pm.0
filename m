From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Thu, 15 Jun 2006 12:40:39 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606151235380.5498@g5.osdl.org>
References: <20060614103404.GC28536@elf.ucw.cz>
	<200606141846.55839.david-b@pacbell.net>
	<20060615084153.GC9423@elf.ucw.cz>
	<200606150957.42449.david-b@pacbell.net>
	<20060615180350.GG23859@elf.ucw.cz>
	<Pine.LNX.4.64.0606151125060.5498@g5.osdl.org>
	<20060615191925.GA1849@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060615191925.GA1849@elf.ucw.cz>
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

> Well, it is right that separation as you suggest is possible... but it
> is quite different from current system. And if someone does suspend
> (instead of freeze) -- no harm is done -- it just takes
> longer.

Sure, harm IS done.

Suspending a device before everybody else has saved their state is =

fundamentally and deeply wrong. You do not know whether other devices =

might need that device for their state save. =


You may, for example, have devices that literally have so much state that =

they need user help to save it - which in turn means that they must be =

saved before you have suspended other and UNRELATED devices. X itself is =

actually an example of this, but so might be anything with firmware, for =

example).

(Right now, we actually end up saving firmware in kernel memory or do =

things like that, so that we can resume it. That's really a hack for the =

bigger problem of not having multiple stages of save/restore.)

It's not just firmware. It could be things like devices that literally =

have user processes handling connection setup etc for them.

So the whole notion of mixing "save state" and "suspend" is fundamentally =

wrong. It has _always_ been wrong. And it's very fundamentally wrong in a =

way that makes me say that unless you can separate the two (not just in =

a technical sense, but in the sense of how people literally _think_ about =

the suspend problem), we can probably _never_ fix the deeper issues.

			Linus
