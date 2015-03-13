From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH 03/10] pm: domains: avoid potential oops in pm_genpd_remove_device()
Date: Fri, 13 Mar 2015 10:28:38 -0700
Message-ID: <7ha8zgrem1.fsf@deeprootsystems.com>
References: <20150312183020.GU8656@n2100.arm.linux.org.uk>
	<E1YWSN0-0006G1-I1@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:46959 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752116AbbCMR2m (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 13 Mar 2015 13:28:42 -0400
Received: by pabli10 with SMTP id li10so30960525pab.13
        for <linux-pm@vger.kernel.org>; Fri, 13 Mar 2015 10:28:41 -0700 (PDT)
In-Reply-To: <E1YWSN0-0006G1-I1@rmk-PC.arm.linux.org.uk> (Russell King's
	message of "Fri, 13 Mar 2015 16:23:30 +0000")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, linux-arm-kernel@lists.infradead.org, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org

Russell King <rmk+kernel@arm.linux.org.uk> writes:

> pm_genpd_remove_device() tries hard to validate the generic PM domain
> passed to it, but the validation is not complete.
>
> dev->pm_domain contains a struct dev_pm_domain, which is the "base
> class" of generic PM domains.  Other users of dev_pm_domains include
> stuff like vga_switheroo.  Hence, a device could have a generic PM
> domain or a vga_switcheroo PM domain in dev->pm_domain.
>
> We need ot be certain that the PM domain is actually valid before we
> try to remove it.  

nit: We need to be certain that the PM domain is a valid genpd before we
try to remove the device.

> We can do this easily as we have a way to get the
> current validated generic PM domain for a struct device.  This must
> match the generic PM domain being requested for removal.
>
> Convert the code to use this alternative validation method instead.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Otherwise,

Acked-by: Kevin Hilman <khilman@linaro.org>

