Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E5915FA81;
	Tue,  5 May 2026 22:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778018623; cv=none; b=DqcgaA1qq+Jw5G/EN+Q7HilPtslJlPF4+nrqTSucNzHHGsV3Usr2VDM84wllz8vDL3PCLNRL4ovuKvqBq4/W0KUhEDmuE9hlwpok4gAL4IuNrN2gFa+ILti0CHIG0Fla0NlnPcf0dGk+n3gfi2Qf+OpBoqJboSlE23AWkfqD9IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778018623; c=relaxed/simple;
	bh=c5vrF962zUxwUeB2dk4PdlsPp0ZCXIkWJ1jSUtib5L4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fPuFGYwfttD849BLHpqIrmPj5nVfMQ78FLlfEro8ciiTIZ0rRWfQ/NcHWvIlMgF1yxB6GDCI9Bt0XHAEoljTm9/fPUy6i1IYMmxZOJhKGOJlhCyvjeK69z8VuDBpC+cu8GUxEFluNkLHbPqEMG2DooPvWmHH0aPmnmE5crFF6E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=T33uvlqZ; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="T33uvlqZ"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0BC591A9A;
	Tue,  5 May 2026 15:03:35 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 911E33F763;
	Tue,  5 May 2026 15:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1778018620; bh=c5vrF962zUxwUeB2dk4PdlsPp0ZCXIkWJ1jSUtib5L4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T33uvlqZjWj7AJZzIVRQKyp9tB0IfgTSt67qR+EgdmyoIPDw757yVfhRw7RbNGm4G
	 wjMsU+jHFjMkixEmW0J105EtqchYx6XLRh/ETVJExSYdY3f8C9SlbZ68okn/Pv7i7a
	 ZRI9Sbo0EXKT1SQNP99XJaxYUDy48Ua0E5rhE/TA=
Date: Tue, 5 May 2026 23:03:34 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Philip Radford <philip.radford@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org, linux-pm@vger.kernel.org,
	sudeep.holla@arm.com, james.quinlan@broadcom.com,
	f.fainelli@gmail.com, vincent.guittot@linaro.org,
	etienne.carriere@st.com, peng.fan@oss.nxp.com, michal.simek@amd.com,
	quic_sibis@quicinc.com, dan.carpenter@linaro.org, d-gole@ti.com,
	souvik.chakravarty@arm.com, cristian.marussi@arm.com
Subject: Re: [PATCH v5 10/12] powercap: arm_scmi: Create synthetic parent
 node for multi-instance
Message-ID: <afppNhDnS3IuwelG@pluto>
References: <20260428090922.346069-1-philip.radford@arm.com>
 <20260428090922.346069-11-philip.radford@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428090922.346069-11-philip.radford@arm.com>

On Tue, Apr 28, 2026 at 10:09:19AM +0100, Philip Radford wrote:
> SCMI powercap domains are exposed as a flat list and may include
> multiple top-level domains without a parent. When registered with
> the powercap framework, these appear as independent root zones
> with no common hierarchy. The driver probes domains per SCMI
> instance, but when registering with the powercap framework, these
> would be combined into a single tree. This is particularly evident
> in multi-instance setups where zone IDs and parent zones can only
> coexist with other zones and parents from the same instance.

Hi,

I know the problem you are trying to solve is real and advised for this
solution BUT saying that the domains are exposed in a flat list upfront
is not correct and misleading I think...the problem revolves around the
fact that...

SCMI powercap domains are represented with a hierarchical structure
(if any such structure exists platform side) which can be comprised
of multiple trees (a forest of powercap zones trees) each with its own
top root powercap zone.
On a system designed to expose multipe SCMI instances each of such
instance could enumerate a pretty much similar/simmetrical hierarchy of
powercap zomes, all sharing most probably the same IDs for children and
parents...all of these simmetrical hierarchies can coexist as long as
they are confined into their own instance 'space'.

Given that the Powercap framework does NOT have the concept of instances
collating all of these zones into the same Linux Powercap top node leads
to an artificially flattened tree of powercap where all the boudnaries
between instances are squashes into one single structure....possibly
combining multiple unrelated SCMI zones under a single unrelated Linux
powercap zone (by virtue of simmetrical parent-child relations)

So the need for a (functionally limited) unifying synthetic top root for
each instance...

I am sure you can summarize all of these better :P):

