From: Pavel Machek <pavel@suse.cz>
Subject: x60 backlight Re: [discuss] 2.6.19-rc1: known regressions (v2)
Date: Sun, 8 Oct 2006 07:12:54 +0000
Message-ID: <20061008071254.GA5672@ucw.cz>
References: <Pine.LNX.4.64.0610042017340.3952@g5.osdl.org> <20061007214620.GB8810@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20061007214620.GB8810@stusta.de>
Sender: linux-acpi-owner@vger.kernel.org
To: Adrian Bunk <bunk@stusta.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, len.brown@intel.com, linux-acpi@vger.kernel.org, linux-pm@osdl.org
List-Id: linux-pm@vger.kernel.org


On Sat 07-10-06 23:46:21, Adrian Bunk wrote:
> This email lists some known regressions in 2.6.19-rc1 compared to 2.6.18
> that are not yet fixed Linus' tree.
> 
> If you find your name in the Cc header, you are either submitter of one
> of the bugs, maintainer of an affectected subsystem or driver, a patch
> of you was declared guilty for a breakage or I'm considering you in any
> other way possibly involved with one or more of these issues.
> 
> Due to the huge amount of recipients, please trim the Cc when answering.
...
> Subject    : T60 stops triggering any ACPI events
> References : http://lkml.org/lkml/2006/10/4/425
> Submitter  : "Michael S. Tsirkin" <mst@mellanox.co.il>
> Status     : unknown
> 
> 
> Subject    : thinkpad x60: brightness no longer adjustable in 2.6.18-git
> References : http://lkml.org/lkml/2006/10/2/300
> Submitter  : Pavel Machek <pavel@ucw.cz>
> Status     : unknown, related to the issue above?

Strange, problem went away after reboot. I guess I'll write it off as
an acpi glitch... there's definitely something strange going on with
backlight around s2ram: during normal operation, backlight changes are
fast. After s2ram, backlight change from keyboard takes 300msec or so.

-- 
Thanks for all the (sleeping) penguins.
