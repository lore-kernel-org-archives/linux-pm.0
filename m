From: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-pm] [PATCH 3/6] [-mm]: ACPI: duplicate ACPI sleep "alarm" attribute in	sysfs
Date: Mon, 8 Jan 2007 12:35:52 -0800
Message-ID: <200701081235.52592.david-b@pacbell.net>
References: <1168083318.5619.37.camel@localhost.localdomain> <200701071944.59470.david-b@pacbell.net> <20070108113612.GC25857@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20070108113612.GC25857@elf.ucw.cz>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@lists.osdl.org, Alessandro Zummo <alessandro.zummo@towertech.it>, "linux-acpi@vger" <linux-acpi@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, Paul Sokolovsky <pmiscml@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Monday 08 January 2007 3:36 am, Pavel Machek wrote:
> 
> What about periodic alarms? 

So far as I'm concerned they're not part of the API.  The periodicity notion
of the alarm on PC RTCs is pretty bizarre if you look at it ... not portable
to much non-PC hardware (without extremely ugly hacks nobody's likely to do),
and so not appropriate to include in a cross-platform API framework.

The user model of a one-shot alarm is simple and easy to understand; plus it's
a direct match for the alarms people use all the time in the kitchen and to
wake up in the morning.

- Dave
