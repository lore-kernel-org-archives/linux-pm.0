From: Lukasz Majewski <l.majewski@samsung.com>
Subject: Re: thermal: exynos: Remove CONFIG_EXYNOS_THERMAL_CORE?
Date: Tue, 27 Jan 2015 11:09:48 +0100
Message-ID: <20150127110948.06a70f1c@amdc2363>
References: <1422352605.14015.28.camel@x220>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:12272 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753338AbbA0KJz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 27 Jan 2015 05:09:55 -0500
In-reply-to: <1422352605.14015.28.camel@x220>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Paul Bolle <pebolle@tiscali.nl>
Cc: Valentin Rothberg <valentinrothberg@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Paul,

> Lukasz,
> 
> Your commit 1fd2273f966a ("thermal: exynos: Remove
> exynos_thermal_common.[c|h] files") is included in today's linux-next
> (ie, next-20150127). I noticed because a script I use to check
> linux-next spotted a minor problem with it.
> 
> It removed the last users of CONFIG_EXYNOS_THERMAL_CORE. As a result
> setting the Kconfig symbol EXYNOS_THERMAL_CORE has no effect anymore.
> Is the trivial patch to remove that symbol's entry from
> drivers/thermal/samsung/Kconfig queued somewhere?

I will prepare appropriate patch and send it ASAP.

Thanks for hint.

> 
> 
> Paul Bolle
> 



-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
