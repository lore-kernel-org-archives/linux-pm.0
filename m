From: Matteo Carnevali <rekstorm@gmail.com>
Subject: Re: Adding PM QoS parameters
Date: Mon, 27 Apr 2009 12:41:58 +0000 (UTC)
Message-ID: <loom.20090427T123846-754@post.gmane.org>
References: <mailman.459.1240339694.10269.linux-pm@lists.linux-foundation.org>
	<B85A65D85D7EB246BE421B3FB0FBB59301D6F6DE69@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

Premi, Sanjeev <premi <at> ti.com> writes:

> 
> Sorry, picking-up thread late...
> 

Hi, I'm Matteo Carnevali and I'm working in ST with Patrick on the topic of CPM.

> 
> Would like to see more of this before real comment; because I
> am trying to see what could happen if 2 drivers sharing a
> common parent clock try to change the freq in 2 different
> directions.
> 

Of Course, the QoS should always be granted, at least as long as system 
resources are available by the hardware.

In a real context is not so common that drivers (different from the cpu drivers 
like cpufreq or cpuidle) explicitly ask to lower cpu frequency, the cpufreq 
driver can do that but it relies on the governor which monitors the cpu load 
and consequently tunes the frequency.

Moreover the cpu frequency cannot be considered as an abstract parameter, but
something very related to the physical architecture. A device driver, in our 
ideas, cannot state "I now need more than 200Mhz to the cpu"...

However, two conflicting requests on an abstract parameter will be actually 
treated as a conflict and the framework core (the controller) or a governor 
associated to the framework will avoid to work on such proposal.
Anyway, the framework core should not be considered as a central entity that 
manages the control telling the driver how to act under certain circumstances, 
this is a feature of "Centralized power management" and it is not our idea.

Moreover, it is also not very possible that two requests to change the value of 
an abstract parameter (i.e. set a constraint on a parameter) happen exactly at 
the same time.

> 
> Once a requested level is achieved the requester should be
> notified for possible reconfiguration. It could be via an
> optional registration.
>

Yes, this is can be done with the notification chain.
Writing about the Best Effort approach of pmqos, we wanted to be sure we 
correctly pointed out a possible limitation of pmqos it self and we would like 
to know if you agree on this. 

> 
> So, again we are again looking at means to add more constraints
> and also the "kind" of constraint.
> 

> 
> We could start with a smaller set, e.g.:
> - Interrupt latency (in lieu of DMA latency)  
> - Sleep lateny (to control sleep in absence of cpuidle)
> - Cpu frequency
> - Cpu voltage
> 
> Of course, when we extend this to SoCs with multiple
> CPUs then we do have (possible) need of multiplicity
> if one of these has to act as "master".
> 
> e.g. OMAP3 allows ARM and IVA voltages and frequency
> to be changed independently.
> 

Specific hardware and platform feature should be kept confined in the driver 
code and not brought directly at framework level, i.e translated in parameters; 
on the other hand, the mapping among device operating modes (aka local driver 
configuration) and abstract parameters should be performed inside the device 
driver to support the framework.

> 
> On the first read, I believe abstract parameter+level combination
> can help us achieve the appliation portability across architectures
> and allow specific map most suitable for each arch.
> 

> 
> I am not sure if I understood this completely, but I believe
> that abstract -> specific mapping should be done at system level.
> Letting drivers define them, may not be portable; and might lead
> to more confusion.
> 

We can consider to have two mappings:
1) mapping between the driver local configuration and the abstract parameters.
Hence, if abstract parameter are well defined and a device driver is well 
written to support them and correctly maps its operating modes to the 
parameters, there should not be confusion.
Let's consider a NIC driver with 3 operating modes and just one abstract 
parameter, the bandwidth:

op mode   ---mapping---    bandwidth 

idle <----------------->   0
low power <------------>   0-20 Mbit/s
max power <------------>   0-54 Mbit/s

this is just a dummy example...

Drivers using this framework should of course correctly implement the framework 
API.

2) mapping between the platform code and the abstract parameters, which allows 
the hierarchical binding of platform specific resources and the abstract 
parameters

If we consider the example of the NIC driver, let say that it uses an SPI bus to 
transfer data to the SoC: the NIC declares it wants at least x bandwidth on the 
bus by setting a constraint on that abstract parameter. At this point the 
platform code has the job to assign the correct SPI channel for that request and 
can do that thanks to its mapping with the abstract parameter.
The NIC driver itself does not know at which SPI channel is attached. It just 
sets a constraint on a abstract parameter.

> 
> Agree.
> 

> 
> ...if we get rope closer to ground, gravity doesn't harm much!
> 

> 
> Generic params that impact the apps could/should be an array;
> while arch/plat specific ones could be a linked list.
> 
> Best regards,
> Sanjeev
> 


best regards,
Matteo


<-------------------------------------------------------------------->
  Matteo Carnevali < rekstorm at gmail dot com>
  Master student at Politecnico di Milano

<-------------------------------------------------------------------->

> > 
> 
