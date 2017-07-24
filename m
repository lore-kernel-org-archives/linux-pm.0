From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v4] PM / suspend: Export pm_suspend_target_state
Date: Mon, 24 Jul 2017 22:55:32 +0200
Message-ID: <6617312.jcY15JS4JA@aspire.rjw.lan>
References: <20170717221059.6523-1-f.fainelli@gmail.com> <20170718001925.25286-1-f.fainelli@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:55662 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753375AbdGXVDa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Jul 2017 17:03:30 -0400
In-Reply-To: <20170718001925.25286-1-f.fainelli@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: linux-kernel@vger.kernel.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm <linux-pm@vger.kernel.org>, Thibaud Cornic <thibaud_cornic@sigmadesigns.com>, JB <jb_lescher@sigmadesigns.com>, Mason <slash.tmp@free.fr>, Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>, Linux ARM <linux-arm-kernel@lists.infradead.org>

On Monday, July 17, 2017 05:19:25 PM Florian Fainelli wrote:
> Have the core suspend/resume framework store the system-wide suspend
> state (suspend_state_t) we are about to enter, and expose it to drivers
> via pm_suspend_target_state in order to retrieve that. The state is
> assigned in suspend_devices_and_enter().
> 
> This is useful for platform specific drivers that may need to take a
> slightly different suspend/resume path based on the system's
> suspend/resume state being entered.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
> Changes in v4:
> - clear pm_suspend_target_state in Close label
> 
> Changes in v3:
> 
> - just export pm_suspend_target_state without a helper function
> 
> Changes in v2:
> 
> - rename platform_suspend_target_state() -> suspend_target_state()
> - directly export the suspend_state_t value and assign it in
>   suspend_devices_and_enter()

Applied, thanks!
