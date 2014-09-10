From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCHv2 2/4] cpufreq: cpufreq-dt: extend with platform_data
Date: Wed, 10 Sep 2014 17:52:59 +0530
Message-ID: <CAKohpokH4ZoM=+i3wW73o_Xf26ysBaXbNNzGUB0ofcc0EkK3WA@mail.gmail.com>
References: <CAKohpo=GiQHJ5eg=TkYAkzvsn=hTNTjSwmH20vitG2Z42zsoDA@mail.gmail.com>
	<1410350908-11316-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<1410350908-11316-3-git-send-email-thomas.petazzoni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f45.google.com ([209.85.218.45]:49212 "EHLO
	mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751004AbaIJMW7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 10 Sep 2014 08:22:59 -0400
Received: by mail-oi0-f45.google.com with SMTP id v63so1389979oia.32
        for <linux-pm@vger.kernel.org>; Wed, 10 Sep 2014 05:22:59 -0700 (PDT)
In-Reply-To: <1410350908-11316-3-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Shawn Guo <shawn.guo@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Sachin Kamat <spk.linux@gmail.com>, Thomas Abraham <thomas.ab@samsung.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, "pramod.gurav@smartplayin.com" <pramod.gurav@smartplayin.com>, Rob Herring <rob.herring@linaro.org>, Mike Turquette <mike.turquette@linaro.org>, Gregory Clement <gregory.clement@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>

On 10 September 2014 17:38, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:
> +       dt_cpufreq_driver.driver_data = dev_get_platdata(&pdev->dev);

I don't think this is right. What if platform device's platform data
is freed later?
That's why its always better to duplicate that structure instead of playing with
pointers.
