From: Lina Iyer <lina.iyer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v7 2/8] Documentation: arm: define DT idle states bindings
Date: Wed, 13 Aug 2014 13:25:36 -0600
Message-ID: <20140813192533.GA32624@ilina-mac.local>
References: <1407945127-27554-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1407945127-27554-3-git-send-email-lorenzo.pieralisi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1407945127-27554-3-git-send-email-lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Charles Garcia Tobin <Charles.Garcia-Tobin-5wv7dgnIgG8@public.gmane.org>, Nicolas Pitre <nico-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Peter De Schrijver <pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>, Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Amit Kucheria <amit.kucheria-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Vincent Guittot <vincent.guittot-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Antti Miettinen <ananaza-X3B1VOXEql0@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sebastian Capella <sebcape-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Tomasz Figa <t.figa-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, Chander Kashyap <k.chander-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hi Lorenzo,

On Wed, Aug 13, 2014 at 04:52:01PM +0100, Lorenzo Pieralisi wrote:
>+===========================================
>+4 - Examples
>+===========================================
>+
>+Example 1 (ARM 64-bit, 16-cpu system, PSCI enable-method):
>+
>+cpus {
>+	#size-cells = <0>;
>+	#address-cells = <2>;
>+
>+	CPU0: cpu@0 {
>+		device_type = "cpu";
>+		compatible = "arm,cortex-a57";
>+		reg = <0x0 0x0>;
>+		enable-method = "psci";
>+		cpu-idle-states = <&CPU_RETENTION_0_0 &CPU_SLEEP_0_0
>+				   &CLUSTER_RETENTION_0 &CLUSTER_SLEEP_0>;
>+	};
Sorry for jumping in late. I havent gone through all the patches yet or
followed on previous discussions, if somebody could answer this or point
me to the discussion, it would be great.
Why is the cpu defining the possible cluster idle states? Would it be
better that cluster states form a separate node, something like this -

	CLUSTER0: cluster@0 {
		...
		cpus = <&CPU0 &CPU1 &CPU2 &CPU3>;
		cluster-idle-states = <&CLUTER_RETENTION_0, &CLUSTER_SLEEP_0>;
		};
	};	
		
Allowing for something like this to be defined - 

	super_cluster0: cluster@101 {
		...
		clusters = <&CLUSTER0  &CLUSTER1>;
		cluster-idle-states = <&SOC_RETENTION, &SOC_SLEEP>;
		};
	};

And each cluster-idle-state follows the general idle definition as
provided in this document, and an indicator what the compising
components should idle at, for this idle state to be available.

	CLUSTER_SLEEP_0: cluster-sleep@0 {
		...
		/* sleep definition for cluster0's retention */
		min-idle-state = <CPU_SLEEP_0>;
	};

	SOC_SLEEP: cluster-sleep@101 {
		...
		min-idle-state = <&CLUSTER_SLEEP_0>;
	};
		

Opens up the idle state for a lot of heirarchical possibilities, which
if you think, is generally how the SoC is. 


Thanks,
Lina
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
