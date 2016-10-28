From: Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v5 0/5] Functional dependencies between devices
Date: Fri, 28 Oct 2016 11:39:59 +0200
Message-ID: <20161028093959.GA7889@wunner.de>
References: <27296716.H9VWo8ShOm@vostro.rjw.lan>
 <13957403.ZrB4mMbICz@vostro.rjw.lan>
 <5811F0CF.5000204@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.hostsharing.net ([83.223.95.204]:56645 "EHLO
        mailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756318AbcJ1JjR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 Oct 2016 05:39:17 -0400
Content-Disposition: inline
In-Reply-To: <5811F0CF.5000204@huawei.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hanjun Guo <guohanjun@huawei.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Mark Brown <broonie@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, "Luis R. Rodriguez" <mcgrof@suse.com>

On Thu, Oct 27, 2016 at 08:19:27PM +0800, Hanjun Guo wrote:
> I'm trying to using this patch set to solve the functional dependency
> between devices and irqchip, which are both ACPI platform devices.
> irqchip needs to be probed before the devices connecting to them,
> which specifically, it's the mbi-gen support I send out recently:
> 
> https://lkml.org/lkml/2016/10/25/453
> 
> But I didn't see an example to do so in this patch set, and seems that
> some extra code needs to be added for that purpose, could you give me
> some suggestions for how to do that then I can work on and test against
> your patch set?

If the consumers can detect that there's a consumer on which they depend,
you could call device_link_add() from their ->probe hook.

Generally the earliest point in time when device links can be added is
after device_initialize() has been called for the consumer and device_add()
has been called for the supplier.  (At least that's my understanding.)

HTH,

Lukas
