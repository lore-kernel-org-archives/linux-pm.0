From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] PM / Runtime: fix autosuspend documentation
Date: Mon, 10 Apr 2017 09:35:05 -0700
Message-ID: <20170410163504.GF5339@atomide.com>
References: <20170410113825.17399-1-johan@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:43922 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751434AbdDJQfJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 10 Apr 2017 12:35:09 -0400
Content-Disposition: inline
In-Reply-To: <20170410113825.17399-1-johan@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Johan Hovold <johan@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Alan Stern <stern@rowland.harvard.edu>, Kevin Hilman <khilman@baylibre.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

* Johan Hovold <johan@kernel.org> [170410 04:41]:
> Update the autosuspend documentation which claimed that the autosuspend
> delay is not taken into account when using the non-autosuspend helper
> functions, something which is no longer true since commit d66e6db28df3
> ("PM / Runtime: Respect autosuspend when idle triggers suspend").
> 
> This specifically means that drivers must now disable autosuspend before
> disabling runtime pm in probe error paths and remove callbacks if
> pm_runtime_put_sync was being used to suspend the device before
> returning. (If an idle callback can prevent suspend,
> pm_runtime_put_sync_suspend must be used instead of pm_runtime_put_sync
> as before.)
> 
> Also remove the claim that the autosuspend helpers behave "just like
> the non-autosuspend counterparts", something which have never really
> been true as some of the latter use idle notifications.
> 
> Signed-off-by: Johan Hovold <johan@kernel.org>

Acked-by: Tony Lindgren <tony@atomide.com>
