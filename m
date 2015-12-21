From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/2] blackfin-cpufreq: Fine-tuning for properties of one
 function
Date: Mon, 21 Dec 2015 22:28:19 +0100
Message-ID: <56786EF3.3070203@users.sourceforge.net>
References: <5674598B.6020000@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.17.11]:55999 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751424AbbLUV2Z (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 21 Dec 2015 16:28:25 -0500
In-Reply-To: <5674598B.6020000@users.sourceforge.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 21 Dec 2015 22:24:18 +0100

Another update suggestion was taken into account after a patch was applied
from static source code analysis.

Markus Elfring (2):
  Change return type of cpu_set_cclk() to that of clk_set_rate()
  Mark cpu_set_cclk() as static

 drivers/cpufreq/blackfin-cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.6.3