> 
> Create a synthetic root zone to act as a common parent for all
> top-level domains. Creates a single hierarchy and unified entry
> point per-instance for userspace.
> 
> Signed-off-by: Philip Radford <philip.radford@arm.com>
> ---
> ---
>  drivers/powercap/arm_scmi_powercap.c | 67 ++++++++++++++++++++++++++--
>  1 file changed, 64 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/powercap/arm_scmi_powercap.c b/drivers/powercap/arm_scmi_powercap.c
> index 7f2bb162f96c..d74869af1633 100644
> --- a/drivers/powercap/arm_scmi_powercap.c
> +++ b/drivers/powercap/arm_scmi_powercap.c
> @@ -36,6 +36,7 @@ struct scmi_powercap_root {
>  	struct scmi_powercap_zone *spzones;
>  	struct list_head *registered_zones;
>  	struct list_head scmi_zones;
> +	struct scmi_powercap_zone instance_root;
>  };
>  
>  static struct powercap_control_type *scmi_top_pcntrl;
> @@ -263,12 +264,47 @@ static const struct powercap_zone_constraint_ops constraint_ops  = {
>  	.get_name = scmi_powercap_get_name,
>  };
>  
> +/* Multi-instance constraints to meet driver requrements */
> +static int instance_root_release(struct powercap_zone *pz)
> +{
> +	return 0;
> +}
> +
> +static int instance_root_get_power_uw(struct powercap_zone *pz, u64 *v)
> +{
> +	*v = 0;
> +	return 0;
> +}
> +
> +static int instance_root_set_constraint(struct powercap_zone *pz, int cid, u64 v)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static int instance_root_get_constraint(struct powercap_zone *pz, int cid, u64 *v)
> +{
> +	return -EOPNOTSUPP;
> +}

I would explain here better WHY you cannot really implement all the
fuctionalities on these toproot syntehtc zones...and WHY it is NOT an
issue but STILL it is enough to solve our problem with the multiple
instances configurations...

