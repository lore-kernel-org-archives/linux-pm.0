From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 00/26] thermal: cpu_cooling: Fixes and cleanups
Date: Tue, 9 Dec 2014 07:17:27 +0530
Message-ID: <CAKohpon0YdJUgF1gBoCDo+jULtB-f5QYgt1H9vX9NeEZ9Y+68g@mail.gmail.com>
References: <cover.1417664938.git.viresh.kumar@linaro.org>
	<20141208200150.GA13589@developer>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f176.google.com ([209.85.214.176]:43146 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755469AbaLIBr2 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 8 Dec 2014 20:47:28 -0500
Received: by mail-ob0-f176.google.com with SMTP id vb8so4591544obc.21
        for <linux-pm@vger.kernel.org>; Mon, 08 Dec 2014 17:47:27 -0800 (PST)
In-Reply-To: <20141208200150.GA13589@developer>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Zhang Rui <rui.zhang@intel.com>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Javi Merino <javi.merino@arm.com>, Chanwoo Choi <cw00.choi@samsung.com>, Hongbo Zhang <hongbo.zhang@linaro.com>, Kyungmin Park <kyungmin.park@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>, Shawn Guo <shawn.guo@linaro.org>

On 9 December 2014 at 01:31, Eduardo Valentin <edubezval@gmail.com> wrote:
> The series is good to me. The comments in the list regarding kerneldoc I
> ammended myself. I also tested them and could not spot any problems. For
> this reason, I will be attempting to send this series in a second round
> for 3.19.
>
> However, this series depend on your rework in cpufreq side. Is that
> going in for 3.19?

Yes it will. https://lkml.org/lkml/2014/12/8/704
