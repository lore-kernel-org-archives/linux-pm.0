From: Toralf =?iso-8859-2?q?F=F6rster?= <toralf.foerster@gmx.de>
Subject: Re: v2.6.36-rc2-373-g29cfcdd complaints after the 2nd
	suspend2ram
Date: Wed, 1 Sep 2010 20:03:12 +0200
Message-ID: <201009012003.13481.toralf.foerster@gmx.de>
References: <201008300946.38558.toralf.foerster@gmx.de>
	<201008312214.48665.rjw@sisk.pl> <4C7E161C.6000407@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4C7E161C.6000407@kernel.org>
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
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org


Tejun Heo wrote at 11:00:12
> Hello, Rafael.
> =

> On 08/31/2010 10:14 PM, Rafael J. Wysocki wrote:
> >> Can you please pull from the following branch and see whether the
> >> problem is resolved?
> >> =

> >>   git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git for-linus
> > =

> > Which commit in there is the suspected fix?
> =

> Commit 8a2e8e5dec7e29c56a46ba176c664ab6a3d04118 (workqueue: fix
> cwq->nr_active underflow).  The symptom described in the patch
> description is different but nr_active is used for workqueue freezing
> and can definitely lead to malfunction during freeze.  I've sent pull
> request to Linus yesterday.
> =

> Thanks.
confirmed, that commit solved it.

-- =

MfG/Kind regards
Toralf F=F6rster

pgp finger print: 7B1A 07F4 EC82 0F90 D4C2 8936 872A E508 7DB6 9DA3
