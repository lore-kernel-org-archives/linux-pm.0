From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/1] cpufreq: exynos: Fix line over 80 characters warning
Date: Thu, 21 Nov 2013 01:54:33 +0100
Message-ID: <6133597.QYzlQUus4P@vostro.rjw.lan>
References: <1384837639-9252-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:55542 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754715Ab3KUAly (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 20 Nov 2013 19:41:54 -0500
In-Reply-To: <1384837639-9252-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-pm@vger.kernel.org, cpufreq@vger.kernel.org, viresh.kumar@linaro.org, Jonghwan Choi <jhbird.choi@samsung.com>

On Tuesday, November 19, 2013 10:37:19 AM Sachin Kamat wrote:
> Silences the checkpatch warning introduced by
> commit 94aa44090eda ("cpufreq: exynos: Add missing static").
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Jonghwan Choi <jhbird.choi@samsung.com>

I'm not going to apply this and seriously if you care, please modify
checkpatch.pl to stop emitting that warning.  It is silly and useless in
my opinion, so I won't take any patches "fixing" it.

Thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
