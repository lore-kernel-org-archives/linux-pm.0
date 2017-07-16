From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/2] PM / suspend: Add platform_suspend_target_state()
Date: Sun, 16 Jul 2017 12:30:55 +0200
Message-ID: <1787546.EYh03heFAd@aspire.rjw.lan>
References: <20170623010837.11199-1-f.fainelli@gmail.com> <20170716023610.4658-1-f.fainelli@gmail.com> <20170716023610.4658-2-f.fainelli@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:50102 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751048AbdGPKin (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 16 Jul 2017 06:38:43 -0400
In-Reply-To: <20170716023610.4658-2-f.fainelli@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: linux-kernel@vger.kernel.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm <linux-pm@vger.kernel.org>, Thibaud Cornic <thibaud_cornic@sigmadesigns.com>, JB <jb_lescher@sigmadesigns.com>, Mason <slash.tmp@free.fr>, Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>, Linux ARM <linux-arm-kernel@lists.infradead.org>

On Saturday, July 15, 2017 07:36:09 PM Florian Fainelli wrote:
> Add an optional platform_suspend_ops callback: target_state, and a
> helper function globally visible to get this called:
> platform_suspend_target_state().
> 
> This is useful for platform specific drivers that may need to take a
> slightly different suspend/resume path based on the system's
> suspend/resume state being entered.
> 
> Although this callback is optional and documented as such, it requires
> a platform_suspend_ops::begin callback to be implemented in order to
> provide an accurate suspend/resume state within the driver that
> implements this platform_suspend_ops.
> 
> An enumeration: platform_target_state is defined which currently defines
> the standard ACPI_S[1-4] states and can be extended with platform
> specific suspend states.

This has a couple of problems, but I'm not sure if it is worth to go too much
into details here.

Let's just take a different approach as I said in the other thread.

Thanks,
Rafael
