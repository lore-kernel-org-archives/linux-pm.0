From: Paul Burton <paul.burton@imgtec.com>
Subject: Re: [PATCH 09/10] cpuidle: declare cpuidle_dev in cpuidle.h
Date: Thu, 20 Feb 2014 14:00:33 +0000
Message-ID: <20140220140033.GU25765@pburton-linux.le.imgtec.org>
References: <1389794137-11361-1-git-send-email-paul.burton@imgtec.com>
 <1389794137-11361-10-git-send-email-paul.burton@imgtec.com>
 <53060496.6000303@linaro.org>
 <20140220134118.GT25765@pburton-linux.le.imgtec.org>
 <530608C2.3070507@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:47677 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753634AbaBTOAg (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 20 Feb 2014 09:00:36 -0500
Content-Disposition: inline
In-Reply-To: <530608C2.3070507@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-mips@linux-mips.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org

On Thu, Feb 20, 2014 at 02:53:06PM +0100, Daniel Lezcano wrote:
> On 02/20/2014 02:41 PM, Paul Burton wrote:
> >On Thu, Feb 20, 2014 at 02:35:18PM +0100, Daniel Lezcano wrote:
> >>On 01/15/2014 02:55 PM, Paul Burton wrote:
> >>>Declaring this allows drivers which need to initialise each struct
> >>>cpuidle_device at initialisation time to make use of the structures
> >>>already defined in cpuidle.c, rather than having to wastefully define
> >>>their own.
> >>>
> >>>Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> >>>Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> >>>Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> >>>Cc: linux-pm@vger.kernel.org
> >>>---
> >>>  include/linux/cpuidle.h | 1 +
> >>>  1 file changed, 1 insertion(+)
> >>>
> >>>diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
> >>>index 50fcbb0..bab4f33 100644
> >>>--- a/include/linux/cpuidle.h
> >>>+++ b/include/linux/cpuidle.h
> >>>@@ -84,6 +84,7 @@ struct cpuidle_device {
> >>>  };
> >>>
> >>>  DECLARE_PER_CPU(struct cpuidle_device *, cpuidle_devices);
> >>>+DECLARE_PER_CPU(struct cpuidle_device, cpuidle_dev);
> >>
> >>
> >>Nak. When a device is registered, it is assigned to the cpuidle_devices
> >>pointer and the backend driver should use it.
> >>
> >
> >Yes, but then if the driver needs to initialise the coupled_cpus mask
> >then it cannot do so until after the device has been registered. During
> >registration the cpuidle_coupled_register_device will then see the empty
> >coupled_cpus mask & do nothing. The only other ways around this would be
> >for the driver to define its own per-cpu struct cpuidle_device (which as
> >I state in the commit message seems wasteful when cpuidle already
> >defined them), or for cpuidle_coupled_register_device to be called later
> >after the driver had a chance to modify devices via the cpuidle_devices
> >pointers.
> 
> Yeah. I understand why you wanted to declare these cpu variables.
> 
> The mips cpuidle driver sounds like a bit particular. I believe I need some
> clarification on the behavior of the hardware to understand correctly the
> driver. Could you explain how the couples act vs the cpu ? And why
> cpu_sibling is used instead of cpu_possible_mask ?
> 
> 

Sure. The CPUs that are coupled are actually VPEs (Virtual Processor
Elements) within a single core. They share the compute resource (ALUs
etc) of the core but have their own register state, ie. they're a form
of simultaneous multithreading.

Coherence within a MIPS Coherent Processing System is a property of the
core rather than of an individual VPE (since the VPEs within a core
share the same L1 caches). So for idle states which are non-coherent the
VPEs within the core are coupled. That covers all idle states beyond a
simple "wait" instruction - clock gating or powering down a core
requires it to become non-coherent first.

cpu_sibling_mask is already setup to indicate which CPUs (VPEs) are
within the same core as each other, which is why it is simply copied for
coupled_cpus.

Paul

