From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH 00/14] cpufreq: cpu0: Extend support beyond CPU0, V2
Date: Thu, 17 Jul 2014 09:35:18 +0200
Message-ID: <20140717093518.486ac244@free-electrons.com>
References: <cover.1404231535.git.viresh.kumar@linaro.org>
	<CAKohpo=Z5gEHOC5q40q8dfQfoNP5-WyhjG1arV99zJiG2c+6Xg@mail.gmail.com>
	<CAKohpo=bUMKa752fBXZTb0WPYMfJtuR5uk7z-YaXYV63fhJWtg@mail.gmail.com>
	<1450785.beFNo3ByBF@vostro.rjw.lan>
	<CAKohpomPAp74Sf_DxqzFk1WzUTx5m=G-nj+d+QHW5q=gnVphhA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <CAKohpomPAp74Sf_DxqzFk1WzUTx5m=G-nj+d+QHW5q=gnVphhA@mail.gmail.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mike Turquette <mturquette@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Arvind Chauhan <arvind.chauhan@arm.com>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Sachin Kamat <spk.linux@gmail.com>, Thomas P Abraham <thomas.ab@samsung.com>, Shawn Guo <shawn.guo@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Nishanth Menon <nm@ti.com>, Tomasz Figa <t.figa@samsung.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Kukjin Kim <kgene.kim@samsung.com>, Michal Simek <michal.simek@xilinx.com>, Rob Herring <rob.herring@linaro.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Simon Horman <horms@verge.net.au>
List-Id: linux-pm@vger.kernel.org

Dear Viresh Kumar,

On Thu, 17 Jul 2014 05:58:22 +0530, Viresh Kumar wrote:
> On 17 July 2014 02:48, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > I don't like that idea, but I wonder what other people think.
> 
> Hmm, the other thread around looking at the bindings is really slow.

Could you summarize what is the issue with the binding?

At least for the case where we have one clock per CPU, the DT binding
is really dead simple: each CPU node can carry a "clocks" property, and
a "clock-latency" property. I really don't see why a long discussion is
needed to agree on such a binding.

Now, if the DT binding problem is related to those cases where you have
siblings, i.e one clock controlling *some* of the CPUs, but not all
CPUs or just one CPU, then maybe we could leave this aside for now,
only support the following cases:

 * One clock for all CPUs
 * One clock for each CPU

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
