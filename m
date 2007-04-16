From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v4] pm_ops: add system quiesce/activate hooks
Date: Mon, 16 Apr 2007 14:47:33 +0200
Message-ID: <20070416124733.GB3371@elf.ucw.cz>
References: <1175810054.3489.34.camel@johannes.berg>
	<1176499086.7052.124.camel@johannes.berg>
	<20070413213349.GL28264@elf.ucw.cz>
	<200704140009.33298.rjw@sisk.pl>
	<1176503122.5764.109.camel@localhost.localdomain>
	<20070413223922.GS28264@elf.ucw.cz>
	<1176506383.5764.129.camel@localhost.localdomain>
	<20070416073249.GA2057@elf.ucw.cz>
	<1176712634.7052.175.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1176712634.7052.175.camel@johannes.berg>
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
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi!

> > As decrementer is special for s2ram, we can add the hook. (It is
> > single hook).
> =

> No, it's two, for enabling as well.

Two is ok, six would not be.
									Pavel

-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
