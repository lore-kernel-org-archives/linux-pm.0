From: "Javi Merino" <javi.merino@arm.com>
Subject: Re: [RFC PATCH v6 6/9] thermal: cpu_cooling: implement the power
 cooling device API
Date: Tue, 9 Dec 2014 10:32:49 +0000
Message-ID: <20141209103249.GB2891@e104805>
References: <1417806260-9264-1-git-send-email-javi.merino@arm.com>
 <1417806260-9264-7-git-send-email-javi.merino@arm.com>
 <CAOh2x==BKyS08th2d4r0Q2UGqhzAwj6sqOgFsH6J0pWup+OU_A@mail.gmail.com>
 <20141208125033.GB2980@e104805>
 <CAKohpokM_8Qm5YH0Xb=n95bP94Qreqpcd1fAyCD2W5u9Pd=ndg@mail.gmail.com>
 <20141208142217.GA1831@e104805>
 <CAKohpomy7=v_qE3B_+hhwdUE8MCJkV7gzmPpUOb==t1BuZAnAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:50106 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754822AbaLIKcz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 9 Dec 2014 05:32:55 -0500
In-Reply-To: <CAKohpomy7=v_qE3B_+hhwdUE8MCJkV7gzmPpUOb==t1BuZAnAA@mail.gmail.com>
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Punit Agrawal <Punit.Agrawal@arm.com>, Mark Brown <broonie@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>

Hi Viresh,

On Tue, Dec 09, 2014 at 01:59:39AM +0000, Viresh Kumar wrote:
> On 8 December 2014 at 19:52, Javi Merino <javi.merino@arm.com> wrote:
> > Ok, changed it into:
> >
> >         cpu = cpumask_any(&cpufreq_device->allowed_cpus);
> >         dev = get_cpu_device(cpu);
> >         if (!dev) {
> >                 dev_warn(&cpufreq_device->cool_dev->device,
> >                         "No cpu device for cpu %d\n", cpu);
> >                 ret = -EINVAL;
> >                 goto unlock;
> >         }
> >
> >         num_opps = dev_pm_opp_get_opp_count(dev);
> >         if (num_opps <= 0) {
> >                 ret = (num_opps < 0)? num_opps : -EINVAL;
> >                 goto unlock;
> >         }
> 
> And this might not work. This is what I said in the first reply.
> 
> So, a bit lengthy reply now :)
> 
> Every cpu has a device struct associated with it. When cpufreq
> core initializes drivers, they ask for mapping (initializing) the opps.
> At that point we pass policy->cpu to opp core. OPP core doesn't
> know which cores share clock line (I am trying to solve that [1]) and
> so it just initializes the OPPs for policy->cpu. Let us say it cpuX.
> 
> Now there will be few more CPUs which are going to share clock
> line with it and hence will use the same OPPs. In thermal core,
> you got clip_cpus which is exactly the masks of all these CPUs
> sharing clock line.
> 
> If the OPP layer is good enough, then above code can work. But
> because right now the OPPs are mapped to just cpuX, passing
> any other cpu from clip_cpus will fail as it doesn't have any associated
> OPPs.
> 
> Now what I asked you is to use the CPU for which
> __cpufreq_cooling_register() is called. Normally we are calling
> __cpufreq_cooling_register() for the CPU for which OPPs are
> registered (but people might call it up for other CPUs as well)..

Sorry but I don't follow.  __cpufreq_cooling_register() is passed a
clip_cpus mask, not a single cpu.  How do I get "the cpu for which
__cpufreq_cooling_register() is called" if not by looping through all
the cpus in the mask?
 
> So, using that cpu *might* have worked here.
> 
> Now the earlier loop you used was good to get this information,
> but it wasn't consistent and so I objected.
> 
> What you should do:
> 
> - Create another routine to find the cpu for which OPPs are bound
> to
> -  And save the cpu_dev for it in the global struct for cpu_cooling

This I have done, it wasn't part of the snip that I sent.

> - reuse it wherever required.

Same as above.

