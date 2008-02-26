From: Mark Lord <lkml@rtr.ca>
Subject: Re: [ugly patch] Save .15W-.5W by AHCI powersaving
Date: Tue, 26 Feb 2008 10:52:36 -0500
Message-ID: <47C435C4.9000402@rtr.ca>
References: <20080225134558.GA1611@elf.ucw.cz> <47C34081.5090205@rtr.ca> <20080225223432.GN2659@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
In-Reply-To: <20080225223432.GN2659@elf.ucw.cz>
Sender: linux-ide-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Mark Lord <liml@rtr.ca>, kernel list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>, stern@rowland.harvard.edu, linux-ide@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Pavel Machek wrote:
> Hi!
> 
>>> This is a patch (very ugly, assumes you have just one disk) to bring
>>> powersaving to AHCI. You need Alan's SCSI autosuspend (attached) patch
>>> as a base.
>>>
>>> It saves .5W compared to config with disk spinning, and even .15W
>>> compared to hdparm -y... on my thinkpad x60 anyway.
>> ..
>>
>> There was a discussion of this here today.
> 
> Real-life discussion, or something I could read? :-).
> 
>> It makes good use of AHCI-specific features.
>>
>> Has it been tested with a Port-Multiplier yet?
> 
> I do not know what port-multiplier is, sorry. But it was not really
> tested. It is not expected to work on any other config than notebook
> very similar to mine.
> 
>> This is cool enough that we really ought to do a hardware-independent
>> version, so that all SATA interfaces could benefit.  Especially ata_piix,
>> but others too.
> 
> Well, it seems like it is 10 lines per driver once Alan's SCSI
> autosuspend patches are in...
..

Cool (literally)!

I think I might have gotten your patch confused in my mind
with another AHCI patch, which uses features of the chip itself
to automatically negotiate/change link power status on the fly
(no s/w needed, other than to turn it on).

That one is very ACPI specific, though.


