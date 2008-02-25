From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [ugly patch] Save .15W-.5W by AHCI powersaving
Date: Mon, 25 Feb 2008 17:42:58 -0500
Message-ID: <47C34472.3090706@garzik.org>
References: <20080225134558.GA1611@elf.ucw.cz> <47C34081.5090205@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
In-Reply-To: <47C34081.5090205@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>, stern@rowland.harvard.edu, linux-ide@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Mark Lord wrote:
> Pavel Machek wrote:
>> This is a patch (very ugly, assumes you have just one disk) to bring
>> powersaving to AHCI. You need Alan's SCSI autosuspend (attached) patch
>> as a base.
>>
>> It saves .5W compared to config with disk spinning, and even .15W
>> compared to hdparm -y... on my thinkpad x60 anyway.
> ..
> 
> There was a discussion of this here today.
> It makes good use of AHCI-specific features.
> 
> Has it been tested with a Port-Multiplier yet?
> 
> This is cool enough that we really ought to do a hardware-independent
> version, so that all SATA interfaces could benefit.  Especially ata_piix,
> but others too.

BTW we can also save power by allowing the user to choose to disable 
hotplugging support.  Then we can power down PHYs that are not in use.

That requires the addition of some policy controls, because it is 
user-specific whether or not to waste power waiting for a plug-in event.

	Jeff



