From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [ugly patch] Save .15W-.5W by AHCI powersaving
Date: Mon, 25 Feb 2008 23:34:32 +0100
Message-ID: <20080225223432.GN2659@elf.ucw.cz>
References: <20080225134558.GA1611@elf.ucw.cz> <47C34081.5090205@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <47C34081.5090205@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: kernel list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>, stern@rowland.harvard.edu, linux-ide@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi!

>> This is a patch (very ugly, assumes you have just one disk) to bring
>> powersaving to AHCI. You need Alan's SCSI autosuspend (attached) patch
>> as a base.
>>
>> It saves .5W compared to config with disk spinning, and even .15W
>> compared to hdparm -y... on my thinkpad x60 anyway.
> ..
>
> There was a discussion of this here today.

Real-life discussion, or something I could read? :-).

> It makes good use of AHCI-specific features.
>
> Has it been tested with a Port-Multiplier yet?

I do not know what port-multiplier is, sorry. But it was not really
tested. It is not expected to work on any other config than notebook
very similar to mine.

> This is cool enough that we really ought to do a hardware-independent
> version, so that all SATA interfaces could benefit.  Especially ata_piix,
> but others too.

Well, it seems like it is 10 lines per driver once Alan's SCSI
autosuspend patches are in...
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
