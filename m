From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] introduce /sys/power/disk_powerdown_mode
Date: Wed, 21 Mar 2007 14:17:09 +0100
Message-ID: <20070321131709.GA5788@elf.ucw.cz>
References: <1174468981.3769.8.camel@johannes.berg>
	<20070321122954.GO4520@elf.ucw.cz>
	<1174480375.4230.12.camel@johannes.berg>
	<20070321131128.GB4523@elf.ucw.cz>
	<1174482773.4230.19.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1174482773.4230.19.camel@johannes.berg>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-pm <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> > > > Does it really need to be this complex? Maybe we can disply change
> > > > /sys/power/disk format? Is the change required at all?
> > > =

> > > Dunno. Does anything ever read it? Maybe the whole change isn't
> > > necessary since this thing exists only as a hack for ACPI anyway, but=
 if
> > > anybody starts using it with an actual choice being able to see the
> > > choices would imho be useful.
> > =

> > I believe we can just show the list of choices, without changing the
> > name.
> =

> Ok, I can simplify the patch down to that, the only thing about that is
> that it breaks userspace ABI. Dunno how people react to that with
> suspend though :)

I do not know... maybe you can just ask akpm first. I believe we can
do that.
									Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
