From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq-dt: register cooling device after validating
 cpufreq table
Date: Wed, 26 Nov 2014 09:00:17 +0530
Message-ID: <CAKohponNuLi8=h9u0MXBJfXKVoF4GHHxW=v502a5nFdCYs7gcg@mail.gmail.com>
References: <b4a56cad08c5ef701cf268881697caabe5229994.1416826729.git.viresh.kumar@linaro.org>
	<2189780.D9n5NYrXn8@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f53.google.com ([209.85.218.53]:59591 "EHLO
	mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750938AbaKZDaS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 25 Nov 2014 22:30:18 -0500
Received: by mail-oi0-f53.google.com with SMTP id x69so1425594oia.40
        for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2014 19:30:18 -0800 (PST)
In-Reply-To: <2189780.D9n5NYrXn8@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Lukasz Majewski <l.majewski@samsung.com>, Eduardo Valentin <edubezval@gmail.com>

On 26 November 2014 at 03:19, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> Plus "stable" I suppose?  Which ones?

I haven't put stable tags intentionally as the driver was updated/renamed in
3.18 and whatever patch we produce wouldn't get applied to any stable.

So, if we want to fix this problem in 'stable' then we have to write another
similar patch..
