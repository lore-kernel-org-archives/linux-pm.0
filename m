From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: Re: [PATCH 1/1] cpufreq: exynos5250: Set APLL rate using CCF API
Date: Thu, 19 Dec 2013 10:18:23 +0530
Message-ID: <CAK9yfHz1jC-=G9rAmQ54MFn=PKacfgoPJ6JsFaGVXqGb28yG1A@mail.gmail.com>
References: <1385009046-22070-1-git-send-email-sachin.kamat@linaro.org>
	<20131129071139.46eff334@amdc2363>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20131129071139.46eff334@amdc2363>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

On 29 November 2013 11:41, Lukasz Majewski <l.majewski@samsung.com> wrote:
> Hi Sachin,
>
>> Use common clock framework (CCF) APIs to set the clock rates
>> instead of direct register manipulation. This now updates the
>> sysfs entry (cpuinfo_cur_freq) correctly which did not reflect
>> the correct value until now. While at it clean up the PLL s-div
>> parameter setting as it is handled by the PLL driver.
>>
>> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
>> ---

>
> Looks good to me.
>
> Reviewed-by: Lukasz Majewski <l.majewski@samsung.com>


Didn't see this in linux-next yet, hence gentle ping, Rafael.


-- 
With warm regards,
Sachin
