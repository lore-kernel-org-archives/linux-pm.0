From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 1/1] drivers: acpi: add CPU id to cooling device type of
 processor driver
Date: Wed, 4 May 2016 20:06:46 -0700
Message-ID: <20160505030645.GA2158@localhost.localdomain>
References: <1462251879-7224-1-git-send-email-edubezval@gmail.com>
 <CAJZ5v0hPL3Wc1ZKZv-Gqny5cur9+262OCuqVqbQ2US9=gpsX7g@mail.gmail.com>
 <1462398872.14904.29.camel@linux.intel.com>
 <2680812.8DqCpBTJz8@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f174.google.com ([209.85.192.174]:33632 "EHLO
	mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755313AbcEEDGw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 4 May 2016 23:06:52 -0400
Content-Disposition: inline
In-Reply-To: <2680812.8DqCpBTJz8@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Rui Zhang <rui.zhang@intel.com>, Linux PM <linux-pm@vger.kernel.org>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Thu, May 05, 2016 at 12:00:57AM +0200, Rafael J. Wysocki wrote:
> On Wednesday, May 04, 2016 02:54:32 PM Srinivas Pandruvada wrote:
> > On Wed, 2016-05-04 at 23:49 +0200, Rafael J. Wysocki wrote:
> > > On Tue, May 3, 2016 at 7:04 AM, Eduardo Valentin <edubezval@gmail.com
> > > > wrote:
> > > > 
> > > > Currently, in an ACPI based system, the processor driver registers
> > > > one cooling device per processor. However, the cooling device type
> > > > is the same for each processor. For example, on a system with four
> > > > processors, the sysfs reading of each cooling device would look
> > > > like:
> > > > ebv@besouro ~ $ cat /sys/class/thermal/cooling_device*/type
> > > > Processor
> > > > Processor
> > > > Processor
> > > > Processor
> > > > 
> > > > which turns out to fine. But, some parts of the thermal code may
> > > > use
> > > > type to identify participating devices in a thermal zone. Besides,
> > > > adding notifications to user space may cause the production of
> > > > messages
> > > > that may confuse the listener.
> > > > 
> > > > For this reason, this patch adds the processor ID cooling device
> > > > type.
> > > > After this change, the cooling device listing in the same previous
> > > > example
> > > > would look like this:
> > > > ebv@besouro ~ $ cat /sys/class/thermal/cooling_device*/type
> > > > Processor.0
> > > > Processor.1
> > > > Processor.2
> > > > Processor.3
> > > > 
> > > > allowing an easier identification of cooling device target.
> > > 
> > > Is it not going to confuse any user space scripts or similar?
> >
> > Yes, it will.
> 
> In that case the patch cannot be applied.

In fact, we shall never brake userspace. 

Srinivas, could you please elaborate a bit more on how this would break
userspace? How different would it be having an extra id? Are you
expecting "Processor" string in daemon?

BR,

> 
> Thanks,
> Rafael
> 
