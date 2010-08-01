From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.35-rc6-git6: Reported regressions from 2.6.34
Date: Sun, 1 Aug 2010 23:37:09 +0200
Message-ID: <201008012337.09961.rjw__33629.297084599$1280698798$gmane$org@sisk.pl>
References: <2dWFdr9kTFM.A.P0D.spXVMB@chimera>
	<AANLkTimcH7+Bq1UEbaSU7SQpzArPgmSLegiqE13V8=CF@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTimcH7+Bq1UEbaSU7SQpzArPgmSLegiqE13V8=CF@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux SCSI List <linux-scsi@vger.kernel.org>, Jens Axboe <jaxboe@fusionio.com>, Linux Wireless List <linux-wireless@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, DRI <dri-devel@lists.freedesktop.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Kernel Testers List <kernel-testers@vger.kernel.org>, Linux PM List <linux-pm@lists.linux-foundation.org>, Maciej Rutecki <maciej.rutecki@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Sunday, August 01, 2010, Linus Torvalds wrote:
> On Sun, Aug 1, 2010 at 6:46 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
...
> 
> > Bug-Entry       : http://bugzilla.kernel.org/show_bug.cgi?id=16369
> > Subject         : Yet another 2.6.35 regression (AGP)?
> > Submitter       : Woody Suwalski <terraluna977@gmail.com>
> > Date            : 2010-07-09 14:21 (24 days old)
> > Message-ID      : <4C373084.8000503@gmail.com>
> > References      : http://marc.info/?l=linux-kernel&m=127868797119254&w=2
> 
> Should hopefully be fixed by commit e7b96f28c58c ("agp/intel: Use the
> correct mask to detect i830 aperture size.")

Closed.

> > Bug-Entry       : http://bugzilla.kernel.org/show_bug.cgi?id=16365
> > Subject         : kernel BUG at fs/btrfs/extent-tree.c:1353
> > Submitter       : Johannes Hirte <johannes.hirte@fem.tu-ilmenau.de>
> > Date            : 2010-07-08 14:27 (25 days old)
> > Message-ID      : <201007081627.24654.johannes.hirte@fem.tu-ilmenau.de>
> > References      : http://marc.info/?l=linux-kernel&m=127859960725931&w=2
> 
> This one is reportedly fixed by commit 83ba7b071f30 ("writeback:
> simplify the write back thread queue")

Closed.

> > Bug-Entry       : http://bugzilla.kernel.org/show_bug.cgi?id=16215
> > Subject         : sysfs: cannot create duplicate filename '/class/net/bnep0'
> > Submitter       : Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
> > Date            : 2010-06-15 14:55 (48 days old)
> > Handled-By      : Eric W. Biederman <ebiederm@xmission.com>
> 
> Fixed by commit 24b1442d01ae155ea716dfb94ed21605541c317d.

Closed.

Thanks,
Rafael
