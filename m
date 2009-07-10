From: John Dykstra <john.dykstra1@gmail.com>
Subject: Re: 2.6.31-rc2: Reported regressions from 2.6.30
Date: Thu, 09 Jul 2009 20:46:57 -0500
Message-ID: <1247190417.7306.2.camel__5489.05949476666$1247237066$gmane$org@merlyn>
References: <35kKlbXMqWN.A.RXD.D0oUKB@chimera>
	<200907070325.51439.andres@anarazel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200907070325.51439.andres@anarazel.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andres Freund <andres@anarazel.de>
Cc: Adrian Bunk <bunk@kernel.org>, DRI <dri-devel@lists.sourceforge.net>, Linux SCSI List <linux-scsi@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, Linux Wireless List <linux-wireless@vger.kernel.org>, Eric Sesterhenn <eric.sesterhenn@lsexperts.de>, Natalie Protasevich <protasnb@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Kernel Testers List <kernel-testers@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Linux PM List <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 2009-07-07 at 03:25 +0200, Andres Freund wrote:
> There is also http://lkml.org/lkml/2009/6/30/398 : Soft-Lockup/Race
> in 
> networking in 2.6.31-rc1+195 (possibly caused by netem)

There is some similarity between this soft lockup and the one reported
in http://www.spinics.net/lists/netdev/msg100957.html.  In both, the
process is doing both sends and receives on raw sockets.

  --  John
