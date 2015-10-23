From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [patch] cpufreq: scpi-cpufreq: signedness bug in
 scpi_get_dvfs_info()
Date: Fri, 23 Oct 2015 11:16:42 +0100
Message-ID: <562A090A.5000703@arm.com>
References: <20151022195208.GB24439@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <20151022195208.GB24439@mwanda>
Sender: kernel-janitors-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, kernel-janitors@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org



On 22/10/15 20:52, Dan Carpenter wrote:
> The "domain" variable needs to be signed for the error handling to
> work.
>
> Fixes: 8def31034d03 ('cpufreq: arm_big_little: add SCPI interface
> driver') Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>

Thanks for the fix
Acked-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep
