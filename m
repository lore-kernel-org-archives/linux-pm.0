From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH -mm 3/5] swsusp: Fix handling of highmem
Date: Wed, 9 Aug 2006 14:07:19 +0200
Message-ID: <200608091407.19845.rjw@sisk.pl>
References: <200608091152.49094.rjw@sisk.pl> <200608091209.03695.rjw@sisk.pl>
	<20060809115145.GT3308@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060809115145.GT3308@elf.ucw.cz>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@suse.cz>
Cc: Linux PM <linux-pm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On Wednesday 09 August 2006 13:51, Pavel Machek wrote:
> > Make swsusp handle highmem pages similarly to the pages of the "normal"
> > memory.
> =

> Is it feasible to create kernel/power/highmem.c?

Not really ...

> >  include/linux/suspend.h |    6 =

> >  kernel/power/power.h    |    2 =

> >  kernel/power/snapshot.c |  822 ++++++++++++++++++++++++++++++++++++---=
---------
> >  kernel/power/swap.c     |    2 =

> >  kernel/power/swsusp.c   |   53 +--
> >  kernel/power/user.c     |    2 =

> >  mm/vmscan.c             |    3 =

> >  7 files changed, 658 insertions(+), 232 deletions(-)
> =

> +400 lines for highmem... I hope highmem dies, dies, dies. Anyway, I'd
> hate to debug this at the same time as the bitmap code. Can we get the
> bitmaps in, wait for a while, and only then change highmem handling?

Sure, why not.  I'll prepare a series without the highmem patch for now.

Rafael
