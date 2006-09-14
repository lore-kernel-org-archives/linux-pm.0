From: Pavel Machek <pavel@ucw.cz>
Subject: Re: community PM requirements/issues and PowerOP [Was:
	Re: So, what's the status on the recent patches here?]
Date: Thu, 14 Sep 2006 12:17:04 +0200
Message-ID: <20060914101704.GA17820@elf.ucw.cz>
References: <20060913045405.BA7DD1A0084@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
	<ADE4D9DBCFC3A345AAA95C195F62B6DD01B6A3D9@de01exm64.ds.mot.com>
	<20060914091211.GA14874@elf.ucw.cz>
	<a1a8b0b5c71a78fafd450c10ec52a60d@comcast.net>
	<45092968.7070508@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <45092968.7070508@gmail.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Eugeny S. Mints" <eugeny.mints@gmail.com>
Cc: Preece Scott-PREECE <scott.preece@motorola.com>, Matthew Locke <matthew.a.locke@comcast.net>, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

Hi!

> operating points it is possible to implement the "cpufreq frequency =

> selection logic" in user space and having such functionality in the kerne=
l =

> just violates the main rule of having everything possible outside of the =

> kernel.

You got the rules wrong. "Keep the code out of kernel" is important
rule, but probably not the main one.

> Paval, plz NOTE, that  you don't have lkml in CC on this thread and I =

> personally feel that you've brought a really terrible confusion to everyo=
ne =

> with your lkml step. I'm wondering whether you are braking "no cross =

> postings" rule as well.....

Cc-ing lkml is considered okay.

Anyway, please do _proper_ submission, cc-ing lkml, explaining why it
is needed so that me and lkml actually know what is going on. Include
those "elevator pitches".
									Pavel

-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
