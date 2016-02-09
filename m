From: Mason <slash.tmp@free.fr>
Subject: Re: [PATCH RFC] Add cpufreq support
Date: Tue, 9 Feb 2016 11:17:48 +0100
Message-ID: <56B9BCCC.8060404@free.fr>
References: <56B4D4BE.2040008@free.fr> <22002072.L04zy0K2AP@wuerfel>
 <20160208131625.GI8294@vireshk> <7910928.pmJjZiV1Lk@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp2-g21.free.fr ([212.27.42.2]:15776 "EHLO smtp2-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756214AbcBIKRy (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 9 Feb 2016 05:17:54 -0500
In-Reply-To: <7910928.pmJjZiV1Lk@wuerfel>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-pm <linux-pm@vger.kernel.org>

On 08/02/2016 14:45, Arnd Bergmann wrote:

> That's why I said we could introduce a 'v3' with the meaning
> it should have had to start with: compatible means actually
> compatible with the driver.

If I understand correctly, something needs to change in the
framework before I can push cpufreq support for my platform
upstream, correct?

Could you CC me if anything happens on that front?

In my local 4.4 branch, I think I should use whatever method
was recommended at the time.

Was that to define the platform's init_late method, and call
platform_device_register_simple from there? (Could you take
a quick glance at the patch, and see if it is acceptable in
the context of kernel 4.4?)

Regards.

