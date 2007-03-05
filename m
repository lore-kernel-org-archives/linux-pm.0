From: Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.21-rc1: known regressions (part 2)
Date: Mon, 5 Mar 2007 17:41:33 +0100
Message-ID: <20070305164133.GA2441@elte.hu>
References: <20070227103407.GA17819@elte.hu> <20070227105922.GD2250@kernel.dk>
	<20070227111515.GA4271@kernel.dk> <20070301093450.GA8508@elte.hu>
	<20070301104117.GA22788@elte.hu> <20070301145204.GA25304@elte.hu>
	<Pine.LNX.4.64.0703011536450.12485@woody.linux-foundation.org>
	<20070302072100.GB30634@elte.hu> <20070302080441.GA12785@elte.hu>
	<20070305161450.GA4972@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <20070305161450.GA4972@mellanox.co.il>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: Daniel Walker <dwalker@mvista.com>, Michal Piotrowski <michal.k.k.piotrowski@gmail.com>, linux-pm@lists.osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Adrian Bunk <bunk@stusta.de>, Pavel Machek <pavel@ucw.cz>, Jens Axboe <jens.axboe@oracle.com>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, git@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


* Michael S. Tsirkin <mst@mellanox.co.il> wrote:

> > Quoting Ingo Molnar <mingo@elte.hu>:
> >  git-bisect good      0539771d7236b425f285652f6f297cc7939c8f9a
> > =

> >  81450b73dde07f473a4a7208b209b4c8b7251d90 is first bad commit
> =

> I have confirmed these two on my system.

you could probably get quite a bit further in bisecting the other =

breakage, by using the following method:

manully apply the patch below to 81450b73dde and retest. It will most =

likely work. Then FIRST unapply the patch and mark the tree via =

'git-bisect good' and continue the bisection. Then try to apply the =

patch again. If it's already included - ignore the rejected patch. =

Whenever git-bisect offers you a new commit, just try to apply the =

patch. Ok? This way you'll be able to avoid the known ACPI breakage, and =

zoom in on the unknown breakage.

	Ingo

---------------->
commit f3ccb06f3b8e0cf42b579db21f3ca7f17fcc3f38
Author: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
Date:   Tue Feb 13 02:35:50 2007 -0500

    ACPI: Disable wake GPEs only once.
    =

    fixes Suspend/Resume regressions due to recent ACPICA update.
    =

    Signed-off-by: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.c=
om>
    Signed-off-by: Len Brown <len.brown@intel.com>

diff --git a/drivers/acpi/events/evgpe.c b/drivers/acpi/events/evgpe.c
index dfac3ec..635ba44 100644
--- a/drivers/acpi/events/evgpe.c
+++ b/drivers/acpi/events/evgpe.c
@@ -636,17 +636,6 @@ acpi_ev_gpe_dispatch(struct acpi_gpe_event_info *gpe_e=
vent_info, u32 gpe_number)
 		}
 	}
 =

-	if (!acpi_gbl_system_awake_and_running) {
-		/*
-		 * We just woke up because of a wake GPE. Disable any further GPEs
-		 * until we are fully up and running (Only wake GPEs should be enabled
-		 * at this time, but we just brute-force disable them all.)
-		 * 1) We must disable this particular wake GPE so it won't fire again
-		 * 2) We want to disable all wake GPEs, since we are now awake
-		 */
-		(void)acpi_hw_disable_all_gpes();
-	}
-
 	/*
 	 * Dispatch the GPE to either an installed handler, or the control method
 	 * associated with this GPE (_Lxx or _Exx). If a handler exists, we invoke
