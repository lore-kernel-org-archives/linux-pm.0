From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: [Patch v3] ACPI, PCI: Penalize legacy IRQ used by ACPI SCI
Date: Wed, 26 Aug 2015 10:42:25 +0800
Message-ID: <55DD2791.3020905@intel.com>
References: <alpine.DEB.2.11.1508201247370.3873@nanos>
 <1440142584-22404-1-git-send-email-jiang.liu@linux.intel.com>
 <alpine.DEB.2.11.1508241957590.15006@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:56514 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750920AbbHZCky (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 25 Aug 2015 22:40:54 -0400
In-Reply-To: <alpine.DEB.2.11.1508241957590.15006@nanos>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, Jiang Liu <jiang.liu@linux.intel.com>
Cc: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Nick Meier <nmeier@microsoft.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On 08/25/2015 04:01 PM, Thomas Gleixner wrote:
> On Fri, 21 Aug 2015, Jiang Liu wrote:
>> ---
>> Hi Nick,
>> 	Rafael and Thomas have concerns about the way to solve the
>> regression by quirk, so could you please help to test this patch?
> 
> Nick, can you please confirm that this works?

I saw Nick said this in bugzilla:
"
Tested the v3 patch - it works in a Hyper-V environment.  The Tulip driver loads and the NIC was successfully assigned an IP address via DHCP.
"
https://bugzilla.kernel.org/show_bug.cgi?id=101301#c17

Regards,
Aaron
