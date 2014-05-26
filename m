From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V4 2/3] cpufreq: add support for intermediate (stable) frequencies
Date: Mon, 26 May 2014 09:31:32 +0530
Message-ID: <CAKohpomz5_Q=68QP7+-qbSrp-uSgSDD2ptmTnQdxASVO8jhDuw@mail.gmail.com>
References: <cover.1400662383.git.viresh.kumar@linaro.org>
	<59e1185a31e61c428aca9f4b8f0a69f182ee458e.1400662383.git.viresh.kumar@linaro.org>
	<537E27DA.9040709@wwwdotorg.org>
	<CAKohpokhiTpTd-ByFUuOL1hR7MnKPPQj-peH7S5oFxowKt0BeQ@mail.gmail.com>
	<537F6F94.7040900@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f44.google.com ([209.85.219.44]:48501 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750707AbaEZEBd (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 26 May 2014 00:01:33 -0400
Received: by mail-oa0-f44.google.com with SMTP id o6so7827336oag.3
        for <linux-pm@vger.kernel.org>; Sun, 25 May 2014 21:01:32 -0700 (PDT)
In-Reply-To: <537F6F94.7040900@wwwdotorg.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arvind Chauhan <arvind.chauhan@arm.com>, Stephen Warren <swarren@nvidia.com>, Doug Anderson <dianders@chromium.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Nicolas Pitre <nicolas.pitre@linaro.org>, Thomas Abraham <thomas.abraham@linaro.org>, Peter De Schrijver <pdeschrijver@nvidia.com>

On 23 May 2014 21:26, Stephen Warren <swarren@wwwdotorg.org> wrote:
> Oh OK, I guess the "notify" value is static then, and driver defined, so
> this is fine.

Correct!! Can you reply on the tegra patch also? So that we can close this
thread ASAP?
