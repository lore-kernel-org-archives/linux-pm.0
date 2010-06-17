From: Len Brown <lenb@kernel.org>
Subject: Re: [linux-pm] RFC: /sys/power/policy_preference
Date: Thu, 17 Jun 2010 15:02:03 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1006171500260.4214@localhost.localdomain>
References: <alpine.LFD.2.00.1006161659140.24913@localhost.localdomain>
 <0F1C0B07-60D6-405B-890B-F9C320820CA5@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
In-reply-to: <0F1C0B07-60D6-405B-890B-F9C320820CA5@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Victor Lowther <victor.lowther@gmail.com>
Cc: Linux Power Management List <linux-pm@lists.osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


> On Jun 16, 2010, at 4:05 PM, Len Brown <lenb@kernel.org> wrote:
> 
> > Create /sys/power/policy_preference, giving user-space
> > the ability to express its preference for kernel based
> > power vs. performance decisions in a single place.
> > 
> > This gives kernel sub-systems and drivers a central place
> > to discover this system-wide policy preference.
> > It also allows user-space to not have to be updated
> > every time a sub-system or driver adds a new power/perf knob.
> 
> I would prefer documenting all the current knobs and adding them to pm-utils
> so that pm-powersave knows about and can manage them. Once that is done,
> creating arbitrary powersave levels should be fairly simple.


The idea here is to not require user-space to need updating
whenever a future knob is invented.  We can do a great job
at documenting the past, but a poor job of documenting the future:-)

cheers,
Len Brown, Intel Open Source Technolgy Center
