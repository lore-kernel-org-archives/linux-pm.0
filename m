From: Tejun Heo <htejun@gmail.com>
Subject: Re: [Probably regression] Possible circular locking
 dependency from ATA in current mainline
Date: Mon, 27 Dec 2010 13:03:58 +0100
Message-ID: <20101227120358.GA488__16702.8328789913$1293451549$gmane$org@htj.dyndns.org>
References: <201012262316.26638.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201012262316.26638.rjw@sisk.pl>
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
Cc: linux-ide@vger.kernel.org, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-scsi <linux-scsi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hello, Rafael.

On Sun, Dec 26, 2010 at 11:16:26PM +0100, Rafael J. Wysocki wrote:
> [  319.281892] =======================================================
> [  319.281893] [ INFO: possible circular locking dependency detected ]
> [  319.281894] 2.6.37-rc7+ #16
> [  319.281895] -------------------------------------------------------
> [  319.281896] kworker/1:0/13333 is trying to acquire lock:
> [  319.281897]  (&bdev->bd_mutex){+.+.+.}, at: [<ffffffff811271a6>] revalidate_disk+0x56/0x90
> [  319.281902] 
> [  319.281903] but task is already holding lock:
> [  319.281903]  (&ap->scsi_scan_mutex){+.+...}, at: [<ffffffff81360420>] ata_scsi_dev_rescan+0x30/0x120

This dependency is true.

> [  319.281910] -> #3 (&ap->scsi_scan_mutex){+.+...}:
> [  319.281927] -> #2 ((&ap->scsi_rescan_task)){+.+...}:
> [  319.281937] -> #1 (events){+.+.+.}:
> [  319.281970] -> #0 (&bdev->bd_mutex){+.+.+.}:

But the above is bogus.  It's only linked through the system_wq.  The
current lockdep notation assumes single execution resource and
triggers spuriously in certain cases.  I'll think about how to relax
it.

Thank you.

-- 
tejun
