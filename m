From: Jens Axboe <jaxboe@fusionio.com>
Subject: Re: [PATCH RESEND block#for-2.6.36] block_dev: always
 serialize exclusive open attempts
Date: Thu, 5 Aug 2010 11:20:51 +0200
Message-ID: <4C5A8273.2010803__41560.548664029$1281000205$gmane$org@fusionio.com>
References: <2dWFdr9kTFM.A.P0D.spXVMB@chimera>
	<AANLkTimcH7+Bq1UEbaSU7SQpzArPgmSLegiqE13V8=CF@mail.gmail.com>
	<4C56F30D.3020304@kernel.org> <4C598E6B.7050405@gmail.com>
	<4C5A7E33.3060101@fusionio.com>
	<20100805091704.GA1772@arch.tripp.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100805091704.GA1772@arch.tripp.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Markus Trippelsdorf <markus@trippelsdorf.de>
Cc: Kernel@smtp1.linux-foundation.org, Tejun Heo <htejun@gmail.com>, Linux SCSI List <linux-scsi@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, Linux Wireless List <linux-wireless@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, DRI <dri-devel@lists.freedesktop.org>, "stable@kernel.org" <stable@kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Linux@smtp1.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>, Testers List <kernel-testers@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, List <linux-pm@lists.linux-foundation.org>, Maciej Rutecki <maciej.rutecki@gmail.com>
List-Id: linux-pm@vger.kernel.org

On 2010-08-05 11:17, Markus Trippelsdorf wrote:
> On Thu, Aug 05, 2010 at 11:02:43AM +0200, Jens Axboe wrote:
>> On 2010-08-04 17:59, Tejun Heo wrote:
>>> bd_prepare_to_claim() incorrectly allowed multiple attempts for
>>> exclusive open to progress in parallel if the attempting holders are
>>> identical.  This triggered BUG_ON() as reported in the following bug.
>>>
>>>   https://bugzilla.kernel.org/show_bug.cgi?id=16393
>>>
>>> __bd_abort_claiming() is used to finish claiming blocks and doesn't
>>> work if multiple openers are inside a claiming block.  Allowing
>>> multiple parallel open attempts to continue doesn't gain anything as
>>> those are serialized down in the call chain anyway.  Fix it by always
>>> allowing only single open attempt in a claiming block.
>>>
>>> This problem can easily be reproduced by adding a delay after
>>> bd_prepare_to_claim() and attempting to mount two partitions of a
>>> disk.
>>>
>>> stable: only applicable to v2.6.35
>>>
>>> Signed-off-by: Tejun Heo <tj@kernel.org>
>>> Reported-by: Markus Trippelsdorf <markus@trippelsdorf.de>
>>> Cc: stable@kernel.org
>>
>> Thanks Tejun, applied.
> 
> It's already in mainline:
> e75aa85892b2ee78c79edac720868cbef16e62eb

Irk, had not noticed yet, my for-2.6.36 branch isn't fully merged
up yet. Thanks for the heads-up.

-- 
Jens Axboe


Confidentiality Notice: This e-mail message, its contents and any attachments to it are confidential to the intended recipient, and may contain information that is privileged and/or exempt from disclosure under applicable law. If you are not the intended recipient, please immediately notify the sender and destroy the original e-mail message and any attachments (and any copies that may have been made) from your system or otherwise. Any unauthorized use, copying, disclosure or distribution of this information is strictly prohibited.
