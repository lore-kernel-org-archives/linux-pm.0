From: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH RFC 2/2] Documentation: arm: define DT C-states bindings
Date: Tue, 03 Dec 2013 12:52:36 +0100
Message-ID: <529DC604.4050600@linaro.org>
References: <1386001205-11978-1-git-send-email-lorenzo.pieralisi@arm.com> <1386001205-11978-3-git-send-email-lorenzo.pieralisi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1386001205-11978-3-git-send-email-lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dave Martin <dave.martin-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Sudeep KarkadaNagesha <sudeep.karkadanagesha-5wv7dgnIgG8@public.gmane.org>, Charles Garcia Tobin <Charles.Garcia-Tobin-5wv7dgnIgG8@public.gmane.org>, Nicolas Pitre <nico-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Peter De Schrijver <pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>, Mark Hambleton <mark.hambleton-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Hanjun Guo <hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Amit Kucheria <amit.kucheria-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Vincent Guittot <vincent.guittot-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 12/02/2013 05:20 PM, Lorenzo Pieralisi wrote:
> ARM based platforms implement a variety of power management schemes t=
hat
> allow processors to enter at run-time low-power states, aka C-states
> in ACPI jargon. The parameters defining these C-states vary on a per-=
platform
> basis forcing the OS to hardcode the state parameters in platform
> specific static tables whose size grows as the number of platforms su=
pported
> in the kernel increases and hampers device drivers standardization.
>
> Therefore, this patch aims at standardizing C-state device tree bindi=
ngs for
> ARM platforms. Bindings define C-state parameters inclusive of entry =
methods
> and state latencies, to allow operating systems to retrieve the
> configuration entries from the device tree and initialize the related
> power management drivers, paving the way for common code in the kerne=
l
> to deal with power states and removing the need for static data in cu=
rrent
> and previous kernel versions.
>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>

Hi Lorenzo,

thanks for the detailed description.

Just a couple of typos below.

[ ... ]

> +- cpu-power-states node
> +
> +	Usage: Optional - On ARM systems, is a container of processor C-sta=
te
> +			  nodes. If the system does not provide CPU power
> +			  management capabilities or the processor just
> +			  supports WFI (C1 state) a cpu-power-states node is
> +			  not required.
> +
> +	Description: cpu-power-states node is a container node, where its
> +		     subnodes describe the CPU low-power C-states.
> +
> +	Node name must be "cpu-power-states".
> +
> +	The cpu-power-states node's parent node must be cpus node.
> +
> +	The cpu-power-states node's child nodes can be:
> +
> +	- one or more state nodes
> +
> +	The cpu-power-states node must contain the following properties:
> +
> +	- compatible
> +		Value type: <stringlist>
> +		Usage: Required

Invert the field above to be consistent with the definitions below.

[ ... ]

> +	- power-depth
> +		Usage: Required
> +		Value type: <u32>
> +		Definition: Integer value, starting from 2 (value 0 meaning
> +			    running and value 1 representing power depth of
> +			    wfi (C1)), that defines the level of depth of a
> +			    power state.
> +			    The system denotes power states with different
> +			    depths, an increasing value meaning less power
> +			    consumption and might involve powering down more
> +			    components.  Devices that are affected by

                                     ^^^ extra space

[ ... ]

Thanks
   -- Daniel

--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
