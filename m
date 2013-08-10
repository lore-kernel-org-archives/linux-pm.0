From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 35/35] cpufreq: tegra: use cpufreq_table_validate_and_show()
Date: Sat, 10 Aug 2013 08:23:02 +0530
Message-ID: <CAKohpon=j=NANLQzYuBdoFVLxQzETy5JDu2vORaAgK3NuEpeAg@mail.gmail.com>
References: <cover.1375964117.git.viresh.kumar@linaro.org>
	<568f3dbd414b050bb2319d960fb5044a5aed8ee3.1375964117.git.viresh.kumar@linaro.org>
	<5203BCDD.40809@wwwdotorg.org>
	<CAKohpomr8kwDitAFD7FKvHo3zNWz8qT5bkd3yOVEnC_k16o=Dw@mail.gmail.com>
	<CAKohpo=Gy7D2LYmdFU1p+eL-nMoPE18YXWvE2M8t-fb-a5HBgg@mail.gmail.com>
	<5205167F.1070906@wwwdotorg.org>
	<CAKohponQDAqHiRD7Aw5Wk6fEE-d8H=Svg0oBRyb9SKGdqYxGhw@mail.gmail.com>
	<52056842.8060109@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qc0-f181.google.com ([209.85.216.181]:63288 "EHLO
	mail-qc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031820Ab3HJCxE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 9 Aug 2013 22:53:04 -0400
Received: by mail-qc0-f181.google.com with SMTP id k15so2535659qcv.40
        for <linux-pm@vger.kernel.org>; Fri, 09 Aug 2013 19:53:02 -0700 (PDT)
In-Reply-To: <52056842.8060109@wwwdotorg.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: linaro-kernel@lists.linaro.org, Stephen Warren <swarren@nvidia.com>, linux-pm@vger.kernel.org, patches@linaro.org, linux-kernel@vger.kernel.org, cpufreq@vger.kernel.org, rjw@sisk.pl, linux-arm-kernel@lists.infradead.org

On 10 August 2013 03:38, Stephen Warren <swarren@wwwdotorg.org> wrote:
> Well, I don't see any issues running this, although the cpufreq sysfs
> files seem to have disappeared on Tegra, even without your changes, so
> I'm not sure how to really verify cpufreq.
>
> Did the sysfs files go away, or do I need to investigate why/when the
> disappeared?

It wasn't enabled by default in your defconfig... So enable it first with
your menuconfig.
