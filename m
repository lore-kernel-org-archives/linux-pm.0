From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH] cpufreq-cpu0: support Device Tree initialisation
Date: Mon, 29 Jul 2013 10:31:09 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1307291028140.14405@axis700.grange>
References: <Pine.LNX.4.64.1307261214430.22137@axis700.grange>
 <51F2698A.5020904@ti.com> <Pine.LNX.4.64.1307261431510.22137@axis700.grange>
 <51F27634.7040007@ti.com> <CAKohponxvT10XGUiMRXfzEzwFdMVZHucapZXzjeD49YDExGdHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:51196 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751464Ab3G2IbU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 29 Jul 2013 04:31:20 -0400
In-Reply-To: <CAKohponxvT10XGUiMRXfzEzwFdMVZHucapZXzjeD49YDExGdHw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Nishanth Menon <nm@ti.com>, Rob Herring <rob.herring@calxeda.com>, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Shawn Guo <shawn.guo@linaro.org>

On Mon, 29 Jul 2013, Viresh Kumar wrote:

> On 26 July 2013 18:44, Nishanth Menon <nm@ti.com> wrote:
> > As far as I am concerned, the original argument Shawn made[1] is convincing
> > enough for me.
> >
> > Will probably look at Viresh and others to see if there is a change in
> > opinion.
> 
> I would say that the earlier comments "a real hardware device is required
> for a node to be present in DT" still stands

Of course.

> and so this patch doesn't introduce anything new.

I wasn't proposing to add a new DT node, I was only proposing to add a 
compatibility line to an existing node, that doesn't create a device 
normally so far.

> @Rob: What do you think about getting a DT node for probing cpufreq
> driver? We surely need some way without declaring a platform device
> to get driver probed..
> 
> Or if we can put this information in the cpu node, which we don't have
> to replicate in all cpus..

Yes, that was the idea.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
