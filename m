From: Tejun Heo <htejun@gmail.com>
Subject: Re: 2.6.22-rc3 hibernate(?) fails totally - regression (xfs on raid6)
Date: Thu, 14 Jun 2007 23:21:03 +0900
Message-ID: <46714ECF.8080203@gmail.com>
References: <200706020122.49989.rjw@sisk.pl> <46706968.7000703@dgreaves.com> <alpine.LFD.0.98.0706131507360.14121@woody.linux-foundation.org> <200706140115.58733.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753600AbXFNObW@vger.kernel.org>
In-Reply-To: <200706140115.58733.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, David Greaves <david@dgreaves.com>, David Chinner <dgc@sgi.com>, xfs@oss.sgi.com, "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>, linux-pm <linux-pm@lists.osdl.org>, Neil Brown <neilb@suse.de>, Jeff Garzik <jgarzik@pobox.com>
List-Id: linux-pm@vger.kernel.org

Hello,

Rafael J. Wysocki wrote:
> On Thursday, 14 June 2007 00:12, Linus Torvalds wrote:
>> On Wed, 13 Jun 2007, David Greaves wrote:
>>>> I'm not seeing anything really obvious. The traces would probably look
>>>> better if you enabled CONFIG_FRAME_POINTER, though. That should cut down on
>>>> some of the noise and make the traces a bit more readable.
>>> I can do that...
>> Thanks. That makes a big difference to the readability of the traces.
>>
>> That said, I'm so used to reading even the messy ones that this didn't 
>> actually tell me anything new (it made it clear that the SCSI error 
>> handler noise was just noise), but for people who aren't quite as used to 
>> seeing crap backtraces, your new trace might hopefully put them on the 
>> right track.
>>
>> I threw out the parts that didn't look all that relevant, and left the
>> ata_aux/md0_raid5/hibernate traces here for others to look at without all 
>> the other noise. Those _seem_ to be the primary suspects in this saga.
> 
> Hmm, it looks like both hibernate and ata_aux are waiting for the same
> completion.  I wonder who's supposed to complete it.

They're waiting for the commands they issued to complete.  ata_aux is
trying to revalidate the scsi device after libata EH finished waking up
the port and hibernate is trying to resume scsi disk device.  ata_aux is
issuing either TEST UNIT READY or START STOP.  hibernate is issuing
START STOP.

This can be caused by one of the followings.

1. SCSI EH thread (ATA EH runs off it) for the SCSI device hasn't
finished yet.  All commands are deferred while EH is in progress.

2. request_queue is stuck - somehow somebody forgot to kick the queue at
some point.

3. command is stuck somewhere in SCSI/ATA land.

#1 doesn't seem to be the case as all scsi_eh threads seems idle.  I'm
looking at the code but can't find anything which could cause #2 or #3.
 Also, these code paths are traveled really frequently.

I'm also trying to reproduce the problem here with xfs over RAID-6 array
but haven't been successful yet.

David, do you store the hibernation image on the RAID-6 array?  Can you
post the captured kernel log when it locks up?

-- 
tejun
