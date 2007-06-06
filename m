From: Tejun Heo <htejun@gmail.com>
Subject: Re: 2.6.22-rc3 hibernate(?) fails totally - regression
Date: Wed, 06 Jun 2007 17:33:36 +0900
Message-ID: <46667160.80905@gmail.com>
References: <46608E3F.4060201@dgreaves.com> <200706012342.45657.rjw@sisk.pl> <46609FAD.7010203@dgreaves.com> <200706020122.49989.rjw@sisk.pl> <4661EFBB.5010406@dgreaves.com> <alpine.LFD.0.98.0706021538360.23741@woody.linux-foundation.org> <4662D852.4000005@dgreaves.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758913AbXFFId4@vger.kernel.org>
In-Reply-To: <4662D852.4000005@dgreaves.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Greaves <david@dgreaves.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, xfs@oss.sgi.com, "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>, netdev@oss.sgi.com, linux-pm <linux-pm@lists.osdl.org>, Neil Brown <neilb@suse.de>
List-Id: linux-pm@vger.kernel.org

Hello,

David Greaves wrote:
> Linus Torvalds wrote:
>> It would be interesting to see what triggered it, since it apparently 
>> worked before. So yes, a bisection would be great.
> 
> Tejun, all the problematic patches are yours - so adding you.

Ouch....

> given the first patch identified is
> 9666f4009c22f6520ac3fb8a19c9e32ab973e828: "libata: reimplement suspend/resume
> support using sdev->manage_start_stop"
> That seems a good candidate...

9ce3075c20d458040138690edfdf6446664ec3ee works, right?  Can you test
9666f4009c22f6520ac3fb8a19c9e32ab973e828 by removing
ata_scsi_device_suspend/resume callbacks from sata_via.c?  Just delete
all lines referencing those two functions.  There were one or two
fallouts from the conversion.

How many drives do you have?  Behavior difference introduced by the
reimplementation is serialization of resume sequence, so it takes more
time.  My test machine had problems resuming if resume took too long
even with the previous implementation.  It didn't matter whether the
long resuming sequence is caused by too many controllers or explicit
ssleep().  If time needed for resume sequence is over certain threshold,
machine hangs while resuming.  I thought it was a BIOS glitch and didn't
dig into it but you might be seeing the same issue.

Please post dmesg too.  Thanks.

-- 
tejun
