From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH] PM / Domains: Fix typo in description of genpd_dev_pm_detach()
Date: Fri, 28 Aug 2015 10:33:36 -0700
Message-ID: <7hfv3348sv.fsf@deeprootsystems.com>
References: <1440667020-8833-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:35031 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752594AbbH1Rdi (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 28 Aug 2015 13:33:38 -0400
Received: by pacdd16 with SMTP id dd16so69027931pac.2
        for <linux-pm@vger.kernel.org>; Fri, 28 Aug 2015 10:33:38 -0700 (PDT)
In-Reply-To: <1440667020-8833-1-git-send-email-jonathanh@nvidia.com> (Jon
	Hunter's message of "Thu, 27 Aug 2015 10:17:00 +0100")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jon Hunter <jonathanh@nvidia.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org

Jon Hunter <jonathanh@nvidia.com> writes:

> The function genpd_dev_pm_detach() detaches a device from a PM domain,
> however, in the description, the "dev" argument for the function is
> described as the device to "attach" instead of "detach". Correct this.
>
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>

Acked-by: Kevin Hilman <khilman@linaro.org>
