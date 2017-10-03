From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PM: ARM: locomo: Drop suspend and resume bus type callbacks
Date: Tue, 03 Oct 2017 13:44:49 +0200
Message-ID: <38658124.i1yAOWmsJn@aspire.rjw.lan>
References: <2826985.0zUqx1lpzM@aspire.rjw.lan> <CAPDyKFrkUW7S7hkEsYH9UWex3F=1QHFLozxyMey1e+XT2a8JGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:62825 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751511AbdJCLyJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Oct 2017 07:54:09 -0400
In-Reply-To: <CAPDyKFrkUW7S7hkEsYH9UWex3F=1QHFLozxyMey1e+XT2a8JGg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Russell King <linux@armlinux.org.uk>, Linux PM <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>

On Tuesday, October 3, 2017 10:09:21 AM CEST Ulf Hansson wrote:
> On 26 September 2017 at 22:45, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > None of the locomo drivers in the tree implements the suspend and
> > resume callbacks from struct locomo_driver, so drop them and drop
> > the corresponding callbacks from locomo_bus_type.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> FWIW:
> 
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> 
> Do you also plan to convert the locomo_device_driver (platform_driver)
> to be converted to the modern PM callbacks for suspend/resume?

Yes, I do, but that later. :-)

Thanks,
Rafael
