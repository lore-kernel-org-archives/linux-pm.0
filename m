From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH 2/9] pm: domains: avoid potential oops in pm_genpd_remove_device()
Date: Fri, 13 Mar 2015 09:33:14 -0700
Message-ID: <7h1tksx3g5.fsf@deeprootsystems.com>
References: <20150312183020.GU8656@n2100.arm.linux.org.uk>
	<E1YW7sq-0003m6-89@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:42884 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752804AbbCMQdS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 13 Mar 2015 12:33:18 -0400
Received: by padfa1 with SMTP id fa1so30667530pad.9
        for <linux-pm@vger.kernel.org>; Fri, 13 Mar 2015 09:33:17 -0700 (PDT)
In-Reply-To: <E1YW7sq-0003m6-89@rmk-PC.arm.linux.org.uk> (Russell King's
	message of "Thu, 12 Mar 2015 18:31:00 +0000")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org

Russell King <rmk+kernel@arm.linux.org.uk> writes:

> pm_genpd_remove_device() should only be called with valid and present
> pm domain.  

Terminology nit: the patch adds a check for a valid an present genpd,
not pm domain (which I think of as dev->pm_domain.)

> There are circumstances where we may end up with something
> that isn't a generic PM domain in dev->pm_domain (eg, vga_switcheroo
> stuff.)

Wouldn't that particular case be caught by this check in pm_genpd_remove_device():

        || pd_to_genpd(dev->pm_domain) != genpd

Maybe I'm not quite following your description, but it looks like
someone is trying to call pm_genpd_remove_device() on something that was
not added with pm_genpd_add_device().  Where/how is that happening?

Kevin

