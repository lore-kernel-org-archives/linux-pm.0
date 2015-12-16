From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: Re: [PATCH] i2c: s3c2410: remove superfluous runtime PM calls
Date: Wed, 16 Dec 2015 14:53:07 +0100
Message-ID: <56716CC3.50309@samsung.com>
References: <1450203249-4873-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.w1.samsung.com ([210.118.77.14]:10773 "EHLO
	mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753642AbbLPNzK (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 16 Dec 2015 08:55:10 -0500
In-reply-to: <1450203249-4873-1-git-send-email-wsa@the-dreams.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-pm@vger.kernel.org, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Lars-Peter Clausen <lars@metafoo.de>, Krzysztof Kozlowski <k.kozlowski@samsung.com>

On 15/12/15 19:14, Wolfram Sang wrote:
> Since commit 6ada5c1e1b077a ("i2c: Mark adapter devices with
> pm_runtime_no_callbacks"), runtime PM on adapters turned into a no-op.
> So, we can remove these calls.

Won't this break i2c client devices that use runtime PM? Not sure
if any cases of such client exist now, I'll try to find some time
to test this change.

IIRC client's pm_runtime* calls return error if their parent device's
runtime PM is not enabled. Also enabling runtime PM on the i2c adapter
allows propagating runtime PM calls up to its parent - the i2c
controller platform device.

So perhaps in your patch we should only remove pm_runtime_get_sync,
pm_runtime_put calls, leaving runtime PM on the adapter enabled.
For any future cases where the Exynos I2C controller is not in an
always on power domain the runtime PM handling in this driver would
need to be further reworked anyway.

Perhaps we could just enable/disable adapter's runtime PM in i2c core.

--
Thanks,
Sylwester


