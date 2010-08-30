From: Toralf =?iso-8859-2?q?F=F6rster?= <toralf.foerster@gmx.de>
Subject: Re: v2.6.36-rc2-373-g29cfcdd complaints after the 2nd
	suspend2ram
Date: Mon, 30 Aug 2010 20:28:13 +0200
Message-ID: <201008302028.13853.toralf.foerster@gmx.de>
References: <201008300946.38558.toralf.foerster@gmx.de>
	<201008301921.54312.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201008301921.54312.rjw@sisk.pl>
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
Cc: tj@kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org


Rafael J. Wysocki wrote at 19:21:54
> On Monday, August 30, 2010, Toralf F=F6rster wrote:
> > Hell,o
> > =

> > after I made 2 times in a row a
> > "$> sync; echo mem > /sys/power/state"
> > at my ThinkPad T400 the kernel shows the message shown in the attached
> > photo (no syslog message to post, sry) . The .config file is attached
> > too.
> =

> This looks like a problem with freezing a workqueue.
> =

> Does the box hang after showing this trace?
> =


Yes - indeed.

-- =

MfG/Kind regards
Toralf F=F6rster

pgp finger print: 7B1A 07F4 EC82 0F90 D4C2 8936 872A E508 7DB6 9DA3
