From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/4] cpufreq: Add a cpufreq driver for Marvell Dove
Date: Tue, 29 Oct 2013 17:03:14 +0530
Message-ID: <CAKohponoxbV9P+0pWfEEi3sND7GbgHECsT=FRMCfeLcvOP9iDg@mail.gmail.com>
References: <1382533461-31021-1-git-send-email-andrew@lunn.ch>
	<CAKohpombg7mAmgxxvUg8kz1MaFwcycR1eL0UrgELY2WdGfrAag@mail.gmail.com>
	<20131023135116.GC31126@lunn.ch>
	<CAKohpokTgCz0c=PeaJHKiZEiYc0jPVq-vwkhP5pM0hh1-0QnLA@mail.gmail.com>
	<20131023143657.GA31536@lunn.ch>
	<CAKohpomedpd8XBPcdZX2vHy6b5=FMtbSVpNTG-eVLK1YPyPaMA@mail.gmail.com>
	<20131028113104.GE27015@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f178.google.com ([209.85.214.178]:40359 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752638Ab3J2LdP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 29 Oct 2013 07:33:15 -0400
Received: by mail-ob0-f178.google.com with SMTP id wm4so4980984obc.23
        for <linux-pm@vger.kernel.org>; Tue, 29 Oct 2013 04:33:14 -0700 (PDT)
In-Reply-To: <20131028113104.GE27015@lunn.ch>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, Jason Cooper <jason@lakedaemon.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux ARM <linux-arm-kernel@lists.infradead.org>

On 28 October 2013 17:01, Andrew Lunn <andrew@lunn.ch> wrote:
> I have tested this now. The dummy handler is required. Without it, it
> seems like the WFI exits at the next timer tick, not immediately once
> the cpufreq change has finished. I get poor numbers out of
> cpufreq-bench without the handler.

Ahh.. that helps.. You can now put exactly this stuff in the comment over
the handler..
