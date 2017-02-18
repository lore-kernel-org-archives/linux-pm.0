From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PM / QoS: Fix memory leak on resume_latency.notifiers
Date: Sat, 18 Feb 2017 02:21:56 +0100
Message-ID: <2976806.GAICYqDY4c@aspire.rjw.lan>
References: <20170216172150.17948-1-john@metanate.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:59168 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752446AbdBRB04 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Feb 2017 20:26:56 -0500
In-Reply-To: <20170216172150.17948-1-john@metanate.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: John Keeping <john@metanate.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Thursday, February 16, 2017 05:21:50 PM John Keeping wrote:
> Since commit 2d984ad132a8 ("PM / QoS: Introcuce latency tolerance device
> PM QoS type") we reassign "c" to point at qos->latency_tolerance before
> freeing c->notifiers, but the notifiers field of latency_tolerance is
> never used.
> 
> Restore the original behaviour of freeing the notifiers pointer on
> qos->resume_latency, which is used, and fix the following kmemleak
> warning.
> 
> unreferenced object 0xed9dba00 (size 64):
>   comm "kworker/0:1", pid 36, jiffies 4294670128 (age 15202.983s)
>   hex dump (first 32 bytes):
>     00 00 00 00 04 ba 9d ed 04 ba 9d ed 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<c06f6084>] kmemleak_alloc+0x74/0xb8
>     [<c011c964>] kmem_cache_alloc_trace+0x170/0x25c
>     [<c035f448>] dev_pm_qos_constraints_allocate+0x3c/0xe4
>     [<c035f574>] __dev_pm_qos_add_request+0x84/0x1a0
>     [<c035f6cc>] dev_pm_qos_add_request+0x3c/0x54
>     [<c03c3fc4>] usb_hub_create_port_device+0x110/0x2b8
>     [<c03b2a60>] hub_probe+0xadc/0xc80
>     [<c03bb050>] usb_probe_interface+0x1b4/0x260
>     [<c035773c>] driver_probe_device+0x198/0x40c
>     [<c0357b14>] __device_attach_driver+0x8c/0x98
>     [<c0355bbc>] bus_for_each_drv+0x8c/0x9c
>     [<c0357494>] __device_attach+0x98/0x138
>     [<c0357c64>] device_initial_probe+0x14/0x18
>     [<c03569dc>] bus_probe_device+0x30/0x88
>     [<c0354c54>] device_add+0x430/0x554
>     [<c03b92d8>] usb_set_configuration+0x660/0x6fc
> 
> Fixes: 2d984ad132a8 ("PM / QoS: Introcuce latency tolerance device PM QoS type")
> Signed-off-by: John Keeping <john@metanate.com>

Applied.

Thanks,
Rafael
