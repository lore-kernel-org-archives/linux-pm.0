From: Jeremy Maitin-Shepard <jbms@cmu.edu>
Subject: Re: [RFC][PATCH -mm] Freezer: Handle uninterruptible
	tasks
Date: Mon, 09 Jul 2007 00:21:32 -0400
Message-ID: <87odimw6k3.fsf@jbms.ath.cx>
References: <Pine.LNX.4.44L0.0707061039380.3737-100000@iolanthe.rowland.org>
	<200707080108.17371.rjw@sisk.pl> <20070708120933.GA3866@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070708120933.GA3866@ucw.cz> (Pavel Machek's message of "Sun\, 8
	Jul 2007 12\:09\:33 +0000")
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Miklos Szeredi <miklos@szeredi.hu>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

Pavel Machek <pavel@ucw.cz> writes:

[snip]

> I don't know how to do that mechanism... but if we knew where to trap
> filesystem writes, we could simply freeze at that point, and at that
> point only, no?

Any operation at all that has an external effect must not occur after
the snapshot is made; otherwise, there will be random hard-to-find
corruptions and other problems occurring as a result.  Thus, for
example, any writes (either directly or indirectly through e.g. a
filesystem) to non-volatile storage, any network traffic, any
communication with hardware like a printer must be prevented after the
snapshot.  It seems, though, that in general the kernel will have no way
to know which operations are safe, and which are not safe.

(This is why the whole "proper filesystem snapshot support is the
solution" argument is bogus.)

-- 
Jeremy Maitin-Shepard
