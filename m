From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] PM / Runtime: Respect autosuspend when idle triggers
 suspend
Date: Fri, 11 Oct 2013 10:28:00 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1310111027170.1052-100000@iolanthe.rowland.org>
References: <1381483420-18864-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:47540 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755594Ab3JKO2B (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 11 Oct 2013 10:28:01 -0400
In-Reply-To: <1381483420-18864-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Kevin Hilman <khilman@linaro.org>, Rob Landley <rob@landley.net>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org

On Fri, 11 Oct 2013, Ulf Hansson wrote:

> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -258,7 +258,9 @@ static int __rpm_callback(int (*cb)(struct device *), struct device *dev)
>   * Check if the device's runtime PM status allows it to be suspended.  If
>   * another idle notification has been started earlier, return immediately.  If
>   * the RPM_ASYNC flag is set then queue an idle-notification request; otherwise
> - * run the ->runtime_idle() callback directly.
> + * run the ->runtime_idle() callback directly. If the ->runtime_idle callback
> + * does'nt exist or if it returns 0, run rpm_suspend with RPM_AUTO flag to

s/does'nt/doesn't/

Alan Stern

