From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: v2.6.36-rc2-373-g29cfcdd complaints after the 2nd
	suspend2ram
Date: Tue, 31 Aug 2010 22:14:48 +0200
Message-ID: <201008312214.48665.rjw@sisk.pl>
References: <201008300946.38558.toralf.foerster@gmx.de>
	<201008302028.13853.toralf.foerster@gmx.de>
	<4C7CB570.9010607@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4C7CB570.9010607@kernel.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Tejun Heo <tj@kernel.org>
Cc: Toralf =?iso-8859-2?q?F=F6rster?= <toralf.foerster@gmx.de>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Tuesday, August 31, 2010, Tejun Heo wrote:
> On 08/30/2010 08:28 PM, Toralf F=F6rster wrote:
> > =

> > Rafael J. Wysocki wrote at 19:21:54
> >> On Monday, August 30, 2010, Toralf F=F6rster wrote:
> >>> Hell,o
> >>>
> >>> after I made 2 times in a row a
> >>> "$> sync; echo mem > /sys/power/state"
> >>> at my ThinkPad T400 the kernel shows the message shown in the attached
> >>> photo (no syslog message to post, sry) . The .config file is attached
> >>> too.
> >>
> >> This looks like a problem with freezing a workqueue.
> >>
> >> Does the box hang after showing this trace?
> >>
> > =

> > Yes - indeed.
> > =

> =

> Can you please pull from the following branch and see whether the
> problem is resolved?
> =

>   git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git for-linus

Which commit in there is the suspected fix?

Rafael
