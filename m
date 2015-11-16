From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] cpufreq: do not mark s3c2410_plls_add as __init
Date: Mon, 16 Nov 2015 23:17:35 +0100
Message-ID: <4389196.cuM78vZZnJ@wuerfel>
References: <8497197.sYxqVOch7s@wuerfel> <28389377.zxoR5rtJ13@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:53609 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751151AbbKPWSM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 16 Nov 2015 17:18:12 -0500
In-Reply-To: <28389377.zxoR5rtJ13@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Viresh Kumar <viresh.kumar@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On Monday 16 November 2015 23:36:42 Rafael J. Wysocki wrote:
> 
> This should go in through the Samsung tree, so I'll leave it for them to pick
> it up (at least for the time being).

Ok, fair enough. Kukjin or Krzysztof, can you pick this up?

	Arnd
