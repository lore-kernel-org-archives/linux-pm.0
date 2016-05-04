From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH 1/1] drivers: acpi: add CPU id to cooling device type of
 processor driver
Date: Wed, 04 May 2016 14:54:32 -0700
Message-ID: <1462398872.14904.29.camel@linux.intel.com>
References: <1462251879-7224-1-git-send-email-edubezval@gmail.com>
	 <CAJZ5v0hPL3Wc1ZKZv-Gqny5cur9+262OCuqVqbQ2US9=gpsX7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0hPL3Wc1ZKZv-Gqny5cur9+262OCuqVqbQ2US9=gpsX7g@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>, Eduardo Valentin <edubezval@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Rui Zhang <rui.zhang@intel.com>, Linux PM <linux-pm@vger.kernel.org>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 2016-05-04 at 23:49 +0200, Rafael J. Wysocki wrote:
> On Tue, May 3, 2016 at 7:04 AM, Eduardo Valentin <edubezval@gmail.com
> > wrote:
> > 
> > Currently, in an ACPI based system, the processor driver registers
> > one cooling device per processor. However, the cooling device type
> > is the same for each processor. For example, on a system with four
> > processors, the sysfs reading of each cooling device would look
> > like:
> > ebv@besouro ~ $ cat /sys/class/thermal/cooling_device*/type
> > Processor
> > Processor
> > Processor
> > Processor
> > 
> > which turns out to fine. But, some parts of the thermal code may
> > use
> > type to identify participating devices in a thermal zone. Besides,
> > adding notifications to user space may cause the production of
> > messages
> > that may confuse the listener.
> > 
> > For this reason, this patch adds the processor ID cooling device
> > type.
> > After this change, the cooling device listing in the same previous
> > example
> > would look like this:
> > ebv@besouro ~ $ cat /sys/class/thermal/cooling_device*/type
> > Processor.0
> > Processor.1
> > Processor.2
> > Processor.3
> > 
> > allowing an easier identification of cooling device target.
> Is it not going to confuse any user space scripts or similar?
Yes, it will.

Thanks,
Srinivas




