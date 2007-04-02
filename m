From: Pavel Machek <pavel@suse.cz>
Subject: Re: [linux-pm] Power Mangement Interfaces
Date: Mon, 2 Apr 2007 09:38:55 +0200
Message-ID: <20070402073855.GB13104@elf.ucw.cz>
References: <20070330235759.GC4252@cosmic.amd.com> <1175300283.23438.38.camel@johannes.berg> <20070331151613.GA8091@cosmic.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20070331151613.GA8091@cosmic.amd.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Jordan Crouse <jordan.crouse@amd.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-acpi@vger.kernel.org, linux-pm@lists.osdl.org, devel@laptop.org
List-Id: linux-pm@vger.kernel.org

Hi!

> > I think the sources file isn't really useful, a
> >   grep -l 1 /sys/power/wakeup/*
> > should do.
> 
> I was just trying to be friendly to folks who may be used to the ACPI
> method. 

Kernel is not place to be friendly.

#echo PWRB > /proc/acpi/wakeup
#
#Which changes the PWRB line to this:
#
#PWRB       1            *disabled
#
#I like this interface - its clean and pretty intuitive. Two problems -
#first, it is ACPI specific, so we can't share it, and secondly, it
#doesn't fit in to the sysfs model (which is to return only one value
#per file). An alternative would be something like this: 

Was this april's fools joke? /proc/acpi/wakeup is a nightmare, not a
clean interface.
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
