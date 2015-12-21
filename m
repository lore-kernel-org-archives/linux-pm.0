From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: Re: blackfin-cpufreq: How to mark cpu_set_cclk() as static?
Date: Mon, 21 Dec 2015 10:50:42 +0100
Message-ID: <5677CB72.8090504@users.sourceforge.net>
References: <5674598B.6020000@users.sourceforge.net>
 <20151219015926.GJ3946@ubuntu> <5675141F.2090803@users.sourceforge.net>
 <20151221031757.GA5532@ubuntu> <5677C452.8040307@users.sourceforge.net>
 <20151221092805.GD5532@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.17.12]:64088 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751030AbbLUJus (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 21 Dec 2015 04:50:48 -0500
In-Reply-To: <20151221092805.GD5532@ubuntu>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>

> Since you reported the issue, it will be good if you can send a patch
> for this as well.

I'm sorry if I become a bit picky for this implementation detail.

In which order would you prefer that the properties of the
function "cpu_set_cclk" will be improved?
* Should the linkage specifier be added on a separate source code line?
* Can this fix be combined with my previous update suggestion for
  the return type?

Regards,
Markus
