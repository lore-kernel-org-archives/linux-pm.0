From: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-pm] [PATCH 0/6] [-mm]: ACPI: duplicate ACPI procfs functions in sysfs
Date: Thu, 25 Jan 2007 02:00:25 -0800
Message-ID: <200701250200.26338.david-b@pacbell.net>
References: <1168083306.5619.34.camel@localhost.localdomain> <1169693548.9381.1.camel@nigel.suspend2.net> <200701250917.48689.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <200701250917.48689.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
To: linux-pm@lists.osdl.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, nigel@nigel.suspend2.net, "linux-acpi@vger" <linux-acpi@vger.kernel.org>, linux-pm@osdl.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

> > > I think we need to make /sys/power/state handle S1.
> > > 
> > > There are two cases
> > > 
> > > 1. Platform supports S1, but does not support S3.
> > > 
> > > This is more common.  You see this a lot on server-class machines.
> > > 
> > > We could make "mem" simply mean S1 here b/c it is effectively
> > > the closest thing to S3.

Today, this system would list "standby" in /sys/power/state,
but not "mem".  I have a system like that here ...


> > > 2. Platform supports both S1 and S3.
> > > 
> > > This is pretty rare -- at least on the systems I've got.
> > > I'd  like the generic interface be able to describe and handle this case.

Today, this system would list both "standby" and "mem"
in /sys/power/state.  I have a system like that here ...


      3. (ACPI) platform supports S3 but not S1

Today, this system would list "mem" in /sys/power/state,
but not "standby".  I have a system like that here ...



> > > I'm open to suggestions on what to call S1 if it isn't called "mem".
> > 
> > 'standby'? That's what occurs to me from previous M$ usage.
> 
> Yes, something like that, I think..

Good news ... it already works that way!!!  :)

- Dave

