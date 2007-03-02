From: Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.21-rc1: known regressions (part 2)
Date: Fri, 2 Mar 2007 08:14:23 +0100
Message-ID: <20070302071423.GA30634@elte.hu>
References: <20070227100202.GV3822@kernel.dk>
	<20070227102109.GG6745@elf.ucw.cz>
	<20070227103021.GA2250@kernel.dk> <20070227103407.GA17819@elte.hu>
	<20070227105922.GD2250@kernel.dk> <20070227111515.GA4271@kernel.dk>
	<20070301093450.GA8508@elte.hu> <20070301104117.GA22788@elte.hu>
	<20070301145204.GA25304@elte.hu>
	<Pine.LNX.4.64.0703011536450.12485@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0703011536450.12485@woody.linux-foundation.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Daniel Walker <dwalker@mvista.com>, Thomas Gleixner <tglx@linutronix.de>, Michal Piotrowski <michal.k.k.piotrowski@gmail.com>, Pavel Machek <pavel@ucw.cz>, Jens Axboe <jens.axboe@oracle.com>, "Michael S. Tsirkin" <mst@mellanox.co.il>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Adrian Bunk <bunk@stusta.de>
List-Id: linux-pm@vger.kernel.org


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> Btw, you seem to have re-ordered the commits - the above is not the =

> order you did the bisection in. The known-good commit (f3ccb06..) is =

> in the middle. [...]

no - i simply picked them by hand, based on looking at gittk output, =

because bisection did not appear to find anything useful:

  9f4bd5dde81b5cb94e4f52f2f05825aa0422f1ff is first bad commit

And via that method i found a couple of more 'good' points - which =

git-bisect never picked up by itself. (and i did 3-4 separate git-bisect =

sessions, one of them was a "git-bisect start drivers/acpi/" - which is =

the main area of suspicion). I looked at git-bisect visualize more than =

once, and i've attached one of the bisection logs below.

i also think i know what happens. Firstly, my testing is reliable, as i =

mentioned it in the other mail i frequently re-visited commits to make =

sure that none of my bad/good decisions is spurios - but no, the test =

results are extremely reproducable: either the laptop resumes properly =

after flashing its disk light or it does not.

the problem i think is that i simply took git-bisect's behavior for =

granted (i used it many times already) but forgot about a very basic =

precondition: git-bisect will find only a /single/ good->bad transition.

If there is a bad->good transition combined with a good->bad transition =

then git-bisect will think it's the same 'badness', while it's a =

/former/ badness that it is honing in on - totally sending the bisection =

off into la-la-land.

so as i mentioned it in the first mail: i /know/ that this commit is a =

bad->good transition point:

  f3ccb06f3b8e0cf42b579db21f3ca7f17fcc3f38

/and i only want to test commits that include this commit/ - because i =

know that without this commit git-bisect confuses the /other/ breakage =

with the new breakage. In the bisection log below, this choice of =

git-bisect:

  ee404566f97f9254433399fbbcfa05390c7c55f7

is 'bad' according to testing, but that's 'another' badness - and i =

missed it.

Now, having slept on it, the solution is very simple: whenever =

git-bisect picks a commit for which the following command comes up =

empty:
 =

  git-log | grep f3ccb06f3b8e0cf42b579db21f3ca7f17fcc3f38

then i'll mark it "git-bisect good" - artificially marking the older =

badness as a 'good' area. That way git-bisect will find the right =

good->bad transition point.

btw., that's why i tried to pick up commits by hand, making sure that =

commit f3ccb06f3b8e0cf42b579db21f3ca7f17fcc3f38 is always included - but =

got lost in the maze of the commit graph, and didnt realize that there =

is a simple solution. Nevertheless i wanted to dump the information i =

already gathered. Those commits were totally out of order, etc. - they =

were picked by a poor human who is much worse at walking graphs than =

git-bisect ;-)

	Ingo

git-bisect start
# bad: [01363220f5d23ef68276db8974e46a502e43d01d] [PARISC] clocksource: Mov=
e update_cr16_clocksource later in boot
git-bisect bad 01363220f5d23ef68276db8974e46a502e43d01d
# good: [f3ccb06f3b8e0cf42b579db21f3ca7f17fcc3f38] ACPI: Disable wake GPEs =
only once.
git-bisect good f3ccb06f3b8e0cf42b579db21f3ca7f17fcc3f38
# bad: [ee404566f97f9254433399fbbcfa05390c7c55f7] sysctl: mips/au1000: remo=
ve sys_sysctl support
git-bisect bad ee404566f97f9254433399fbbcfa05390c7c55f7
# bad: [c827ba4cb49a30ce581201fd0ba2be77cde412c7] Merge master.kernel.org:/=
pub/scm/linux/kernel/git/davem/sparc-2.6
git-bisect bad c827ba4cb49a30ce581201fd0ba2be77cde412c7
# bad: [68a696a01f482859a9fe937249e8b3d44252b610] Merge branch 'upstream' o=
f git://ftp.linux-mips.org/pub/scm/upstream-tc
git-bisect bad 68a696a01f482859a9fe937249e8b3d44252b610
# bad: [1c433fbda4896a6455d97b66a4f2646cbdd52a8c] [ALSA] soc - 0.13 ASoC he=
aders
git-bisect bad 1c433fbda4896a6455d97b66a4f2646cbdd52a8c
# bad: [048b945077bdc7e8dff5d5810ff2a0ced3590ca9] [ALSA] echoaudio, add TLV=
 support
git-bisect bad 048b945077bdc7e8dff5d5810ff2a0ced3590ca9
# bad: [c07584c83287ae5a13cc836f69a1d824ad068c66] [ALSA] hda-codec - Add su=
pport for Medion laptops
git-bisect bad c07584c83287ae5a13cc836f69a1d824ad068c66
# bad: [dbc6b6ad767c86907db373e85139b0e975ba7599] [ALSA] ASoC codecs: gener=
ic AC97 support
git-bisect bad dbc6b6ad767c86907db373e85139b0e975ba7599
# bad: [b66b3cfe6c2f6560f351278883a325b6ebc478f5] [ALSA] hda_intel: increas=
e maximum DMA buffer size to 1024MB
git-bisect bad b66b3cfe6c2f6560f351278883a325b6ebc478f5
# bad: [12b131c4cf3eb1dc8a60082a434b7b100774c2e7] [ALSA] allow registering =
an alsa device with struct device pointer
git-bisect bad 12b131c4cf3eb1dc8a60082a434b7b100774c2e7
# bad: [e4f8e656d8c152c08cd44d0e3c21f009fab09952] [ALSA] usb-audio: allow p=
ausing
git-bisect bad e4f8e656d8c152c08cd44d0e3c21f009fab09952
# bad: [1700f3080d98323e91864d67cb9f6d46f818ccf0] [ALSA] usb-audio: merge p=
layback/capture hardware information structs
git-bisect bad 1700f3080d98323e91864d67cb9f6d46f818ccf0
# bad: [9f4bd5dde81b5cb94e4f52f2f05825aa0422f1ff] [ALSA] snd-emu10k1: Added=
 support for emu1010, including E-Mu 1212m and E-Mu 1820m
git-bisect bad 9f4bd5dde81b5cb94e4f52f2f05825aa0422f1ff
