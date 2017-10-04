From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v3 21/22] cpufreq: add support for CPU DVFS based on SCMI
 message protocol
Date: Wed, 4 Oct 2017 16:01:13 +0100
Message-ID: <5efbd0a7-8b62-5b30-98e6-dfaff64e2628@arm.com>
References: <1506604306-20739-1-git-send-email-sudeep.holla@arm.com>
 <1506604306-20739-22-git-send-email-sudeep.holla@arm.com>
 <CAK8P3a3pAFKM+Dq_yb7KYhB+xeneVuODBq_4nacEuw9creT6Yw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:34406 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752330AbdJDPBU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 4 Oct 2017 11:01:20 -0400
In-Reply-To: <CAK8P3a3pAFKM+Dq_yb7KYhB+xeneVuODBq_4nacEuw9creT6Yw@mail.gmail.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Sudeep Holla <sudeep.holla@arm.com>, ALKML <linux-arm-kernel@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, Roy Franz <roy.franz@cavium.com>, Harb Abdulhamid <harba@codeaurora.org>, Nishanth Menon <nm@ti.com>, Loc Ho <lho@apm.com>, Alexey Klimov <alexey.klimov@arm.com>, Ryan Harkin <Ryan.Harkin@arm.com>, Jassi Brar <jassisinghbrar@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org



On 04/10/17 12:30, Arnd Bergmann wrote:
>> +static int scmi_cpufreq_probe(struct platform_device *pdev)
>> +{
>> +       int ret;
>> +
>> +       handle = devm_scmi_handle_get(&pdev->dev);
>> +
>> +       if (IS_ERR_OR_NULL(handle) || !handle->perf_ops)
>> +               return -EPROBE_DEFER;
> 
> As mentioned before, never create an interface that needs to use
> IS_ERR_OR_NULL(), make it return either NULL on error, or always
> have an error code.
> 

Agreed.

>> +
>> +static struct platform_driver scmi_cpufreq_platdrv = {
>> +       .driver = {
>> +               .name   = "scmi-cpufreq",
>> +       },
>> +       .probe          = scmi_cpufreq_probe,
>> +       .remove         = scmi_cpufreq_remove,
>> +};
> 
> You appear to have split this driver into the 'cpufreq' side and
> the 'protocol' handler in a different file. I already commented that
> the way the main scmi driver knows about all the protocols looks
> bad, here we can see another aspect of the same problem.
> 
> Rather than manually register a platform_device for the purpose
> of connecting it to the cpufreq driver, there should be a way
> to dynamically register the protocol from the cpufreq driver
> and then have both in the same file.
> 

I agree that should be possible. I took this approach for 2 reasons:

1. to avoid all sorts of probe ordering issues
2. we may have system with multiple instances of SCMI. E.g. a system
   may have multiple remote processors, each controlling dvfs/power mgmt
   of a subset of CPUs/devices controller in OS.

I have to admit that I haven't thought too much in details yet. That's
the main idea behind scmi_handle and restricting access to that only to
sub-nodes in it. I am open to suggestions.

-- 
Regards,
Sudeep
