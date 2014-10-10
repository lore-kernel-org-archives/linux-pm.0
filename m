From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: Add sfi based cpufreq driver support
Date: Fri, 10 Oct 2014 14:57:42 +0530
Message-ID: <CAKohpo=feG4cgKU265X6bVBXTbPX7sAvTbqj=Q1WNF=rehCKEg@mail.gmail.com>
References: <20141007140734.GB24200@intel-desktop>
	<CAKohpokLcZPcMUjXYNNxDcwHUzsL1ejYBYd0cDmnAHQu+cBYGA@mail.gmail.com>
	<20141008191454.GA6504@intel-desktop>
	<CAKohpom+Ey75QStm_xsVeC7arN_5a3+q_Nf8pvadTxNaLBKCEw@mail.gmail.com>
	<20141009180826.GA32265@intel-desktop>
	<CAKohpok9d4AK4qmERqtnGYBtZx=wnP5fdECOT6t1NFEGfAQ_2g@mail.gmail.com>
	<20141009190747.GA31674@intel-desktop>
	<CAKohponaW8i1as_w-cyrFoyY8PN7VwiRr=mE454Xhhe1C48mng@mail.gmail.com>
	<20141010165126.GA14463@intel-desktop>
	<CAKohponh_1zBPZ9PxNACUZ-3WzPnbkpQCwmCmiTDEwGEW5D=Rg@mail.gmail.com>
	<20141010171401.GA27359@intel-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f50.google.com ([209.85.218.50]:37545 "EHLO
	mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752628AbaJJJ1p (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 10 Oct 2014 05:27:45 -0400
Received: by mail-oi0-f50.google.com with SMTP id i138so6081722oig.9
        for <linux-pm@vger.kernel.org>; Fri, 10 Oct 2014 02:27:44 -0700 (PDT)
In-Reply-To: <20141010171401.GA27359@intel-desktop>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Kasagar, Srinidhi" <srinidhi.kasagar@intel.com>
Cc: "Brandewie, Dirk J" <dirk.j.brandewie@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rudramuni, Vishwesh M" <vishwesh.m.rudramuni@intel.com>

On 10 October 2014 22:44, Kasagar, Srinidhi <srinidhi.kasagar@intel.com> wrote:
> It was called for the sibling cpu of the onlined one.

Still not clear. Can you give me output of this:

cat /sys/devices/system/cpu/cpu*/cpufreq/affected_cpus and
cat /sys/devices/system/cpu/cpu*/cpufreq/related_cpus

And then also tell me which CPU are you trying to remove ?
