From: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-pm] [PATCH 3/6] [-mm]: ACPI: duplicate ACPI sleep "alarm" attribute in	sysfs
Date: Thu, 25 Jan 2007 16:33:15 -0800
Message-ID: <200701251633.16031.david-b@pacbell.net>
References: <1168083318.5619.37.camel@localhost.localdomain> <20070125194710.GC23774@elf.ucw.cz> <200701251812.21180.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <200701251812.21180.lenb@kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
To: linux-pm@lists.osdl.org
Cc: Len Brown <lenb@kernel.org>, Pavel Machek <pavel@ucw.cz>, "linux-acpi@vger" <linux-acpi@vger.kernel.org>, Alessandro Zummo <alessandro.zummo@towertech.it>, Paul Sokolovsky <pmiscml@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Thursday 25 January 2007 3:12 pm, Len Brown wrote:

> That's my point.
> What is the syntax to request "10-seconds into the future"?

See

  http://lists.osdl.org/pipermail/linux-pm/2007-January/004459.html

and morph the first example ... it shows 45*60 seconds into the future.
Substitute "45*60" ...

