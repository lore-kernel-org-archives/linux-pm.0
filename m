From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH RFC 21/27] drivers: cpu-pd: Parse topology to setup CPU PM domains
Date: Fri, 11 Dec 2015 10:04:23 +0100
Message-ID: <CAMuHMdWBCPkSH6sf=xtLgttvdru222nAWOYNMVNqv6d86jprvA@mail.gmail.com>
References: <1447799871-56374-1-git-send-email-lina.iyer@linaro.org>
	<1447799871-56374-22-git-send-email-lina.iyer@linaro.org>
	<20151207145458.GA20538@red-moon>
	<20151208180536.GB2230@linaro.org>
	<20151210181121.GA26229@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:33260 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751029AbbLKJEZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 11 Dec 2015 04:04:25 -0500
In-Reply-To: <20151210181121.GA26229@red-moon>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Lina Iyer <lina.iyer@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@linaro.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, =?UTF-8?Q?Krzysztof_Koz=C5=82owski?= <k.kozlowski@samsung.com>, msivasub@codeaurora.org, Andy Gross <agross@codeaurora.org>, Stephen Boyd <sboyd@codeaurora.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Axel Haslam <ahaslam@baylibre.com>, mtitinger@baylibre.com, Rob Herring <robherring2@gmail.com>

On Thu, Dec 10, 2015 at 7:11 PM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
> On Tue, Dec 08, 2015 at 11:05:36AM -0700, Lina Iyer wrote:
>
> [...]
>
>> On Mon, Dec 07 2015 at 07:53 -0700, Lorenzo Pieralisi wrote:
>> >>+/**
>> >>+ * of_setup_cpu_domain_topology() - Setup the CPU domains from the CPU
>> >>+ * topology node in DT.
>> >>+ *
>> >>+ * @ops: The PM domain suspend/resume ops for all the domains in the topology
>> >>+ */
>> >>+int of_setup_cpu_domain_topology(const struct cpu_pd_ops *ops)
>> >>+{
>> >>+   struct device_node *cn, *map;
>> >>+   int ret = 0;
>> >>+
>> >>+   cn = of_find_node_by_path("/cpus");
>> >>+   if (!cn) {
>> >>+           pr_err("No CPU information found in DT\n");
>> >>+           return 0;
>> >>+   }
>> >>+
>> >>+   map = of_get_child_by_name(cn, "cpu-map");
>> >>+   if (!map)
>> >>+           goto out;
>> >
>> >I commented on this before, is this reliance on cpu-map necessary ?
>> >Could not you just rely on the "power-domains" phandle in the cpu
>> >nodes to build the cpumask for a specific power domain ? I think
>> >you should try to decouple the concept of power domain from the cpu-map
>> >cluster and I think this would also simplify your code in the process.
>> >
>> Sorry, I missed seeing your comment on this earlier.
>>
>> Hmm, it can be done, but I felt out of place to define just power
>> domains that have no devices in Linux, since they are handled in PSCI,
>> but also have no relation to PSCI. Hence, I felt cpu-map to be a good
>> place for the cluster domain. But I am not strongly inclined. I can
>> remove them from the cpu-map and keep them as separate nodes. However,
>> it would be nice to have a way to say these nodes are PSCI controlled.
>
> I do not agree with the way you described the system.
>
> Here is how I see it. DT must model HW, and in HW your cpus will be part
> of a power domain(s) that of course can be hierarchical. Every cpus has a
> phandle to the power domain it belongs into, and to group them as "cluster"
> you should follow the power domains hierarchy (ie if you have a cluster
> power domain, it will contain the core power domains, through the
> hierarchy it is easy to detect what cpus are part of the cluster power
> domain by detecting which cpus are part of its children). It is much
> simpler than the current solution I think, you get rid of cpu-map
> dependency (honestly it is a bit weird what you did, with cpu-map
> containing a cluster phandle to a power domain and cpu phandles to
> cpu nodes, and the DT bindings you posted does not seem to match your
> dts).
>
> For PSCI, nothing prevents you from defining the same bindings except
> that the power domain(s) is not explicitly controlled by the OS, still,
> the DT would always describe the HW and you can use it to detect the
> power domain topology and which cpus are part of a given power domain.
>
> Please let me know what you think, thanks.

+1

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
