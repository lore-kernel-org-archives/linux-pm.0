From: Alex Shi <alex.shi@linaro.org>
Subject: Re: [PATCH v2 2/3] cpu: expose pm_qos_resume_latency for each cpu
Date: Thu, 19 Jan 2017 16:18:29 +0800
Message-ID: <12535256-b518-ac7a-b293-3727f57c47fa@linaro.org>
References: <1484227624-6740-1-git-send-email-alex.shi@linaro.org>
 <1484227624-6740-3-git-send-email-alex.shi@linaro.org>
 <20170117102330.GB2085@mai>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170117102330.GB2085@mai>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, vincent.guittot@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-pm@vger.kernel.org



On 01/17/2017 06:23 PM, Daniel Lezcano wrote:
>> >  
>> > @@ -376,6 +377,7 @@ int register_cpu(struct cpu *cpu, int num)
>> >  
>> >  	per_cpu(cpu_sys_devices, num) = &cpu->dev;
>> >  	register_cpu_under_node(num, cpu_to_node(num));
>> > +	dev_pm_qos_expose_latency_limit(&cpu->dev, 0);
> This patch should be submitted as the last patch in the latencies constraint
> changes patchset IMO. It is pointless to provide an interface before a
> feature which is still under discussion.

Thanks for comments!

will fold it into next patch!
