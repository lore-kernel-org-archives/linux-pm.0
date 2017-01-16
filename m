From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 0/4] selftest: cpufreq: Add support for cpufreq framework
Date: Mon, 16 Jan 2017 09:18:15 +0530
Message-ID: <20170116034815.GJ9953@vireshk-i7>
References: <cover.1484289212.git.viresh.kumar@linaro.org>
 <bde954c8-d581-aa9d-a64d-2ca94e794f2f@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f41.google.com ([74.125.83.41]:36481 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750808AbdAPDsT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 15 Jan 2017 22:48:19 -0500
Received: by mail-pg0-f41.google.com with SMTP id t6so6385359pgt.3
        for <linux-pm@vger.kernel.org>; Sun, 15 Jan 2017 19:48:19 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <bde954c8-d581-aa9d-a64d-2ca94e794f2f@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Shuah Khan <shuah@kernel.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, linux-kselftest@vger.kernel.org

On 13-01-17, 15:35, Shuah Khan wrote:
> Could you please add .gitignore for generated files. You can
> send that as a separate patch and don't have to resend the
> series.

Hi Shuah,

> >  tools/testing/selftests/Makefile                 |   1 +
> >  tools/testing/selftests/cpufreq/Makefile         |   8 +
> >  tools/testing/selftests/cpufreq/cpu.sh           |  84 ++++++++
> >  tools/testing/selftests/cpufreq/cpufreq.sh       | 241 ++++++++++++++++++++++
> >  tools/testing/selftests/cpufreq/governor.sh      | 153 ++++++++++++++
> >  tools/testing/selftests/cpufreq/main.sh          | 194 ++++++++++++++++++
> >  tools/testing/selftests/cpufreq/module.sh        | 243 +++++++++++++++++++++++
> >  tools/testing/selftests/cpufreq/special-tests.sh | 115 +++++++++++

All I have are .sh files and no intermediate files are generated.
Perhaps I don't need any .gitignore entries ?

-- 
viresh
