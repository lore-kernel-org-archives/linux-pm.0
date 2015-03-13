From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH 01/10] pm: domains: quieten down generic pm domains
Date: Fri, 13 Mar 2015 10:10:56 -0700
Message-ID: <7hy4n0rffj.fsf@deeprootsystems.com>
References: <20150312183020.GU8656@n2100.arm.linux.org.uk>
	<E1YWSMq-0006Ft-9z@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174]:39277 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753109AbbCMRLI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 13 Mar 2015 13:11:08 -0400
Received: by pdbft15 with SMTP id ft15so30258373pdb.6
        for <linux-pm@vger.kernel.org>; Fri, 13 Mar 2015 10:11:08 -0700 (PDT)
In-Reply-To: <E1YWSMq-0006Ft-9z@rmk-PC.arm.linux.org.uk> (Russell King's
	message of "Fri, 13 Mar 2015 16:23:20 +0000")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, linux-arm-kernel@lists.infradead.org, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org

Russell King <rmk+kernel@arm.linux.org.uk> writes:

> PM domains are rather noisy; scheduling behaviour can cause callbacks
> to take longer, which causes them to spit out a warning-level message
> each time a callback takes a little longer than the previous time.
> There really isn't a need for this, except when debugging.
>
> Acked-by: Rafael J. Wysocki <rjw@rjwysocki.net>
> Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Kevin Hilman <khilman@linaro.org>
