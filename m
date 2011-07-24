From: Toralf =?iso-8859-2?q?F=F6rster?= <toralf.foerster@gmx.de>
Subject: Re: suspend/resume problems w/ kernel 3.0 and a *docked*
	ThinkPad T400
Date: Sun, 24 Jul 2011 10:36:20 +0200
Message-ID: <201107241036.20538.toralf.foerster__21718.4392073706$1311496661$gmane$org@gmx.de>
References: <201107232127.34255.toralf.foerster@gmx.de>
	<201107232227.37429.toralf.foerster@gmx.de>
	<201107232335.35204.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201107232335.35204.rjw@sisk.pl>
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
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


Rafael J. Wysocki wrote at 23:35:35
> On Saturday, July 23, 2011, Toralf F=F6rster wrote:
> > Rafael J. Wysocki wrote at 21:48:44
> > =

> > > I wonder what happens if the machine is undocked?
> > =

> > No.
> > BTW with "no_console_suspend" I got the attached kernel crash.
> =

> What happens if the iwlagn driver is unloaded before suspend?
Yep - then it works fine.

-- =

MfG/Sincerely
Toralf F=F6rster
pgp finger print: 7B1A 07F4 EC82 0F90 D4C2 8936 872A E508 7DB6 9DA3
