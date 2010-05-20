From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Thu, 20 May 2010 16:08:49 -0700 (PDT)
Message-ID: <758575.48890.qm__3887.93346141956$1274396995$gmane$org@web180307.mail.gq1.yahoo.com>
References: <20100520185057.GA25089@gandalf>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100520185057.GA25089@gandalf>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
Cc: "me@felipebalbi.com" <me@felipebalbi.com>, Theodore Ts'o <tytso@mit.edu>, Andrew Morton <akpm@linux-foundation.org>, Brian Swetland <swetland@google.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Geoff Smith <geoffx.smith@intel.com>, Kernel development list <linux-kernel@vger.kernel.org>, Liam Girdwood <lrg@slimlogic.co.uk>, Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>, Vladimir Pantelic <pan@nt.tu-darmstadt.de>, felipe.balbi@nokia.com, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>, Matthew Garrett <mjg@redhat.com>
List-Id: linux-pm@vger.kernel.org


> -0700, David Brownell wrote:
> > Some apps do abuse kernel mechanisms, and whether the
> bug is in the
> > app or that kernel mechanism can be a judgement
> call.=A0 I'd expect to
> =

> hey come on, there's no judgement call for an app polling
> every second
> to check battery status or some other status that doesn't
> change that frequently.

Or something as broken as a non-terminating CPU loop ...


Of course not.  But if there's a kernel mechanism exposed to
userspace which really sucks down power ... either it's done
correctly and the problem is userspace abusing it, or it's done
wrong so that it's not possible to be used correctly.  There are
some things that just cost power, and that cost can't be escaped.
