From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH 1/9] pm: domains: quieten down generic pm domains
Date: Fri, 13 Mar 2015 08:57:30 -0700
Message-ID: <7hmw3gx53p.fsf@deeprootsystems.com>
References: <20150312183020.GU8656@n2100.arm.linux.org.uk>
	<E1YW7sl-0003m2-4Z@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179]:34476 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753488AbbCMP5e (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 13 Mar 2015 11:57:34 -0400
Received: by pdno5 with SMTP id o5so29909974pdn.1
        for <linux-pm@vger.kernel.org>; Fri, 13 Mar 2015 08:57:33 -0700 (PDT)
In-Reply-To: <E1YW7sl-0003m2-4Z@rmk-PC.arm.linux.org.uk> (Russell King's
	message of "Thu, 12 Mar 2015 18:30:55 +0000")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org

Russell King <rmk+kernel@arm.linux.org.uk> writes:

> PM domains are rather noisy; scheduling behaviour can cause callbacks
> to take longer, which causes them to spit out a warning-level message
> each time a callback takes a little longer than the previous time.
> There really isn't a need for this, except when debugging.
>
> Acked-by: Rafael J. Wysocki <rjw@rjwysocki.net>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Kevin Hilman <khilman@linaro.org>

We also take several timings even for callbacks that don't exist, and
I've got a forthcoming patch to clean that up as well.

Kevin

