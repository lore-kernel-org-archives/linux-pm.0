From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] cpufreq: Add Kryo CPU scaling driver
Date: Tue, 22 May 2018 10:18:15 +0100
Message-ID: <7690ea9d-0155-ecd1-8fb2-08d0bd61e081@arm.com>
References: <1526555955-29960-11-git-send-email-ilialin@codeaurora.org>
 <1526729701-8589-1-git-send-email-ilialin@codeaurora.org>
 <153cc316-dcb5-972f-5a2f-c91fe0f6348b@arm.com>
 <000f01d3f103$3ff78ba0$bfe6a2e0$@codeaurora.org>
 <2ace10bc-e1c4-2060-94d3-eb71e966ffbe@arm.com>
 <001401d3f1a2$c7328850$559798f0$@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <001401d3f1a2$c7328850$559798f0$@codeaurora.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: ilialin@codeaurora.org, mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org, mark.rutland@arm.com, viresh.kumar@linaro.org, nm@ti.com, lgirdwood@gmail.com, broonie@kernel.org, andy.gross@linaro.org, david.brown@linaro.org, catalin.marinas@arm.com, will.deacon@arm.com, rjw@rjwysocki.net, linux-clk@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, rnayak@codeaurora.org, amit.kucheria@linaro.org, nicolas.dechesne@linaro.org, celster@codeaurora.org, tfinkel@codeaurora.org
List-Id: linux-pm@vger.kernel.org



On 22/05/18 08:59, ilialin@codeaurora.org wrote:
> OK, I think I found out the way. Would this be correct?

No.

> -----------------------------------------------------------------------------------------------
> extern struct cpu_topology cpu_topology[NR_CPUS];
> 
> static struct device *qcom_cpufreq_kryo_get_cluster_lead(int cluster)
> {
> 	unsigned cpu;
> 
> 	for_each_possible_cpu(cpu) {
> 		if ((cluster == cpu_topology[cpu].cluster_id) &&

cluster_id is going away soon, so avoid relying on that. IIUC there's a
way already something like opp_of_get_shared_cpus.

-- 
Regards,
Sudeep
