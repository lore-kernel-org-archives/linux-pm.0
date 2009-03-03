From: Jan Kara <jack@suse.cz>
Subject: Re: 2.6.29-rc6: Reported regressions from 2.6.28
Date: Tue, 3 Mar 2009 20:36:10 +0100
Message-ID: <20090303193609.GE27178__6721.83976644209$1236122931$gmane$org@atrey.karlin.mff.cuni.cz>
References: <GVhknozYwrL.A.hiC.rozoJB@chimera>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <GVhknozYwrL.A.hiC.rozoJB@chimera>
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
Cc: Adrian Bunk <bunk@kernel.org>, Linux SCSI List <linux-scsi@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Natalie Protasevich <protasnb@gmail.com>, Linux ACPI <linux-acpi@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Kernel Testers List <kernel-testers@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Linux PM List <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

  Hi,

> Unresolved regressions
> ----------------------
> 
> Bug-Entry	: http://bugzilla.kernel.org/show_bug.cgi?id=12551
> Subject		: end_request: I/O error, dev cciss/c0d0, sector 87435720
> Submitter	: Ralf Hildebrandt <ralf.hildebrandt@charite.de>
> Date		: 2009-01-27 06:51 (28 days old)
> 
> Bug-Entry	: http://bugzilla.kernel.org/show_bug.cgi?id=12497
> Subject		: new barrier warnings in 2.6.29-rc1
> Submitter	: Christoph Hellwig <hch@lst.de>
> Date		: 2009-01-12 15:46 (43 days old)
> References	: http://marc.info/?l=linux-kernel&m=123177528217154&w=4
> Handled-By	: Jens Axboe <jens.axboe@oracle.com>
  I've just noticed that the above two reports are probably the same bug...
Just that we don't duplicate the effort.

									Honza
-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
