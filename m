From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: Add sfi based cpufreq driver support
Date: Fri, 10 Oct 2014 14:27:17 +0530
Message-ID: <CAKohponh_1zBPZ9PxNACUZ-3WzPnbkpQCwmCmiTDEwGEW5D=Rg@mail.gmail.com>
References: <20141007140734.GB24200@intel-desktop>
	<CAKohpokLcZPcMUjXYNNxDcwHUzsL1ejYBYd0cDmnAHQu+cBYGA@mail.gmail.com>
	<20141008191454.GA6504@intel-desktop>
	<CAKohpom+Ey75QStm_xsVeC7arN_5a3+q_Nf8pvadTxNaLBKCEw@mail.gmail.com>
	<20141009180826.GA32265@intel-desktop>
	<CAKohpok9d4AK4qmERqtnGYBtZx=wnP5fdECOT6t1NFEGfAQ_2g@mail.gmail.com>
	<20141009190747.GA31674@intel-desktop>
	<CAKohponaW8i1as_w-cyrFoyY8PN7VwiRr=mE454Xhhe1C48mng@mail.gmail.com>
	<20141010165126.GA14463@intel-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f53.google.com ([209.85.218.53]:45612 "EHLO
	mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751774AbaJJI5S (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 10 Oct 2014 04:57:18 -0400
Received: by mail-oi0-f53.google.com with SMTP id v63so5995551oia.12
        for <linux-pm@vger.kernel.org>; Fri, 10 Oct 2014 01:57:17 -0700 (PDT)
In-Reply-To: <20141010165126.GA14463@intel-desktop>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Kasagar, Srinidhi" <srinidhi.kasagar@intel.com>
Cc: Dirk Brandewie <dirk.j.brandewie@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, vishwesh.m.rudramuni@intel.com

On 10 October 2014 22:21, Kasagar, Srinidhi <srinidhi.kasagar@intel.com> wrote:
> I have not debugged that. However, to double check the same I have rebased to the
> clean upstream tree and I don't see ->target_index() is called for any
> other CPUs during the offline-online path..

OKay, this is getting a bit confusing.

->target_index() is called for which CPU?
