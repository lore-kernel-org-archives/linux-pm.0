From: Markus Trippelsdorf <markus@trippelsdorf.de>
Subject: Re: [PATCH RESEND block#for-2.6.36] block_dev: always
 serialize exclusive open attempts
Date: Thu, 5 Aug 2010 11:17:04 +0200
Message-ID: <20100805091704.GA1772__15732.1483515718$1281023817$gmane$org@arch.tripp.de>
References: <2dWFdr9kTFM.A.P0D.spXVMB@chimera>
	<AANLkTimcH7+Bq1UEbaSU7SQpzArPgmSLegiqE13V8=CF@mail.gmail.com>
	<4C56F30D.3020304@kernel.org> <4C598E6B.7050405@gmail.com>
	<4C5A7E33.3060101@fusionio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4C5A7E33.3060101@fusionio.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jens Axboe <jaxboe@fusionio.com>
Cc: Tejun Heo <htejun@gmail.com>, Linux SCSI List <linux-scsi@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, Linux Wireless List <linux-wireless@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, DRI <dri-devel@lists.freedesktop.org>, "stable@kernel.org" <stable@kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Kernel Testers List <kernel-testers@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Linux PM List <linux-pm@lists.linux-foundation.org>, Maciej Rutecki <maciej.rutecki@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Thu, Aug 05, 2010 at 11:02:43AM +0200, Jens Axboe wrote:
> On 2010-08-04 17:59, Tejun Heo wrote:
> > bd_prepare_to_claim() incorrectly allowed multiple attempts for
> > exclusive open to progress in parallel if the attempting holders are
> > identical.  This triggered BUG_ON() as reported in the following bug.
> > =

> >   https://bugzilla.kernel.org/show_bug.cgi?id=3D16393
> > =

> > __bd_abort_claiming() is used to finish claiming blocks and doesn't
> > work if multiple openers are inside a claiming block.  Allowing
> > multiple parallel open attempts to continue doesn't gain anything as
> > those are serialized down in the call chain anyway.  Fix it by always
> > allowing only single open attempt in a claiming block.
> > =

> > This problem can easily be reproduced by adding a delay after
> > bd_prepare_to_claim() and attempting to mount two partitions of a
> > disk.
> > =

> > stable: only applicable to v2.6.35
> > =

> > Signed-off-by: Tejun Heo <tj@kernel.org>
> > Reported-by: Markus Trippelsdorf <markus@trippelsdorf.de>
> > Cc: stable@kernel.org
> =

> Thanks Tejun, applied.

It's already in mainline:
e75aa85892b2ee78c79edac720868cbef16e62eb

-- =

=BBA man who doesn't know he is in prison can never escape.=AB
William S. Burroughs
