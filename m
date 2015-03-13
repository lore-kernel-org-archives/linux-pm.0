From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH 02/10] pm: domains: factor out code to get the generic PM domain from a struct device
Date: Fri, 13 Mar 2015 10:20:21 -0700
Message-ID: <7hpp8crezu.fsf@deeprootsystems.com>
References: <20150312183020.GU8656@n2100.arm.linux.org.uk>
	<E1YWSMv-0006Fx-E6@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:40941 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751415AbbCMRUZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 13 Mar 2015 13:20:25 -0400
Received: by padfb1 with SMTP id fb1so30966705pad.7
        for <linux-pm@vger.kernel.org>; Fri, 13 Mar 2015 10:20:24 -0700 (PDT)
In-Reply-To: <E1YWSMv-0006Fx-E6@rmk-PC.arm.linux.org.uk> (Russell King's
	message of "Fri, 13 Mar 2015 16:23:25 +0000")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, linux-arm-kernel@lists.infradead.org, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org

Russell King <rmk+kernel@arm.linux.org.uk> writes:

> The PM domain code contains two methods to get the generic PM domain
> for a struct device.  One is dev_to_genpd() which is only safe when
> we know for certain that the device has a generic PM domain attached.
> The other is coded into genpd_dev_pm_detach() which ensures that the
> PM domain in the struct device is a generic PM domain (and so is safer).
>
> This commit factors out the safer version and documents it.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Kevin Hilman <khilman@linaro.org>

On top of this, I assume you're thinking that the externally available
dev_to_genpd() should probably be replaced by pm_genpd_lookup_dev(), and
dev_to_genpd() should only be used internally to genpd?

Kevin
