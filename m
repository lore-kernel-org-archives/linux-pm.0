From: =?UTF-8?Q?Krzysztof_Koz=C5=82owski?= <k.kozlowski.k@gmail.com>
Subject: Re: [RFC v3 0/7] genpd multiple states v3
Date: Tue, 21 Apr 2015 19:01:29 +0900
Message-ID: <CAJKOXPcvaAR2ZF=y2b2RLRW0CNE3ToWtzt4wYf6KNL7i_3TwNA@mail.gmail.com>
References: <1429542128-21021-1-git-send-email-ahaslam@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vn0-f44.google.com ([209.85.216.44]:40973 "EHLO
	mail-vn0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751688AbbDUKBa (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 21 Apr 2015 06:01:30 -0400
Received: by vnbg190 with SMTP id g190so32507231vnb.8
        for <linux-pm@vger.kernel.org>; Tue, 21 Apr 2015 03:01:30 -0700 (PDT)
In-Reply-To: <1429542128-21021-1-git-send-email-ahaslam@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: ahaslam@baylibre.com
Cc: ulf.hansson@linaro.org, khilman@linaro.org, rjw@rjwysocki.net, bcousson@baylibre.com, linux-pm@vger.kernel.org

2015-04-21 0:02 GMT+09:00  <ahaslam@baylibre.com>:
> From: Axel Haslam <ahaslam@baylibre.com>
>
> Some architectures may have intermediate power
> levels between on and off. each state in between
> may have its own set of procedures to put the
> power domain into that state.
>
> This patch adds the ability to declare multiple
> states for a given generic power domain, the idea
> is that the deepest state will be entered which
> does not violate any of the device or sub-domain
> latency constraints.
>
> Changes since v2:
> * remove state argument and macros from save/restore
> callbacks.
>
> * added init_state for platforms to pass the
> initial state when the genpd is initially off.
>
> * convert current genpd users for the structure changes.
>
> * compile tested for shmobile_defconfig, exynos_defconfig,
> s3c6400_defconfig u8500_defconfig.

Still the patch does not seem to be bisectable. Have you compiled each
config on each commit (not just beginning and end of patchset)?

Best regards,
Krzysztof
