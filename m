From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PM QoS: Add debugfs support to view the list of constraints
Date: Fri, 30 Jan 2015 01:10:57 +0100
Message-ID: <4174934.VKXlq5EvTQ@vostro.rjw.lan>
References: <1417799948-48440-1-git-send-email-d-gerlach@ti.com> <7h1to0h7a0.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:59542 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1758279AbbA2XsJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 29 Jan 2015 18:48:09 -0500
In-Reply-To: <7h1to0h7a0.fsf@deeprootsystems.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kevin Hilman <khilman@kernel.org>
Cc: Dave Gerlach <d-gerlach@ti.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Nishanth Menon <nm@ti.com>

On Monday, December 15, 2014 02:34:15 PM Kevin Hilman wrote:
> Dave Gerlach <d-gerlach@ti.com> writes:
> 
> > From: Nishanth Menon <nm@ti.com>
> >
> > PM QoS requests are notoriously hard to debug and made even
> > more so due to their highly dynamic nature. Having visibility
> > into the internal data representation per constraint allows
> > us to have much better appreciation of potential issues or
> > bad usage by drivers in the system.
> >
> > So introduce for all classes of PM QoS, an entry in
> > /sys/kernel/debug/pm_qos that shall show all the current
> > requests as well as the snapshot of the value these requests
> > boil down to. For example:
> > ==> /sys/kernel/debug/pm_qos/cpu_dma_latency <==
> > 1: 4444: Active
> > 2: 2000000000: Default
> > 3: 2000000000: Default
> > 4: 2000000000: Default
> > Type=Minimum, Value=4444, Requests: active=1 / total=4
> >
> > ==> /sys/kernel/debug/pm_qos/memory_bandwidth <==
> > Empty!
> >
> > ...
> >
> > The actual value listed will have their meaning based
> > on the QoS it is on, the 'Type' indicates what logic
> > it would use to collate the information - Minimum,
> > Maximum, or Sum. Value is the collation of all requests.
> > This interface also compares the values with the defaults
> > for the QoS class and marks the ones that are
> > currently active.
> >
> > Signed-off-by: Nishanth Menon <nm@ti.com>
> > Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
> 
> A very useful feature indeed,
> 
> Acked-by: Kevin Hilman <khilman@linaro.org>

Queued up for 3.20, thanks!


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
