From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [RFC PATCH 0/7] Introduce thermal pressure
Date: Fri, 19 Oct 2018 10:02:18 +0200
Message-ID: <20181019080218.GA35752@gmail.com>
References: <1539102302-9057-1-git-send-email-thara.gopinath@linaro.org>
 <20181010061751.GA37224@gmail.com>
 <5BBE1E1F.3030308@linaro.org>
 <20181016073305.GA64994@gmail.com>
 <5BC76181.90105@linaro.org>
 <20181018064849.GA42813@gmail.com>
 <5BC8B226.2040109@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5BC8B226.2040109@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Thara Gopinath <thara.gopinath@linaro.org>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, rui.zhang@intel.com, gregkh@linuxfoundation.org, rafael@kernel.org, amit.kachhap@gmail.com, viresh.kumar@linaro.org, javi.merino@kernel.org, edubezval@gmail.com, daniel.lezcano@linaro.org, linux-pm@vger.kernel.org, quentin.perret@arm.com, ionela.voinescu@arm.com, vincent.guittot@linaro.org
List-Id: linux-pm@vger.kernel.org


* Thara Gopinath <thara.gopinath@linaro.org> wrote:

> > Yeah, so I'd definitely suggest to not integrate this averaging into 
> > pelt.c in the fashion presented, because:
> > 
> >  - This couples your thermal throttling averaging to the PELT decay
> >    half-time AFAICS, which would break the other user every time the
> >    decay is changed/tuned.
>
> Let me pose the question in this manner. Today rt utilization, dl 
> utilization etc is tracked via PELT. The inherent idea is that, a cpu 
> has some capacity stolen by let us say rt task and so subtract the 
> capacity utilized by the rt task from cpu when calculating the 
> remaining capacity for a CFS task. Now, the idea behind thermal 
> pressure is that, the maximum available capacity of a cpu is limited 
> due to a thermal event, so take it out of the remaining capacity of a 
> cpu for a CFS task (at-least to start with). If utilization for rt 
> task, dl task etc is calculated via PELT and the capacity constraint 
> due to thermal event calculated by another averaging algorithm, there 
> can be some mismatch in the "capacity stolen" calculations, right? 
> Isnt't it better to track all the events that can limit the capacity of 
> a cpu via one algorithm ?

So what unifies RT and DL utilization is that those are all direct task 
loads independent of external factors.

Thermal load is more of a complex physical property of the combination of 
various internal and external factors: the whole system workload running 
(not just that single task), the thermal topology of the hardware, 
external temperatures, the hardware's and the governor's policy regarding 
thermal loads, etc. etc.

So while obviously when effective capacity of a CPU is calculated then 
these will all be subtracted from the maximum capacity of the CPU, but I 
think the thermal load metric and the averaging itself is probably 
dissimilar enough to not be calculated via the PELT half-life for 
example.

For example a reasonable future property would be match the speed of 
decay in the averaging to the observed speed of decay via temperature 
sensors? Most temperature sensors do a certain amount of averaging 
themselves as well - and some platforms might not expose temperatures at 
all, only 'got thermally throttled' / 'running at full speed' kind of 
feedback.

Anyway, this doesn't really impact the concept, it's an implementational 
detail, and much of this could be resolved if the averaging code in 
pelt.c was librarized a bit - and that's really what you did there in a 
fashion, I just think it should probably be abstracted out more clearly. 
(I have no clear implementational suggestions right now, other than 'try 
and see how it works out - it might be a bad idea'.)

Thanks,

	Ingo
