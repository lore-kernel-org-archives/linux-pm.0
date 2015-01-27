From: Paul Bolle <pebolle@tiscali.nl>
Subject: thermal: exynos: Remove CONFIG_EXYNOS_THERMAL_CORE?
Date: Tue, 27 Jan 2015 10:56:45 +0100
Message-ID: <1422352605.14015.28.camel@x220>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cpsmtpb-ews01.kpnxchange.com ([213.75.39.4]:57391 "EHLO
	cpsmtpb-ews01.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754503AbbA0J4t (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 27 Jan 2015 04:56:49 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lukasz Majewski <l.majewski@samsung.com>
Cc: Valentin Rothberg <valentinrothberg@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Lukasz,

Your commit 1fd2273f966a ("thermal: exynos: Remove
exynos_thermal_common.[c|h] files") is included in today's linux-next
(ie, next-20150127). I noticed because a script I use to check
linux-next spotted a minor problem with it.

It removed the last users of CONFIG_EXYNOS_THERMAL_CORE. As a result
setting the Kconfig symbol EXYNOS_THERMAL_CORE has no effect anymore. Is
the trivial patch to remove that symbol's entry from
drivers/thermal/samsung/Kconfig queued somewhere?


Paul Bolle

