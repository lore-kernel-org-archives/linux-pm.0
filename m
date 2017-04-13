From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: RFC: WMI Enhancements
Date: Thu, 13 Apr 2017 15:51:02 +0200
Message-ID: <20170413135102.GL3090@pali>
References: <20170412230854.GA11963@fury>
 <20170413073228.GB1462@ozzy.nask.waw.pl>
 <3370431810bd4bc09fd9eb16eb9abea5@ausx13mpc120.AMER.DELL.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:32780 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751427AbdDMNvF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Apr 2017 09:51:05 -0400
Content-Disposition: inline
In-Reply-To: <3370431810bd4bc09fd9eb16eb9abea5@ausx13mpc120.AMER.DELL.COM>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mario.Limonciello@dell.com, Hans de Goede <hdegoede@redhat.com>
Cc: kernel@kempniu.pl, dvhart@infradead.org, rjw@rjwysocki.net, len.brown@intel.com, corentin.chary@gmail.com, luto@kernel.org, andriy.shevchenko@linux.intel.com, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org

On Thursday 13 April 2017 13:29:41 Mario.Limonciello@dell.com wrote:
> > Please pardon my ignorance, but what do we actually gain by exposing WMI to
> > userspace?  Enabling applications to fetch SMBIOS data?  We already have an
> > interface for that.  Enabling applications to receive input events?  Likewise.
> 
> Input notifications are just one aspect that received over WMI.  I don't see any
> reason to move the notifications out of the kernel.
> 
> In terms of userspace applications, once a WMI interface to userspace is available
> libsmbios would change over to that.  Applications using libsmbios would benefit.

Really libsmbios matters here? Hans (added to thread) wrote that
libsmbios is a relic, something of ages long gone by and a normal user
should never use it.

If this is truth and libsmbios should not be used, then we probably do
not need to care about it in changes for WMI.

Hans, Mario, any comment/clarification about it?

> > You mentioned WMI's efficiency compared to SMI/SMM, but is it a difference
> > significant enough for anyone to notice?
> 
> At least for Dell there are optimizations being made when data is requested over 
> the WMI-ACPI wrapper instead of directly via SMI/SMM.
> 
> For example if the data is a "static" table or the request is to something that is
> passed thru to the EC it's a big waste of effort to put the CPU in SMM.
> 
> The savings there is significant.

Maybe we can use this Dell WMI-ACPI wrapper for kernel drivers instead
of current SMI/SMM direct access?

-- 
Pali Rohár
pali.rohar@gmail.com
