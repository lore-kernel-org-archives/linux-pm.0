From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [linux-pm] swsusp regression [Was: 2.6.17-mm1]
Date: Thu, 22 Jun 2006 01:25:00 -0700
Message-ID: <449A53DC.5090306@goop.org>
References: <20060621034857.35cfe36f.akpm@osdl.org>	<4499BE99.6010508@gmail.com>	<20060621221445.GB3798@inferi.kami.home>	<20060622061905.GD15834@kroah.com> <20060622004648.f1912e34.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S964792AbWFVIYz@vger.kernel.org>
In-Reply-To: <20060622004648.f1912e34.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, pavel@suse.cz, linux-pm@osdl.org, stern@rowland.harvard.edu
List-Id: linux-pm@vger.kernel.org

Andrew Morton wrote:
> My laptop has the same problem.
>   
Mine too.  I wonder if its related to the (apparently) bluetooth-caused 
oops I reported earlier today?

Though I'm seeing the suspend problem on a system with no bluetooth 
module loaded; the only USB device on the bus is the fingerprint-reader.

My suspend script removes the uhci_hcd module on suspend.  The device 
complaining EBUSY is the ehci hub, which has nothing hanging off it.

    J
