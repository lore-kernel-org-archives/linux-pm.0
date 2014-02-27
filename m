From: Punit Agrawal <punit.agrawal@arm.com>
Subject: [RFC] Power allocation based thermal management
Date: Thu, 27 Feb 2014 15:09:48 +0000
Message-ID: <530F553C.6030804@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:53412 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751514AbaB0PJv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 27 Feb 2014 10:09:51 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: eduardo.valentin@ti.com, rui.zhang@intel.com, Javi Merino <Javi.Merino@arm.com>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, Bobby Batacharia <Bobby.Batacharia@arm.com>, Robin Randhawa <Robin.Randhawa@ARM.com>

Hi linux-pm,

We've been working on a thermal management solution that controls system 
and device power allocation to control temperature. We have a working 
solution running on customer hardware that shows very good results, both 
in terms of thermal control and performance. Conceptually, the 
implementation takes a system view of heat dissipation by managing 
multiple heat sources (CPU and GPU for starters).

We believe that the ideas in our solution fit well with the linux 
thermal framework, and would like to integrate them. We've mainly worked 
with phone form factors but we believe that other form factors could 
benefit from this as well.

We use a traditional Proportional Integral Differential (PID) 
controller (http://en.wikipedia.org/wiki/PID_controller) driven by a 
temperature sensor to estimate an available power budget. This budget is 
then allocated to each device (called actor) that can have bearing on 
the temperature we are trying to control. We decide how much power to 
give each actor based on the performance they are requesting. This 
requires transforming performance requests into requested power, which 
we do with the aid of power models. Anything that generates heat can be 
modelled as an actor, e.g., CPU, GPU, modem, radio, etc. Controlling 
power helps control heat dissipation (and hence temperature) while the 
division of power between the actors ensures that power is allocated 
where it is needed the most, based on the current workload.

We need to know how much power each actor, that generates heat, 
requests. The power models are used to estimate (1) A conversion between 
performance request (derived from frequency and utilisation information) 
to power (2) An idea of running power consumption of each actor (3) 
Convert allocated power into a performance output.  To upstream this, we 
will provide an actor API and use it to provide a simple power model for 
an example CPU. This model will provide an example implementation, 
however platform developers are free to develop more complex models 
behind the API. Platform developers can also use the API to develop 
models for other types of CPU or IP. The actor API will also provide a 
function to set the power which can be translated to actor specific 
actions. In the case of the CPU that power can be translated to a 
cooling state which can then be passed to the cooling device.

In order to integrate this in the thermal framework, the PID controller 
can be implemented as part of a new thermal governor. This governor will 
be connected to a number actors. Through the actor API, the governor can 
retrieve the power requested by each actor. This information will be 
combined with the output of the PID controller to create a fair 
allocation of output power for each device. The PID controller will 
ensure that the total power budget does not exceed the control 
temperature. The combination will provide good thermal regulation and 
fair allocation of power. Actors will transform their allotted output 
power into a cooling devices state.

With this RFC, we are hoping to start a discussion and get early 
feedback on the proposed changes.

Cheers,
Punit

