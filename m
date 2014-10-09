From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: Add sfi based cpufreq driver support
Date: Thu, 9 Oct 2014 16:45:01 +0530
Message-ID: <CAKohponaW8i1as_w-cyrFoyY8PN7VwiRr=mE454Xhhe1C48mng@mail.gmail.com>
References: <20141007140734.GB24200@intel-desktop>
	<CAKohpokLcZPcMUjXYNNxDcwHUzsL1ejYBYd0cDmnAHQu+cBYGA@mail.gmail.com>
	<20141008191454.GA6504@intel-desktop>
	<CAKohpom+Ey75QStm_xsVeC7arN_5a3+q_Nf8pvadTxNaLBKCEw@mail.gmail.com>
	<20141009180826.GA32265@intel-desktop>
	<CAKohpok9d4AK4qmERqtnGYBtZx=wnP5fdECOT6t1NFEGfAQ_2g@mail.gmail.com>
	<20141009190747.GA31674@intel-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f51.google.com ([209.85.218.51]:42408 "EHLO
	mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754562AbaJILPC (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 9 Oct 2014 07:15:02 -0400
Received: by mail-oi0-f51.google.com with SMTP id h136so2069245oig.38
        for <linux-pm@vger.kernel.org>; Thu, 09 Oct 2014 04:15:01 -0700 (PDT)
In-Reply-To: <20141009190747.GA31674@intel-desktop>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Kasagar, Srinidhi" <srinidhi.kasagar@intel.com>
Cc: Dirk Brandewie <dirk.j.brandewie@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, vishwesh.m.rudramuni@intel.com

On 10 October 2014 00:37, Kasagar, Srinidhi <srinidhi.kasagar@intel.com> wrote:
> Hmm..I noticed later that I was doing cpumask_copy for my internal experiments.
> Even in that case, as you pointed, the ->target_index() was not called
> for the onlined CPU, but for the other related CPU.

But why is it getting called for even that ?
