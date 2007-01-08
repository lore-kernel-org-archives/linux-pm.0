From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [linux-pm] [PATCH 3/6] [-mm]: ACPI: duplicate ACPI sleep "alarm" attribute in	sysfs
Date: Mon, 8 Jan 2007 10:10:26 +0000
Message-ID: <20070108101026.GA14485@srcf.ucam.org>
References: <1168083318.5619.37.camel@localhost.localdomain> <200701061442.22340.david-b@pacbell.net> <20070107055757.GB24853@srcf.ucam.org> <200701071831.18186.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200701071831.18186.david-b@pacbell.net>
Sender: linux-acpi-owner@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: lenb@kernel.org, "linux-acpi@vger" <linux-acpi@vger.kernel.org>, linux-pm@lists.osdl.org, Zhang Rui <rui.zhang@intel.com>
List-Id: linux-pm@vger.kernel.org

On Sun, Jan 07, 2007 at 06:31:17PM -0800, David Brownell wrote:
> On Saturday 06 January 2007 9:57 pm, Matthew Garrett wrote:
> > Especially since /proc/acpi/alarm is just banging on the RTC registers 
> > - the only ACPI thing about it is that the FADT can expose whether or 
> > not the extended registers exist, and then making sure that the GPE is 
> > enabled.
> 
> The FADT also exposes whether the RTC can wake from S4.  You may have
> noticed that my rtc-cmos patch #3 exported the relevant FADT info
> to the RTC device using platform_data, but the S4 wake capability flag
> isn't useful for anything on today's Linux.

Isn't useful in what way? It'd be helpful for userspace to know that now 
that we're actually using S4 for swsusp, but I understand that it might 
not fit into the current API terribly well.

> Not speaking as an ACPI expert, I do see the ACPI spec says (right
> under fig 4-11 in my version) that RTC events don't require GPEs.

Hmm. My interpretation of that section had been that RTC_EN and RTC_STS 
were optional, and that a GPE would be required if they weren't 
implemented. On re-reading it, I think you're right.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
