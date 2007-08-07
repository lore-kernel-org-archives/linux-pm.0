From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] PM: Fix dependencies of CONFIG_SUSPEND and
	CONFIG_HIBERNATION (updated 2x)
Date: Tue, 7 Aug 2007 09:13:12 +0200
Message-ID: <20070807071312.GA9112@elf.ucw.cz>
References: <200708070023.27404.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200708070023.27404.rjw@sisk.pl>
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
Cc: LKML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>, Andrew Morton <akpm@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>, Russell King <rmk@arm.linux.org.uk>
List-Id: linux-pm@vger.kernel.org


> [The update is necessary because of the too restrictive conditions for =
suspend
> on powerpc.]
> ---
> From: Rafael J. Wysocki <rjw@sisk.pl>
>=20
> Dependencies of CONFIG_SUSPEND and CONFIG_HIBERNATION introduced by com=
mit
> 296699de6bdc717189a331ab6bbe90e05c94db06 "Introduce CONFIG_SUSPEND for
> suspend-to-Ram and standby" are incorrect, as they don't cover the fact=
s that
> (1) not all architectures support suspend and (2) SMP hibernation is on=
ly
> possible on X86 and PPC64 (if CONFIG_PPC64_SWSUSP is set).
>=20
> Moreover, SMP suspend and hibernation are only possible if CONFIG_HOTPL=
UG is
> set, because they select HOTPLUG_CPU that depends on it. =A0Also, since=
 suspend
> and hibernation don't depend on EXPERIMENTAL, arrange things so that CP=
U
> hotplug can be selected if it is not set.
>=20
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

ACK.
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/b=
log.html
