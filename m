From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 1/2] Add some basic resume trace facilities
Date: Tue, 13 Jun 2006 15:59:57 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606131551210.5498@g5.osdl.org>
References: <5389061B65D50446B1783B97DFDB392D01623F6F@orsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <5389061B65D50446B1783B97DFDB392D01623F6F@orsmsx411.amr.corp.intel.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Gross, Mark" <mark.gross@intel.com>
Cc: linux-pm@lists.osdl.org, Nigel Cunningham <ncunningham@linuxmail.org>
List-Id: linux-pm@vger.kernel.org



On Tue, 13 Jun 2006, Gross, Mark wrote:
> =

> If you can spare a few blocks it's not too hard to write a low level
> synchronous flash write code that works at panic time.  I did this to a
> 2.4.10 kernel a while back, and it was *very* useful for debugging
> problems.

Absolutely.

The problem is, there's no safe and documented hardware to do that in =

general.

On a standard PC, you have the RTC, and that's it ;(

It used to be that you could toggle serial lines by hand, but that's not =

the case any more these days (they're not at a fixed address any more and =

generally needs tons of very chip-specific setup to even be visible to the =

CPU, but more importantly, most modern hardware doesn't even have the =

_connector_ any more).

The Apple Mac Mini I can't even get to _beep_, which is really annoying. =

It's a wonderful debug sequence ("oh, I head 15 beeps, it got to point =

X"). Or rather, it's "wonderful" compared to something that gives you just =

one single piece of data after the reboot ;)

Now, the LPC obviously does have the BIOS flash chip connected to it, but =

I suspect very few people would be happy with code that overwrites even =

just parts of that. I also suspect it varies a lot from machine to =

machine. I wasn't going to even try.

The RTC chip actually has enough memory in it that I could have saved a =

lot more information, but the firmware (at least on the Mac Mini) will =

clear it on a full-post boot (and the whole point of this is that we =

_will_ do a full POST when the resume fails, of course).

It even clears the second 128-byte RTC memory bank, from my testing ;(

The real-time clock was literally the only thing I could find that didn't =

get cleared, and that obviously has some serious limitations size-wise.

			Linus
