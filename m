From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: suspend/resume problems w/ kernel 3.0 and a *docked*
	ThinkPad T400
Date: Sun, 24 Jul 2011 23:23:54 +0200
Message-ID: <201107242323.54819.rjw__7032.5477085591$1311542644$gmane$org@sisk.pl>
References: <201107232127.34255.toralf.foerster@gmx.de>
	<201107232335.35204.rjw@sisk.pl>
	<201107241036.20538.toralf.foerster@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201107241036.20538.toralf.foerster@gmx.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Toralf =?iso-8859-2?q?F=F6rster?= <toralf.foerster@gmx.de>
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Sunday, July 24, 2011, Toralf F=F6rster wrote:
> =

> Rafael J. Wysocki wrote at 23:35:35
> > On Saturday, July 23, 2011, Toralf F=F6rster wrote:
> > > Rafael J. Wysocki wrote at 21:48:44
> > > =

> > > > I wonder what happens if the machine is undocked?
> > > =

> > > No.
> > > BTW with "no_console_suspend" I got the attached kernel crash.
> > =

> > What happens if the iwlagn driver is unloaded before suspend?
> Yep - then it works fine.

Hmm.

So the failure happens only if the machine is in the dock?

Rafael
