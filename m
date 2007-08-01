From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH -mm 1/3] Freezer: Use wait queue instead
	of busy looping
Date: Wed, 1 Aug 2007 09:59:40 +0200
Message-ID: <20070801075940.GS2087@elf.ucw.cz>
References: <200707251401.48340.rjw@sisk.pl> <20070731100254.GC3462@elf.ucw.cz>
	<200708010025.27018.rjw@sisk.pl> <200708010026.56427.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200708010026.56427.rjw@sisk.pl>
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
Cc: Nigel Cunningham <nigel@nigel.suspend2.net>, Andres Salomon <dilinger@debian.org>, linux-pm@lists.linux-foundation.org, Chris Ball <cjb@laptop.org>, David Woodhouse <dwmw2@infradead.org>, Oleg Nesterov <oleg@tv-sign.ru>
List-Id: linux-pm@vger.kernel.org

Hi!

> Use the observation that try_to_freeze_tasks() need not loop while wait=
ing for
> the freezing tasks to enter the refrigerator and make it use a wait que=
ue.
>=20
> The idea is that after sending freeze requests to the tasks regarded as
> freezable try_to_freeze_tasks() can go to sleep and wait until at least=
 one task
> enters the refrigerator. =A0The first task that does it wakes up
> try_to_freeze_tasks() and the procedure is repeated. =A0If the refriger=
ator is not
> entered by any tasks before TIMEOUT expires, the freezing of tasks fail=
s.
>=20
> This way, try_to_freeze_tasks() doesn't occupy the CPU unnecessarily wh=
en some
> freezing tasks are waiting for I/O to complete.

Ok, I guess this is as simple as it gets. ACK.
								Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/b=
log.html
