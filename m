From: Tejun Heo <tj@kernel.org>
Subject: Re: 2.6.35-rc6-git6: Reported regressions from 2.6.34
Date: Mon, 02 Aug 2010 18:32:13 +0200
Message-ID: <4C56F30D.3020304__829.313373151486$1280766864$gmane$org@kernel.org>
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
Cc: Linux SCSI List <linux-scsi@vger.kernel.org>, Jens Axboe <jaxboe@fusionio.com>, Linux Wireless List <linux-wireless@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, DRI <dri-devel@lists.freedesktop.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Kernel Testers List <kernel-testers@vger.kernel.org>, Linux PM List <linux-pm@lists.linux-foundation.org>, Maciej Rutecki <maciej.rutecki@gmail.com>
List-Id: linux-pm@vger.kernel.org

Hello, Linus.

On 08/01/2010 08:01 PM, Linus Torvalds wrote:
> This has a proposed patch. I don't know what the status of it is, though. Jens?
> 
>    http://marc.info/?l=linux-kernel&m=127950018204029&w=2
> 
>> Bug-Entry       : http://bugzilla.kernel.org/show_bug.cgi?id=16393
>> Subject         : kernel BUG at fs/block_dev.c:765!
>> Submitter       : Markus Trippelsdorf <markus@trippelsdorf.de>
>> Date            : 2010-07-14 13:52 (19 days old)
>> Message-ID      : <20100714135217.GA1797@arch.tripp.de>
>> References      : http://marc.info/?l=linux-kernel&m=127911564213748&w=2
> 
> This one is interesting. And I think I perhaps see where it's coming from.
> 
> bd_start_claiming() (through bd_prepare_to_claim()) has two separate
> success cases: either there was no holder (bd_claiming is NULL) or the
> new holder was already claiming it (bd_claiming == holder).
> 
> Note in particular the case of the holder _already_ holding it. What happens is:
> 
>  - bd_start_claiming() succeeds because we had _already_ claimed it
> with the same holder
> 
>  - then some error happens, and we call bd_abort_claiming(), which
> does whole->bd_claiming = NULL;
> 
>  - the original holder thinks it still holds the bd, but it has been released!
> 
>  - a new claimer comes in, and succeeds because bd_claiming is now NULL.
> 
>  - we now have two "owners" of the bd, but bd_claiming only points to
> the second one.
> 
> I think bd_start_claiming() needs to do some kind of refcount for the
> nested holder case, and bd_abort_claiming() needs to decrement the
> refcount and only clear the bd_claiming field when it goes down to
> zero.
> 
> I dunno. Maybe there's something else going on, but it does look
> suspicious, and the above would explain the BUG_ON().

Yeah, that definitely sounds plausible.  I think the condition check
in bd_prepare_to_claim() should have been "if (whole->bd_claiming)"
instead of "if (whole->bd_claiming && whole->bd_claiming != holder)".
It doesn't make much sense to allow multiple parallel claiming
operations anyway and the comment above already says - "This function
fails if @bdev is already claimed by another holder and waits if
another claiming is in progress."

I'll try to build a test case and verify it.

Thank you.

-- 
tejun
