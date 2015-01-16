From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [vireshk:cpufreq/core/locking 57/60] drivers/cpufreq/cpufreq.c:512:5:
 sparse: symbol '__cpufreq_boost_supported' was not declared. Should it be static?
Date: Fri, 16 Jan 2015 12:35:57 +0530
Message-ID: <CAKohpon55ycK+BeUK4KPFuiWbZb39S_4xc9G8fDtXwM4LuGHJw@mail.gmail.com>
References: <201501161410.qF6rUO8n%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f175.google.com ([209.85.214.175]:51422 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751370AbbAPHF6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 16 Jan 2015 02:05:58 -0500
Received: by mail-ob0-f175.google.com with SMTP id va8so13315557obc.6
        for <linux-pm@vger.kernel.org>; Thu, 15 Jan 2015 23:05:57 -0800 (PST)
In-Reply-To: <201501161410.qF6rUO8n%fengguang.wu@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: kbuild test robot <fengguang.wu@intel.com>
Cc: kbuild-all@01.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 16 January 2015 at 12:25, kbuild test robot <fengguang.wu@intel.com> wrote:
> tree:   https://git.linaro.org/people/vireshk/linux cpufreq/core/locking
> head:   12d5339e685739289c2f629c943b8bfad4c64f1e
> commit: fbce49b78afdaeeaee3017cfbd968e44ddba8496 [57/60] cpufreq: Drop forward declaration of __cpufreq_boost_trigger_state()
> reproduce:
>   # apt-get install sparse
>   git checkout fbce49b78afdaeeaee3017cfbd968e44ddba8496
>   make ARCH=x86_64 allmodconfig
>   make C=1 CF=-D__CHECK_ENDIAN__
>
>
> sparse warnings: (new ones prefixed by >>)
>
>>> drivers/cpufreq/cpufreq.c:512:5: sparse: symbol '__cpufreq_boost_supported' was not declared. Should it be static?
>
> Please review and possibly fold the followup patch.

Fixed. Thanks.
