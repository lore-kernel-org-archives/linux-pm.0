From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] cpufreq: schedutil: Make default depend on CONFIG_SMP
Date: Wed, 11 May 2016 23:06:08 +0200
Message-ID: <CAJZ5v0i0jboUU+sPtC-dy72k3HZVrmxU_ZqnBiam_JBJ_RsUhg@mail.gmail.com>
References: <1462971135-613196-1-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:34255 "EHLO
	mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751682AbcEKVGK (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 11 May 2016 17:06:10 -0400
In-Reply-To: <1462971135-613196-1-git-send-email-arnd@arndb.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Wed, May 11, 2016 at 2:52 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> CPU_FREQ_GOV_SCHEDUTIL gained a dependency on SMP, so now we
> get a warning if it gets selected by CPU_FREQ_DEFAULT_GOV_SCHEDUTIL
> without SMP:
>
> warning: (CPU_FREQ_DEFAULT_GOV_SCHEDUTIL) selects CPU_FREQ_GOV_SCHEDUTIL which has unmet direct dependencies (CPU_FREQ && SMP)

Doh.

> This adds another dependency to avoid the problem.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: bf7cdff19429 ("cpufreq: schedutil: Make it depend on CONFIG_SMP")

Thanks, applied!
