From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Wed, 14 Jun 2006 10:52:52 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606141042260.5498@g5.osdl.org>
References: <Pine.LNX.4.64.0606131418580.5498@g5.osdl.org>
	<Pine.LNX.4.64.0606131435400.5498@g5.osdl.org>
	<20060614103404.GC28536@elf.ucw.cz>
	<Pine.LNX.4.64.0606140820420.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606140820420.5498@g5.osdl.org>
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
Cc: Power management list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org



On Wed, 14 Jun 2006, Linus Torvalds wrote:
> > =

> > And we definitely want to go back to SYSTEM_RUNNING or how is it
> > called here.
> =

> Right. A bit too much cut-and-paste ;)

Btw, maybe I didn't quite make this clear enough, but the two patches =

actually make a huge difference for me.

My Mac Mini (Intel dual-core CPU) now resumes and suspends in SMP mode =

too, which was not true just a couple of days ago. It even seems to do it =

fairly reliable.

The debugging patch helped me figure out a number of the problems (and =

even more problems that then didn't actually make any difference once I =

started getting things working ;)

And the console fixes is apparently what got things working in SMP mode. =


Admittedly I'm not even quite sure _why_, but the reason I did them was =

that I saw too many problems with hangs etc that seemed to be due to the =

printk's and other debugging crud, and trying to debug with netconsole in =

particular.

As a result I will actually apply the console fixes patch (the fixed one, =

with SYSTEM_RUNNING ;) immediately after the 2.6.17 release, so if people =

have problems with it or suggesting for a way to disable the console =

shutoff, please speak up. It's too late to do it for 2.6.17, or I would =

have already applied it rather than post it to linux-pm..

I don't particularly like shutting the console up early (and enabling it =

again late), but quite frankly, the alternatives seemed much much worse in =

practice, and this was really the RightThing(tm), apart from it probably =

needing some debug flag to disable the disable.

		Linus
