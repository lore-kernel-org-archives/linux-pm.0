From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH] PM QoS: Add debugfs support to view the list of constraints
Date: Mon, 15 Dec 2014 14:34:15 -0800
Message-ID: <7h1to0h7a0.fsf@deeprootsystems.com>
References: <1417799948-48440-1-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:52534 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750875AbaLOWeT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 15 Dec 2014 17:34:19 -0500
Received: by mail-pd0-f182.google.com with SMTP id p10so12468716pdj.41
        for <linux-pm@vger.kernel.org>; Mon, 15 Dec 2014 14:34:18 -0800 (PST)
In-Reply-To: <1417799948-48440-1-git-send-email-d-gerlach@ti.com> (Dave
	Gerlach's message of "Fri, 5 Dec 2014 11:19:08 -0600")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dave Gerlach <d-gerlach@ti.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Nishanth Menon <nm@ti.com>

Dave Gerlach <d-gerlach@ti.com> writes:

> From: Nishanth Menon <nm@ti.com>
>
> PM QoS requests are notoriously hard to debug and made even
> more so due to their highly dynamic nature. Having visibility
> into the internal data representation per constraint allows
> us to have much better appreciation of potential issues or
> bad usage by drivers in the system.
>
> So introduce for all classes of PM QoS, an entry in
> /sys/kernel/debug/pm_qos that shall show all the current
> requests as well as the snapshot of the value these requests
> boil down to. For example:
> ==> /sys/kernel/debug/pm_qos/cpu_dma_latency <==
> 1: 4444: Active
> 2: 2000000000: Default
> 3: 2000000000: Default
> 4: 2000000000: Default
> Type=Minimum, Value=4444, Requests: active=1 / total=4
>
> ==> /sys/kernel/debug/pm_qos/memory_bandwidth <==
> Empty!
>
> ...
>
> The actual value listed will have their meaning based
> on the QoS it is on, the 'Type' indicates what logic
> it would use to collate the information - Minimum,
> Maximum, or Sum. Value is the collation of all requests.
> This interface also compares the values with the defaults
> for the QoS class and marks the ones that are
> currently active.
>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>

A very useful feature indeed,

Acked-by: Kevin Hilman <khilman@linaro.org>

Kevin
