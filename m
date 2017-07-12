From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] selftests: cpufreq: Check cpuinfo_cur_freq set as expected
Date: Wed, 12 Jul 2017 13:36:05 +0200
Message-ID: <CAJZ5v0g5Chq-zw0tN6Mvp2YD2WKavUMp37UtAoFPLW3yiX4F1w@mail.gmail.com>
References: <704cfb6696840b3838576ea583b8ab8ed2265aaf.1499858779.git.leonard.crestez@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f172.google.com ([209.85.223.172]:36697 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756633AbdGLLgM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Jul 2017 07:36:12 -0400
In-Reply-To: <704cfb6696840b3838576ea583b8ab8ed2265aaf.1499858779.git.leonard.crestez@nxp.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Leonard Crestez <leonard.crestez@nxp.com>
Cc: Shuah Khan <shuah@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, linux-kselftest@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Octavian Purdila <octavian.purdila@nxp.com>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Wed, Jul 12, 2017 at 1:29 PM, Leonard Crestez
<leonard.crestez@nxp.com> wrote:
> This checks that the cpufreq driver actually sets the requested
> frequency.

This won't work on modern x86  with APERF/MPERF (see recent commits in
that area).

Thanks,
Rafael
