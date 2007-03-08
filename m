From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH 0/3] swsusp: Do not use page flags (was:
	Re: Remove page flags for software suspend)
Date: Fri, 9 Mar 2007 00:23:49 +0100
Message-ID: <20070308232349.GD1977@elf.ucw.cz>
References: <Pine.LNX.4.64.0702160212150.21862@schroedinger.engr.sgi.com>
	<200703041450.02178.rjw@sisk.pl>
	<1173315625.3546.32.camel@johannes.berg>
	<200703082305.43513.rjw@sisk.pl> <20070308231512.GB1977@elf.ucw.cz>
	<1173396094.3831.42.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <1173396094.3831.42.camel@johannes.berg>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-mm@kvack.org, Christoph Lameter <clameter@engr.sgi.com>, pm list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> > That's a no-no. ATOMIC alocations can fail, and no, WARN_ON is not
> > enough. It is not a bug, they just fail.
> =

> But like I said in my post, there's no way we can disable suspend to
> disk when they do, right now anyway. Also, this can't be called any
> later than a late initcall or such since it's __init, and thus there
> shouldn't be memory pressure yet that would cause this to fail.
> =

> In any case, I'd be much happier with having a "disable suspend"
> variable so we could print a big warning and set that flag.

Patch would probably be accepted ;-).
								Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
