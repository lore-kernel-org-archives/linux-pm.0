From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [Patch v3] ACPI, PCI: Penalize legacy IRQ used by ACPI SCI
Date: Wed, 26 Aug 2015 09:56:04 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1508260953480.15006@nanos>
References: <alpine.DEB.2.11.1508201247370.3873@nanos> <1440142584-22404-1-git-send-email-jiang.liu@linux.intel.com> <alpine.DEB.2.11.1508241957590.15006@nanos> <55DD2791.3020905@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <55DD2791.3020905@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>
Cc: Jiang Liu <jiang.liu@linux.intel.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Nick Meier <nmeier@microsoft.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, 26 Aug 2015, Aaron Lu wrote:
> On 08/25/2015 04:01 PM, Thomas Gleixner wrote:
> > On Fri, 21 Aug 2015, Jiang Liu wrote:
> >> ---
> >> Hi Nick,
> >> 	Rafael and Thomas have concerns about the way to solve the
> >> regression by quirk, so could you please help to test this patch?
> > 
> > Nick, can you please confirm that this works?
> 
> I saw Nick said this in bugzilla:
> "
> Tested the v3 patch - it works in a Hyper-V environment.  The Tulip driver loads and the NIC was successfully assigned an IP address via DHCP.
> "
> https://bugzilla.kernel.org/show_bug.cgi?id=101301#c17

Bah. Can we please keep such things on the mailinglist? The bugzilla
entry is good for tracking the issue, but certainly not for patch
discussion and validation.

Thanks

	tglx
