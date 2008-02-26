From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [ugly patch] Save .15W-.5W by AHCI powersaving
Date: Tue, 26 Feb 2008 16:21:43 +0000
Message-ID: <20080226162142.GA12020@srcf.ucam.org>
References: <20080225134558.GA1611@elf.ucw.cz> <47C34081.5090205@rtr.ca> <47C34472.3090706@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <47C34472.3090706@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Mark Lord <liml@rtr.ca>, Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>, stern@rowland.harvard.edu, linux-ide@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, Feb 25, 2008 at 05:42:58PM -0500, Jeff Garzik wrote:

> BTW we can also save power by allowing the user to choose to disable 
> hotplugging support.  Then we can power down PHYs that are not in use.
> 
> That requires the addition of some policy controls, because it is 
> user-specific whether or not to waste power waiting for a plug-in event.

For AHCI, if you've enabled link power management then you've already 
disabled hotplug. We might as well power down unused phys in that case. 
Note that laptop bays still seem to tend to use platform-specific 
hotplug notification, even when they're sata - we'll get the hotplug 
notify for them even if the phy's powered down, so that case also needs 
to be handled.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