> +
> +static const struct powercap_zone_ops instance_root_ops = {
> +	.get_max_power_range_uw = scmi_powercap_get_max_power_range_uw,
> +	.get_power_uw = instance_root_get_power_uw,
> +	.release = instance_root_release,
> +};
> +
> +static const struct powercap_zone_constraint_ops instance_root_const_ops = {
> +	.set_power_limit_uw = instance_root_set_constraint,
> +	.get_power_limit_uw = instance_root_get_constraint,
> +	.set_time_window_us = instance_root_set_constraint,
> +	.get_time_window_us = instance_root_get_constraint,
> +};
> +
>  static void scmi_powercap_unregister_all_zones(struct scmi_powercap_root *pr)
>  {
>  	int i;
>  
>  	/* Un-register children zones first starting from the leaves */
> -	for (i = pr->num_zones - 1; i >= 0; i--) {
> +	for (i = pr->num_zones; i >= 0; i--) {
>  		if (!list_empty(&pr->registered_zones[i])) {
>  			struct scmi_powercap_zone *spz;
>  
> @@ -313,7 +349,6 @@ static int scmi_powercap_register_zone(struct scmi_powercap_root *pr,
>  				   parent ? &parent->zone : NULL,
>  				   &zone_ops, spz->info->num_cpli, &constraint_ops);
>  	if (!IS_ERR(z)) {
> -		spz->height = scmi_powercap_get_zone_height(spz);

I have to admit I'd have to look back at how I implemneted this powercap zone
walking at registration tome :D .. but HOW can you get rid of spz->height here ?

...also because now spz->height is NOT set anywhere (presumable zeroed
at init) and also why you have NOT removed also scmi_powercap_get_zone_height
since nobody is calling it ?

...also because I am pretty sure that all the management of the height of
the nodes in the binary trees where crucial when tearing down the hierarchy of
powercap zones ... (see explanation preceding scmi_zones_register())

...mmmm.... have you tried to unload the arm_scmi_powercap driver with these
new changes for the syntethic powercap zones ?

I just did :P

---8<----
root@deb-guest:~# modprobe -r arm_scmi_powercap
[   28.939470] Unable to handle kernel paging request at virtual address fffffffffffffc90
[   28.942910] Mem abort info:
[   28.947866]   ESR = 0x0000000096000006
[   28.953034]   EC = 0x25: DABT (current EL), IL = 32 bits
[   28.957189]   SET = 0, FnV = 0
[   28.957437]   EA = 0, S1PTW = 0
[   28.958254]   FSC = 0x06: level 2 translation fault
[   28.959025] Data abort info:
[   28.959511]   ISV = 0, ISS = 0x00000006, ISS2 = 0x00000000
[   28.960049]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[   28.961191]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[   28.962227] swapper pgtable: 4k pages, 48-bit VAs, pgdp=000000010261b000
[   28.963105] [fffffffffffffc90] pgd=0000000000000000, p4d=00000001030ff403, pud=0000000103100403, pmd=0000000000000000
[   28.964189] Internal error: Oops: 0000000096000006 [#1]  SMP
[   28.964994] Modules linked in: arm_scmi_powercap(-) cpufreq_powersave cpufreq_conservative
[   28.966300] CPU: 2 UID: 0 PID: 227 Comm: modprobe Not tainted 7.1.0-rc1-00012-g383eb3db9548 #2 PREEMPT 
[   28.967170] Hardware name: linux,dummy-virt (DT)
[   28.967925] pstate: 61400005 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
[   28.969245] pc : device_del+0x3c/0x3b0
[   28.969963] lr : device_unregister+0x28/0x90
[   28.970342] sp : ffff800083b73b30
[   28.970753] x29: ffff800083b73b50 x28: ffff000005d86000 x27: 0000000000000000
[   28.971448] x26: 0000000000000000 x25: 0000000000000000 x24: 0000000000000000
[   28.972159] x23: fffffffffffffff0 x22: ffff80007b1e30c0 x21: ffff000006f3c080
[   28.972701] x20: fffffffffffffc30 x19: fffffffffffffc50 x18: 0000000000000000
[   28.973237] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
[   28.973899] x14: 0000000000000000 x13: 0000000000000000 x12: ffff000007338880
[   28.974795] x11: ffff0000056bbc10 x10: ffff000009ca0c00 x9 : ffff800080c44480
[   28.975483] x8 : 0101010101010101 x7 : 7f7f7f7f7f7f7f7f x6 : fefefeff6364626d
[   28.976161] x5 : 8080808000000000 x4 : 0000000000000020 x3 : ffff80008243c534
[   28.976842] x2 : ffff000005d86000 x1 : 0000000000000000 x0 : fffffffffffffce0
[   28.977511] Call trace:
[   28.977738]  device_del+0x3c/0x3b0 (P)
[   28.978047]  device_unregister+0x28/0x90
[   28.978371]  powercap_unregister_zone+0x54/0x78
[   28.978781]  scmi_powercap_unregister_all_zones+0x84/0xc8 [arm_scmi_powercap]
[   28.979344]  scmi_powercap_remove+0x1c/0x38 [arm_scmi_powercap]
[   28.979821]  scmi_dev_remove+0x28/0x40
[   28.980136]  device_remove+0x54/0x90
[   28.980428]  device_release_driver_internal+0x1cc/0x230
[   28.980845]  driver_detach+0x54/0xc0
[   28.981136]  bus_remove_driver+0x74/0x100
[   28.981454]  driver_unregister+0x38/0x68
[   28.981774]  scmi_driver_unregister+0x28/0x1a0
[   28.982147]  scmi_powercap_exit+0x18/0xe20 [arm_scmi_powercap]
[   28.982560]  __arm64_sys_delete_module+0x1b0/0x2e0
[   28.982870]  invoke_syscall.constprop.0+0x48/0x120
[   28.983219]  el0_svc_common.constprop.0+0x40/0xe8
[   28.983628]  do_el0_svc+0x24/0x38
[   28.983916]  el0_svc+0x38/0x138
[   28.984201]  el0t_64_sync_handler+0xa0/0xe8
[   28.984557]  el0t_64_sync+0x198/0x1a0
[   28.984901] Code: f9429c01 f9000fe1 d2800001 91024260 (f9402276) 
[   28.985443] ---[ end trace 0000000000000000 ]---
Segmentation fault
--->8----

This does NOT happen without your syntethic node changes since the driver on
unload took care to remove/unregister powercap zones starting from the
leaves so as not to remove parents that were still referenced ....

.... you should always test also as a loadable module and manually load/unload
then testing...

I will review this again in V6...plesse double check to preserve the
original zone-walking algo...

Thanks,
Cristian
