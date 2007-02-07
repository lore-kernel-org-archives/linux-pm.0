From: Andreas Schwab <schwab@suse.de>
Subject: Re: [PATCH 11/12] powermac: disallow pmu sleep notifiers
	from aborting sleep
Date: Wed, 07 Feb 2007 23:52:50 +0100
Message-ID: <jetzxxk2bh.fsf@sykes.suse.de>
References: <20070207124536.963531000@sipsolutions.net>
	<20070207124615.015873000@sipsolutions.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20070207124615.015873000@sipsolutions.net> (Johannes Berg's
	message of "Wed, 07 Feb 2007 13:45:47 +0100")
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
Cc: linuxppc-dev@ozlabs.org, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

Johannes Berg <johannes@sipsolutions.net> writes:

> Tracing through the code, no current PMU sleep notifier can abort sleep.
> Since no new PMU sleep notifiers should be added, this patch simplifies t=
he
> code and removes the ability to abort sleep.

There is a use of PBOOK_SLEEP_OK left in
arch/powerpc/platforms/powermac/time.c.

Andreas.

-- =

Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstra=DFe 5, 90409 N=FCrnberg, Germany
PGP key fingerprint =3D 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
