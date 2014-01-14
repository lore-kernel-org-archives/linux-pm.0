From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH] thermal: use device node to get thermal zone
Date: Tue, 14 Jan 2014 10:33:44 -0700
Message-ID: <52D574F8.7020100@wwwdotorg.org>
References: <1389172011-32107-1-git-send-email-wni@nvidia.com> <4D68720C2E767A4AA6A8796D42C8EB59E09ED1@BGSMSX101.gar.corp.intel.com> <52CD452D.3080508@ti.com> <52CE5615.8040204@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:54023 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751630AbaANRdr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 14 Jan 2014 12:33:47 -0500
In-Reply-To: <52CE5615.8040204@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Wei Ni <wni@nvidia.com>, Eduardo Valentin <eduardo.valentin@ti.com>, "R, Durgadoss" <durgadoss.r@intel.com>
Cc: "Zhang, Rui" <rui.zhang@intel.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, Matthew Longnecker <MLongnecker@nvidia.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>

On 01/09/2014 12:56 AM, Wei Ni wrote:
...
> On the tegra board, it will use two or more sensors to estimate the skin
> temperature by reading temps from these sensors and calculate them.
> For example, we have two sensors: sensor1 and sensor2. We can register
> them to thermal framework by using DT, something like:
> thermal-zones {
>                 sensor1: lm90-local {
> 			...
>                         thermal-sensors = <&lm90 0>;
>                 };
> 
>                 sensor2: lm90-remote {
> 			...
>                         thermal-sensors = <&lm90 1>;
>                 };
> }
> 
> Then I will add a device node for my skin temperature driver, something
> like:
> skin_temp {
> 	...
> 	#thermal-sensor-cells = <0>;
> 
> 	sub-devs {
> 		dev@0 {
> 			dev = <&sensor1>;
> 		};
> 
> 		dev@1 {
> 			dev = <&sensor2>;
> 		};
> 	};
> };

I haven't read the rest of the thread, but surely that last chunk of DT
would be far simpler as:

skin_temp {
	sub-devs = <&sensor1 &sensor2>;
};

or:

skin_temp {
	sensors = <&sensor1 &sensor2>;
	sensor-names = "local", "remote";
};

> So I can parse the DT in the skin temperature driver to get the nodes of
> the sensor1 and sensor2, and can use .*get_by_node to get thermal zone
> device, then use .get_temp() and other callbacks to get temperature and
> other information. If use the *.get_by_name, it may not get the uniqu
> one, because I don't know if there has the same name thermal zone,
> because some other driver may not use DT to register thermal zone, it
> can define any name by itself.

