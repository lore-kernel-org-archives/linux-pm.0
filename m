From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PM / QoS: Fix default runtime_pm device resume latency
Date: Tue, 31 Oct 2017 00:27:52 +0100
Message-ID: <3227682.nATp9NGxKU@aspire.rjw.lan>
References: <1509347446-26105-1-git-send-email-t-kristo@ti.com> <CAJZ5v0i8HMDfV907QDTD54YPaFpoBLVt+R4oeQ704+9_C8APoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:46842 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752050AbdJ3X1s (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Oct 2017 19:27:48 -0400
In-Reply-To: <CAJZ5v0i8HMDfV907QDTD54YPaFpoBLVt+R4oeQ704+9_C8APoA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Monday, October 30, 2017 11:19:08 AM CET Rafael J. Wysocki wrote:
> On Mon, Oct 30, 2017 at 8:10 AM, Tero Kristo <t-kristo@ti.com> wrote:
> > The recent change to the PM QoS framework to introduce a proper
> > no constraint value overlooked to handle the devices which don't
> > implement PM QoS OPS. Runtime PM is one of the more severely
> > impacted subsystems, failing every attempt to runtime suspend
> > a device. This leads into some nasty second level issues like
> > probe failures and increased power consumption among other things.
> 
> Oh, that's bad.
> 
> Sorry about breaking it and thanks for the fix!
> 
> > Fix this by adding a proper return value for devices that don't
> > implement PM QoS implicitly.
> >
> > Fixes: 0cc2b4e5a020 ("PM / QoS: Fix device resume latency PM QoS")
> > Signed-off-by: Tero Kristo <t-kristo@ti.com>
> > Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Applied.

And pushed to Linus.

That said, probe shouldn't ever fail if PM QoS is set to the
"never suspend" value.

User space can set it that way, after all, so the drivers that fail to probe
in that case aren't correct I'm afraid.

Thanks,
Rafael
