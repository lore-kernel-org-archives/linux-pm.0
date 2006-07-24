From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC] PowerOP Take 3, sysfs UI core 2/5
Date: Mon, 24 Jul 2006 21:35:45 +0200
Message-ID: <20060724193545.GA2806@elf.ucw.cz>
References: <c55240ed0607201256q2d902a0nd3e9e3fba4ac9dd8@mail.gmail.com>
	<20060724172954.GC1926@elf.ucw.cz>
	<200607241149.01700.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <200607241149.01700.david-b@pacbell.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: David Brownell <david-b@pacbell.net>
Cc: patrick.mochel@intel.com, Matthew Locke <matt@nomadgs.com>, linux-pm@lists.osdl.org, sampsa.fabritius@nokia.com, linux@dominikbrodowski.net
List-Id: linux-pm@vger.kernel.org


> > But better run this by lkml.
> =

> I'd rather see some rough consensus on this list that this is the right w=
ay
> to head, before running things like this by LKML.  =


I meant "they could suggest how to do the sysfs thing, in reasonable
way". Like echo new_config > file is extermely ugly, but perhaps configfs
is suitable?
									Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
