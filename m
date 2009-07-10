From: Andres Freund <andres@anarazel.de>
Subject: Re: 2.6.31-rc2: Reported regressions from 2.6.30
Date: Fri, 10 Jul 2009 04:10:37 +0200
Message-ID: <200907100410.37506.andres__29828.0738447376$1247191996$gmane$org@anarazel.de>
References: <35kKlbXMqWN.A.RXD.D0oUKB@chimera>
	<200907070325.51439.andres@anarazel.de>
	<1247190417.7306.2.camel@merlyn>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1247190417.7306.2.camel@merlyn>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: John Dykstra <john.dykstra1@gmail.com>, "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Adrian Bunk <bunk@kernel.org>, DRI <dri-devel@lists.sourceforge.net>, Linux SCSI List <linux-scsi@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, Linux Wireless List <linux-wireless@vger.kernel.org>, Eric Sesterhenn <eric.sesterhenn@lsexperts.de>, Natalie Protasevich <protasnb@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Kernel Testers List <kernel-testers@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Linux PM List <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi John, Hi Rafael,

On Friday 10 July 2009 03:46:57 John Dykstra wrote:
> On Tue, 2009-07-07 at 03:25 +0200, Andres Freund wrote:
> > There is also http://lkml.org/lkml/2009/6/30/398 : Soft-Lockup/Race
> > in
> > networking in 2.6.31-rc1+195 (possibly caused by netem)
>
> There is some similarity between this soft lockup and the one reported
> in http://www.spinics.net/lists/netdev/msg100957.html.  In both, the
> process is doing both sends and receives on raw sockets.
The issue turned out to be a hrtimer bug - i dont see anything like it in your 
trace. If you still want to test the fix, its 
de907e8432b08f2d5966c36e0747e97c0e596810 in -tip (or 
http://lkml.org/lkml/2009/7/9/150)

Rafael: In case youre reading this, I guess you can mark that bug as resolved.

Andres
