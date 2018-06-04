From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v2] cpuidle/powernv : Add Description for cpuidle state
Date: Mon, 04 Jun 2018 19:04:14 +1000
Message-ID: <0a28154deb468669a59c120a90d4aedc1e1e705b.camel@kernel.crashing.org>
References: <20180604081758.104201-1-huntbag@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180604081758.104201-1-huntbag@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Abhishek Goel <huntbag@linux.vnet.ibm.com>, rjw@rjwysocki.net, daniel.lezcano@linaro.org, paulus@samba.org, mpe@ellerman.id.au, linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: stewart@linux.vnet.ibm.com
List-Id: linux-pm@vger.kernel.org

On Mon, 2018-06-04 at 13:47 +0530, Abhishek Goel wrote:
> +       if (of_property_read_string_array(power_mgt,
> +               "ibm,cpu-idle-state-descs", descs, dt_idle_states) < 0) {
> +               of_property_read_string_array(power_mgt,
> +                               "ibm,cpu-idle-state-names", descs, dt_idle_states);
> +               pr_warn("cpuidle-powernv: missing ibm,cpu-idle-state-descs in DT\n"
> +                       "Name will be used for description\n");
> +       }
>  
>         /*

Is this a new property ? I'm not fan of adding yet another of those
silly arrays.

I would say this is the right time now to switch over to a node per
state instead, as we discussed with Vaidy.

Additionally, while doing that, we can provide the versioning mechanism
I proposed so we can deal with state specific issues and erratas.

Cheers,
Ben.
