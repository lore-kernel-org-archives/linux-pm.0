From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [patch] cpufreq: scpi-cpufreq: signedness bug in scpi_get_dvfs_info()
Date: Thu, 26 Nov 2015 14:07:23 +0000
Message-ID: <CAPKp9uZNHU-msMq7NMhOcaueEkc=bQhctovLjU4iGAN_Si4g0Q@mail.gmail.com>
References: <20151022195208.GB24439@mwanda>
	<562A090A.5000703@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <562A090A.5000703@arm.com>
Sender: kernel-janitors-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, kernel-janitors@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Rafael,

On Fri, Oct 23, 2015 at 11:16 AM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
>
> On 22/10/15 20:52, Dan Carpenter wrote:
>>
>> The "domain" variable needs to be signed for the error handling to
>> work.
>>
>> Fixes: 8def31034d03 ('cpufreq: arm_big_little: add SCPI interface
>> driver') Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>>
>
> Thanks for the fix
> Acked-by: Sudeep Holla <sudeep.holla@arm.com>
>

Can you pick this up for your next -rc fixes ?

Regards,
Sudeep
