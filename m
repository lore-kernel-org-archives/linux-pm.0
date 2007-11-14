From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] Hibernation: Fix lockdep report (v2)
Date: Wed, 14 Nov 2007 22:42:00 +0000
Message-ID: <20071114224200.GB7367__13961.117869667$1195076850$gmane$org@ucw.cz>
References: <200711142225.58033.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200711142225.58033.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>, Johannes Berg <johannes@sipsolutions.net>, Peter Zijlstra <a.p.zijlstra@chello.nl>
List-Id: linux-pm@vger.kernel.org

On Wed 2007-11-14 22:25:57, Rafael J. Wysocki wrote:
> [Andrew, please consider this as 2.6.24 material, thanks.]
> ---
> From: Johannes Berg <johannes@sipsolutions.net>
>=20
> Lockdep reports a circular locking dependency in the hibernate code
> because
> =A0- during system boot hibernate code (from an initcall) locks pm_mute=
x
> =A0 =A0and then a sysfs buffer mutex via name_to_dev_t
> =A0- during regular operation hibernate code locks pm_mutex under a
> =A0 =A0sysfs buffer mutex because it's called from sysfs methods.
>=20
> The deadlock can never happen because during initcall invocation nothin=
g
> can write to sysfs yet. This removes the lockdep report by marking the
> initcall locking as being in a different class.
>=20
> Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
> Cc: Pavel Machek <pavel@ucw.cz>

ACK...

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/b=
log.html
