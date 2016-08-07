From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH v2 11/13] PM / sleep: Allow opt-out from runtime resume
 after direct-complete
Date: Sun, 7 Aug 2016 11:33:17 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1608071105360.31680-100000@netrider.rowland.org>
References: <20160807095627.GB5679@wunner.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:53095 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751633AbcHGPeB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 7 Aug 2016 11:34:01 -0400
In-Reply-To: <20160807095627.GB5679@wunner.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lukas Wunner <lukas@wunner.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, Andreas Noever <andreas.noever@gmail.com>

On Sun, 7 Aug 2016, Lukas Wunner wrote:

> Normally the device hierarchy is traversed bottom-up during suspend
> and top-down during resume. However ->prepare and ->complete do it
> the other way round. In the case of ->prepare, this is even documented
> in Documentation/power/devices.txt but the reason thereof is not.
> Could you explain this please?

The purpose of ->prepare is to tell drivers that a system sleep is
beginning and accordingly they should stop registering new children.  
This is necessary for the PM core to be able to traverse the entire
device tree safely; we want to avoid races where a new child is added
below a device concurrently with that device being suspended.  (Or if
you want to be more precise, races in which a new child is added below
a device while the PM core is acquiring the device's lock just prior to
invoking its ->suspend callback.)

Telling drivers to stop registering new children below a device has to
be done top-down, because if it were done bottom-up then it would be
subject to the same race described above.  Doing it top-down avoids 
problems; if a device registers new children while the PM core is 
acquiring its lock prior to invoking ->prepare, it doesn't matter.  The 
new children will be handled later, right along with the existing ones.

Alan Stern

