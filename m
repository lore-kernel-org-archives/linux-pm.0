From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [BUG] Device unbound in a resumed state
Date: Fri, 11 Mar 2016 16:08:25 +0900
Message-ID: <56E26EE9.8040400@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.w1.samsung.com ([210.118.77.13]:63969 "EHLO
	mailout3.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932075AbcCKHIc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 11 Mar 2016 02:08:32 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>

Hi,


Could be related (the same?) with [0].

I have a driver (hwrng/exynos-rng) which in probe does:
pm_runtime_set_autosuspend_delay(&pdev->dev, EXYNOS_AUTOSUSPEND_DELAY);
pm_runtime_use_autosuspend(&pdev->dev);
pm_runtime_enable(&pdev->dev);

and in remove:
pm_runtime_disable(&pdev->dev)

Just before unbinding in __device_release_driver() the device is resumed
but unfortunately not suspended later. I mean the
__device_release_driver()->pm_runtime_put_sync() does not trigger
runtime suspend.

This leads to leaving the device in active state (e.g. clocks enabled).

It does not happen after removal of autosuspend. Also runtime suspend
happens after very fast unbind-bind.


Best regards,
Krzysztof

[0] PM regression with commit 5de85b9d57ab PM runtime re-init in v4.5-rc1
http://comments.gmane.org/gmane.linux.power-management.general/70690
