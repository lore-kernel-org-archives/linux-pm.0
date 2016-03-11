From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [BUG] Device unbound in a resumed state
Date: Fri, 11 Mar 2016 13:46:12 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1603111336100.1840-100000@iolanthe.rowland.org>
References: <56E26EE9.8040400@samsung.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56E26EE9.8040400@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 11 Mar 2016, Krzysztof Kozlowski wrote:

> Hi,
> 
> 
> Could be related (the same?) with [0].
> 
> I have a driver (hwrng/exynos-rng) which in probe does:
> pm_runtime_set_autosuspend_delay(&pdev->dev, EXYNOS_AUTOSUSPEND_DELAY);
> pm_runtime_use_autosuspend(&pdev->dev);
> pm_runtime_enable(&pdev->dev);
> 
> and in remove:
> pm_runtime_disable(&pdev->dev)

But not pm_runtime_dont_use_autosuspend()?

Why disable runtime PM if you want the runtime-PM methods to put the 
device into a low-power state?

> Just before unbinding in __device_release_driver() the device is resumed
> but unfortunately not suspended later. I mean the
> __device_release_driver()->pm_runtime_put_sync() does not trigger
> runtime suspend.

Because autosuspend is still in use at this point.

> This leads to leaving the device in active state (e.g. clocks enabled).
> 
> It does not happen after removal of autosuspend. Also runtime suspend
> happens after very fast unbind-bind.

Overall it sounds like the system is behaving the way it is supposed 
to.

But maybe we should make pm_runtime_use_autosuspend() call
pm_runtime_mark_last_busy(), to avoid the unbind - bind - immediate
autosuspend behavior.

Alan Stern
