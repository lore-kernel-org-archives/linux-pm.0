From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2] drivers/cpufreq: Convert non-modular s5pv210-cpufreq.c to use builtin_platform_driver
Date: Tue, 16 Jun 2015 01:50:28 +0200
Message-ID: <2052041.toNogcAkWs@vostro.rjw.lan>
References: <20150512070444.GE32300@linux> <1433365966-29850-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:57265 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751652AbbFOXYb (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 15 Jun 2015 19:24:31 -0400
In-Reply-To: <1433365966-29850-1-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Kukjin Kim <kgene@kernel.org>, linux-arm-kernel@lists.infradead.org

On Wednesday, June 03, 2015 05:12:46 PM Paul Gortmaker wrote:
> This file depends on a Kconfig option which is a bool, so
> we use the appropriate registration function, which avoids us
> relying on an implicit inclusion of <module.h> which we are
> doing currently.
> 
> While this currently works, we really don't want to be including
> the module.h header in non-modular code, which we'd be forced
> to do, pending some upcoming code relocation from init.h into
> module.h.  So we fix it now by using the non-modular equivalent.
> 
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: linux-pm@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

I'm assuming that this will go in via the Samsung tree.


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
