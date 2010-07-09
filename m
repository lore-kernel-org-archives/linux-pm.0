From: Sedat Dilek <sedat.dilek@googlemail.com>
Subject: Re: 2.6.35-rc4-git3: Reported regressions from 2.6.34
Date: Fri, 9 Jul 2010 02:16:57 +0200
Message-ID: <AANLkTimmGRikJAWmVeYRkvr9-3AoeO9APN-oDlCJUpvl__27796.5001333088$1278634791$gmane$org@mail.gmail.com>
References: <-IGZ64uxA6G.A.P0H.bLmNMB@chimera>
Reply-To: sedat.dilek@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <-IGZ64uxA6G.A.P0H.bLmNMB@chimera>
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
Cc: DRI <dri-devel@lists.sourceforge.net>, Linux SCSI List <linux-scsi@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, Linux Wireless List <linux-wireless@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Kernel Testers List <kernel-testers@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Linux PM List <linux-pm@lists.linux-foundation.org>, Maciej Rutecki <maciej.rutecki@gmail.com>
List-Id: linux-pm@vger.kernel.org

Hi Rafael,

On Fri, Jul 9, 2010 at 1:33 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
[...]
Bug-Entry       : http://bugzilla.kernel.org/show_bug.cgi?id=16169
Subject         : Complain from preemptive debug
Submitter       : Sedat Dilek <sedat.dilek@googlemail.com>
Date            : 2010-05-31 10:10 (39 days old)
Message-ID      : <AANLkTilTnAAZIizKinYsxFkNTkrmPqk6XJJuUjjhJ7EP@mail.gmail.com>
References      : http://lkml.org/lkml/2010/5/31/77
Handled-By      : Dmitry Monakhov <dmonakhov@openvz.org>
                 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Patch           : http://www.spinics.net/lists/cpufreq/msg01631.html
                 https://patchwork.kernel.org/patch/106555/

This bug is fixed Upstream [1]:

commit 8c215bd3890c347dfb6a2db4779755f8b9c298a9
"sched: Cure nr_iowait_cpu() users"

- Sedat -

[1] http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=8c215bd3890c347dfb6a2db4779755f8b9c298a9
