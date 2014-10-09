From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: Add sfi based cpufreq driver support
Date: Thu, 9 Oct 2014 15:48:08 +0530
Message-ID: <CAKohpok9d4AK4qmERqtnGYBtZx=wnP5fdECOT6t1NFEGfAQ_2g@mail.gmail.com>
References: <20141007140734.GB24200@intel-desktop>
	<CAKohpokLcZPcMUjXYNNxDcwHUzsL1ejYBYd0cDmnAHQu+cBYGA@mail.gmail.com>
	<20141008191454.GA6504@intel-desktop>
	<CAKohpom+Ey75QStm_xsVeC7arN_5a3+q_Nf8pvadTxNaLBKCEw@mail.gmail.com>
	<20141009180826.GA32265@intel-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f49.google.com ([209.85.218.49]:56647 "EHLO
	mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751326AbaJIKSJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 9 Oct 2014 06:18:09 -0400
Received: by mail-oi0-f49.google.com with SMTP id a3so1952731oib.22
        for <linux-pm@vger.kernel.org>; Thu, 09 Oct 2014 03:18:08 -0700 (PDT)
In-Reply-To: <20141009180826.GA32265@intel-desktop>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Kasagar, Srinidhi" <srinidhi.kasagar@intel.com>
Cc: Dirk Brandewie <dirk.j.brandewie@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, vishwesh.m.rudramuni@intel.com

On 9 October 2014 23:38, Kasagar, Srinidhi <srinidhi.kasagar@intel.com> wrote:
> I guess if you offline a cpu and then bring it online, then even though
> there is no change in frequency, the core calls ->target_index().

No.

> am i missing something?

Yes.
