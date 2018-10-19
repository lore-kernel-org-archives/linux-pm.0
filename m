From: Valentin Schneider <valentin.schneider@arm.com>
Subject: Re: [RFC PATCH 0/7] Introduce thermal pressure
Date: Fri, 19 Oct 2018 12:29:36 +0100
Message-ID: <9671fd5c-a745-5936-ee57-11d2da89f105@arm.com>
References: <1539102302-9057-1-git-send-email-thara.gopinath@linaro.org>
 <20181010061751.GA37224@gmail.com> <5BBE1E1F.3030308@linaro.org>
 <20181016073305.GA64994@gmail.com> <5BC76181.90105@linaro.org>
 <20181018064849.GA42813@gmail.com> <5BC8B226.2040109@linaro.org>
 <20181019080218.GA35752@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181019080218.GA35752@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thara Gopinath <thara.gopinath@linaro.org>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, rui.zhang@intel.com, gregkh@linuxfoundation.org, rafael@kernel.org, amit.kachhap@gmail.com, viresh.kumar@linaro.org, javi.merino@kernel.org, edubezval@gmail.com, daniel.lezcano@linaro.org, linux-pm@vger.kernel.org, quentin.perret@arm.com, ionela.voinescu@arm.com, vincent.guittot@linaro.org
List-Id: linux-pm@vger.kernel.org

Hi,

On 19/10/2018 09:02, Ingo Molnar wrote:
> 
> * Thara Gopinath <thara.gopinath@linaro.org> wrote:

[...]
 
> So what unifies RT and DL utilization is that those are all direct task 
> loads independent of external factors.
> 
> Thermal load is more of a complex physical property of the combination of 
> various internal and external factors: the whole system workload running 
> (not just that single task), the thermal topology of the hardware, 
> external temperatures, the hardware's and the governor's policy regarding 
> thermal loads, etc. etc.
> 
> So while obviously when effective capacity of a CPU is calculated then 
> these will all be subtracted from the maximum capacity of the CPU, but I 
> think the thermal load metric and the averaging itself is probably 
> dissimilar enough to not be calculated via the PELT half-life for 
> example.
> 
> For example a reasonable future property would be match the speed of 
> decay in the averaging to the observed speed of decay via temperature 
> sensors? Most temperature sensors do a certain amount of averaging 
> themselves as well - and some platforms might not expose temperatures at 
> all, only 'got thermally throttled' / 'running at full speed' kind of 
> feedback.

That would also open the door to having different decay speeds on
different domains, if we have the tsensors for it - big and LITTLE cores
are not going to heat up in the same way (although there's going to
be some heat propagation).

Another thermal decay speed hint I'd see would be the energy model - it
does tell us after all how much energy is going through those cores, and
with a rough estimate of how much they can take before overheating 
(sustainable-power entry in the devicetree) we might be able to deduce a
somewhat sane decay speed.

> 
> Anyway, this doesn't really impact the concept, it's an implementational 
> detail, and much of this could be resolved if the averaging code in 
> pelt.c was librarized a bit - and that's really what you did there in a 
> fashion, I just think it should probably be abstracted out more clearly. 
> (I have no clear implementational suggestions right now, other than 'try 
> and see how it works out - it might be a bad idea'.)
> 
> Thanks,
> 
> 	Ingo
> 
> 
> 
