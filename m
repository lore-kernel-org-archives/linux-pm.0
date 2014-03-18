From: Sitsofe Wheeler <sitsofe@yahoo.com>
Subject: Re: No suspend to RAM support
Date: Tue, 18 Mar 2014 17:18:35 +0000
Message-ID: <20140318171834.GA21342@sucs.org>
References: <20140317205302.GA14066@sucs.org>
 <20140318095945.GA11429@amd.pavel.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from silver.sucs.swan.ac.uk ([137.44.10.1]:35528 "EHLO
	silver.sucs.swan.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754194AbaCRRSm (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 18 Mar 2014 13:18:42 -0400
Content-Disposition: inline
In-Reply-To: <20140318095945.GA11429@amd.pavel.ucw.cz>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org

Hello!

On Tue, Mar 18, 2014 at 10:59:45AM +0100, Pavel Machek wrote:
> 
> > I have an (old) Athlon II Neo N36L but I've noticed that with the 3.2
> > Debian stable kernel only disk is present in /sys/power/state so
> > suspend to RAM can't be used (but hibernating and resuming work fine).
> > 
> > The machine seemingly supports S5 ACPI so I'm guessing there's a reason
> > suspend has been disabled but does anyone know what it is?
> > 
> > The same issue happens with the 3.11 kernel on a Fedora LiveCD. dmesg
> > below:
> 
> Has suspend-to-RAM ever worked on that machine? If BIOS does not
> support it, there's little we can do...

I've never run older Linux distros on the machine so I have no way to
know. How can I tell that the BIOS does not support it - is there going
to be anything in dmesg?

-- 
Sitsofe | http://sucs.org/~sits/
