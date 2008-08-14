From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: Power management for SCSI
Date: Fri, 15 Aug 2008 00:11:06 +0200
Message-ID: <48A4AD7A.1070903@s5r6.in-berlin.de>
References: <20080813095055.GA475@elf.ucw.cz> <Pine.LNX.4.44L0.0808131026320.2455-100000@iolanthe.rowland.org> <20080814130812.GC2262@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756194AbYHNWL5@vger.kernel.org>
In-Reply-To: <20080814130812.GC2262@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@suse.cz>
Cc: Alan Stern <stern@rowland.harvard.edu>, kernel list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>, James.Bottomley@HansenPartnership.com, teheo@novell.com, oneukum@suse.de
List-Id: linux-pm@vger.kernel.org

Pavel Machek wrote:
>> https://lists.linux-foundation.org/pipermail/linux-pm/2008-March/016849.html
...
> First the general comments/questions:
> 
> #
> #1. It's done at the wrong level: suspend "device" is actually a target
> #function.  There's no way on a multi-lun device we want to keep the
> #flags and last_busy anywhere but in the target
> 
> So... if there's one device with Lun0==cdrom1 and Lun1==cdrom2, it is a
> single target, and we want to keep flags/last busy common to all that?

Actually a command set driver like sd surely wants last_busy (time of 
last use) separate for each LU for auto-spindown, doesn't it?

I'm not sure about the rest, i.e. delay, counter, flags.

> What is good data structure to add? I see scsi_tgt*.h, but it is very
> short, and there does not seem to be good structure to hook into.

include/scsi/scsi_tgt*.h are for local target implementations.  The 
representation of "remote" targets, as seen by local initiators, is 
include/scsi/scsi_device.h's struct scsi_target.
-- 
Stefan Richter
-=====-==--- =--- -===-
http://arcgraph.de/sr/
