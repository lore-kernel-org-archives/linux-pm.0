From: Tejun Heo <htejun@gmail.com>
Subject: Re: 2.6.22-rc3 hibernate(?) fails totally - regression (xfs on raid6)
Date: Thu, 07 Jun 2007 14:53:26 +0900
Message-ID: <46679D56.7040001@gmail.com>
References: <46608E3F.4060201@dgreaves.com> <200706012342.45657.rjw@sisk.pl> <46609FAD.7010203@dgreaves.com> <200706020122.49989.rjw@sisk.pl> <4661EFBB.5010406@dgreaves.com> <alpine.LFD.0.98.0706021538360.23741@woody.linux-foundation.org> <4662D852.4000005@dgreaves.com> <46667160.80905@gmail.com> <46668EE0.2030509@dgreaves.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753195AbXFGFxv@vger.kernel.org>
In-Reply-To: <46668EE0.2030509@dgreaves.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Greaves <david@dgreaves.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, xfs@oss.sgi.com, "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>, linux-pm <linux-pm@lists.osdl.org>, Neil Brown <neilb@suse.de>
List-Id: linux-pm@vger.kernel.org

Hello,

David Greaves wrote:
> Just to be clear. This problem is where my system won't resume after s2d
> unless I umount my xfs over raid6 filesystem.

This is really weird.  I don't see how xfs mount can affect this at all.

[--snip--]
> So now this compiles but it does cause the problem:
> 
> umount /huge
> echo platform > /sys/power/disk
> echo disk > /sys/power/state
> # resumes fine
> 
> mount /huge
> echo platform > /sys/power/disk
> echo disk > /sys/power/state
> # won't resume

How hard does the machine freeze?  Can you use sysrq?  If so, please
dump sysrq-t.

>   Behavior difference introduced by the
>> reimplementation is serialization of resume sequence, so it takes more
>> time.  My test machine had problems resuming if resume took too long
>> even with the previous implementation.  It didn't matter whether the
>> long resuming sequence is caused by too many controllers or explicit
>> ssleep().  If time needed for resume sequence is over certain threshold,
>> machine hangs while resuming.  I thought it was a BIOS glitch and didn't
>> dig into it but you might be seeing the same issue.
> given the mount/umount thing this sounds unlikely... but what do I know?

No I don't think this is the same problem either.  The problem I
described happened during resume from s2ram.

> resume does throw up:
> ATA: abnormal status 0x7F on port 0x0001b007
> ATA: abnormal status 0x7F on port 0x0001b007
> ATA: abnormal status 0x7F on port 0x0001a407
> ATA: abnormal status 0x7F on port 0x0001a407
> 
> which I've not noticed before... oh, alright, I'll check...
> reboots to 2.6.21, suspend, resume...
> nope, not output on resume in 2.6.21

The messages don't really matter.

Thanks.

-- 
tejun
