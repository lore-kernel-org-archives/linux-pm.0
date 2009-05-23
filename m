From: Oliver Neukum <oliver@neukum.org>
Subject: Re:
 =?iso-8859-1?q?=5BRFC=5D_why_do_we_need_run_disk_sync_?=
 =?iso-8859-1?q?before_entering=09S3?=
Date: Sat, 23 May 2009 09:59:22 +0200
Message-ID: <200905230959.23018.oliver__21305.7547146038$1243066551$gmane$org@neukum.org>
References: <Pine.LNX.4.44L0.0905131000360.3004-100000@iolanthe.rowland.org>
	<1242631507.16529.107.camel@rzhang-dt>
	<20090522153356.GB27655@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090522153356.GB27655@elf.ucw.cz>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
Cc: linux-acpi <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Am Freitag, 22. Mai 2009 17:33:57 schrieb Pavel Machek:
> > Take ACPI for example, ACPI defines two ACPI battery states, one is
> > "low" and another is "critical".
> > OS enters S3/S4 when battery is low, while it performs an emergency
> > shutdown when battery is in critical state. (ACPI spec 3.0b 3.9.4)
> > So I'm wondering if it's right to enter S3 when we know that the system
> > may lost power at anytime.
>
> Well, battery only lasts like 30 hours in S3. So if you leave your
> notebook unattended for 30 hours, you'll loose recent changes.

Even if the battery is very low you get 30 hours?

	Regards
		Oliver
