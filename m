From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [Patch v3] ACPI, PCI: Penalize legacy IRQ used by ACPI SCI
Date: Wed, 26 Aug 2015 11:27:35 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1508261127060.15006@nanos>
References: <alpine.DEB.2.11.1508201247370.3873@nanos> <1440142584-22404-1-git-send-email-jiang.liu@linux.intel.com> <alpine.DEB.2.11.1508241957590.15006@nanos> <55DD2791.3020905@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:54579 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751887AbbHZJ2R (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 26 Aug 2015 05:28:17 -0400
In-Reply-To: <55DD2791.3020905@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>
Cc: Jiang Liu <jiang.liu@linux.intel.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Nick Meier <nmeier@microsoft.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

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

Rafael, can you take it via the ACPI tree?

Thanks,

	tglx
