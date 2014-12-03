From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 11/26] cpu_cooling: propagate error returned by idr_alloc()
Date: Wed, 3 Dec 2014 10:06:37 +0530
Message-ID: <CAKohpomKi=iG68iZ+-uB6M0x4t1=GJ7JQyBkB_v=iMdq2zhPRA@mail.gmail.com>
References: <cover.1417167599.git.viresh.kumar@linaro.org>
	<1cfc99a9a641f2937a8ac95c6b784e3eee033b0c.1417167599.git.viresh.kumar@linaro.org>
	<20141202153531.GB2834@e104805>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f52.google.com ([209.85.218.52]:35402 "EHLO
	mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750860AbaLCEgi (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 2 Dec 2014 23:36:38 -0500
Received: by mail-oi0-f52.google.com with SMTP id h136so10084377oig.25
        for <linux-pm@vger.kernel.org>; Tue, 02 Dec 2014 20:36:37 -0800 (PST)
In-Reply-To: <20141202153531.GB2834@e104805>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Javi Merino <javi.merino@arm.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "edubezval@gmail.com" <edubezval@gmail.com>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "rui.zhang@intel.com" <rui.zhang@intel.com>

On 2 December 2014 at 21:05, Javi Merino <javi.merino@arm.com> wrote:
> The error is ret, not the id which is probably 0 if there was an
> error. So:
>
> +               return ERR_PTR(ret);

Where should I hide my face, shameful mistake :(
