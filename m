From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq-cpu0: support Device Tree initialisation
Date: Mon, 29 Jul 2013 13:47:00 +0530
Message-ID: <CAKohponxvT10XGUiMRXfzEzwFdMVZHucapZXzjeD49YDExGdHw@mail.gmail.com>
References: <Pine.LNX.4.64.1307261214430.22137@axis700.grange>
	<51F2698A.5020904@ti.com>
	<Pine.LNX.4.64.1307261431510.22137@axis700.grange>
	<51F27634.7040007@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <51F27634.7040007@ti.com>
Sender: cpufreq-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>, Rob Herring <rob.herring@calxeda.com>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Shawn Guo <shawn.guo@linaro.org>
List-Id: linux-pm@vger.kernel.org

On 26 July 2013 18:44, Nishanth Menon <nm@ti.com> wrote:
> As far as I am concerned, the original argument Shawn made[1] is convincing
> enough for me.
>
> Will probably look at Viresh and others to see if there is a change in
> opinion.

I would say that the earlier comments "a real hardware device is required
for a node to be present in DT" still stands and so this patch doesn't
introduce anything new.

@Rob: What do you think about getting a DT node for probing cpufreq
driver? We surely need some way without declaring a platform device
to get driver probed..

Or if we can put this information in the cpu node, which we don't have
to replicate in all cpus..
