From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH 1/1] drivers: acpi: add CPU id to cooling device type of
 processor driver
Date: Thu, 05 May 2016 11:27:33 -0700
Message-ID: <1462472853.27421.11.camel@linux.intel.com>
References: <1462251879-7224-1-git-send-email-edubezval@gmail.com>
	 <CAJZ5v0hPL3Wc1ZKZv-Gqny5cur9+262OCuqVqbQ2US9=gpsX7g@mail.gmail.com>
	 <1462398872.14904.29.camel@linux.intel.com>
	 <2680812.8DqCpBTJz8@vostro.rjw.lan>
	 <20160505030645.GA2158@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:42469 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752284AbcEES0x (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 5 May 2016 14:26:53 -0400
In-Reply-To: <20160505030645.GA2158@localhost.localdomain>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Rui Zhang <rui.zhang@intel.com>, Linux PM <linux-pm@vger.kernel.org>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi Eduardo,

On Wed, 2016-05-04 at 20:06 -0700, Eduardo Valentin wrote:
> On Thu, May 05, 2016 at 12:00:57AM +0200, Rafael J. Wysocki wrote:
> >=20
> > On Wednesday, May 04, 2016 02:54:32 PM Srinivas Pandruvada wrote:
> > >=20
> > > On Wed, 2016-05-04 at 23:49 +0200, Rafael J. Wysocki wrote:
> > > >=20
> > > > On Tue, May 3, 2016 at 7:04 AM, Eduardo Valentin <edubezval@gma
> > > > il.com
> > > > >=20
> > > > > wrote:
> > > > >=20
> > > > > Currently, in an ACPI based system, the processor driver
> > > > > registers
> > > > > one cooling device per processor. However, the cooling device
> > > > > type
> > > > > is the same for each processor. For example, on a system with
> > > > > four
> > > > > processors, the sysfs reading of each cooling device would
> > > > > look
> > > > > like:
> > > > > ebv@besouro ~ $ cat /sys/class/thermal/cooling_device*/type
> > > > > Processor
> > > > > Processor
> > > > > Processor
> > > > > Processor
> > > > >=20
> > > > > which turns out to fine. But, some parts of the thermal code
> > > > > may
> > > > > use
> > > > > type to identify participating devices in a thermal zone.
> > > > > Besides,
> > > > > adding notifications to user space may cause the production
> > > > > of
> > > > > messages
> > > > > that may confuse the listener.
> > > > >=20
> > > > > For this reason, this patch adds the processor ID cooling
> > > > > device
> > > > > type.
> > > > > After this change, the cooling device listing in the same
> > > > > previous
> > > > > example
> > > > > would look like this:
> > > > > ebv@besouro ~ $ cat /sys/class/thermal/cooling_device*/type
> > > > > Processor.0
> > > > > Processor.1
> > > > > Processor.2
> > > > > Processor.3
> > > > >=20
> > > > > allowing an easier identification of cooling device target.
> > > > Is it not going to confuse any user space scripts or similar?
> > > Yes, it will.
> > In that case the patch cannot be applied.
> In fact, we shall never brake userspace.=C2=A0
>=20
> Srinivas, could you please elaborate a bit more on how this would
> break
> userspace? How different would it be having an extra id? Are you
> expecting "Processor" string in daemon?
Yes.
Also Processor is a special type of cdev on client systems. So you set
a state in one Processor all Processors cooling device gets changed as
they share voltage and frequency. So they all are same. So if some user
space tries to reduce the cur_state by 1 for all the processor cooling
devices they will effectively reduce cur_state to much lower value.

So instead of this, we should have only one processor cooling device
per CPU package, so on most of the client systems, we will see only one
processor cooling device.

Thanks,
Srinivas

>=20
> BR,
>=20
> >=20
> >=20
> > Thanks,
> > Rafael
> >=20
