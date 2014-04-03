From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: Re: [PATCH 1/1] cpufreq: exynos: Disable on multiplatform build
Date: Thu, 3 Apr 2014 17:13:58 +0530
Message-ID: <CAK9yfHxq7P1ngF9c-3P=HefoLrn3oZ9UngRc9DT_6g-xC0OtQg@mail.gmail.com>
References: <1396436627-22744-1-git-send-email-sachin.kamat@linaro.org>
	<CAKohpo=wVHubLTyR1oX_HPLrGvrg+YsqO0kbPSKYB9wEyhXb2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAKohpo=wVHubLTyR1oX_HPLrGvrg+YsqO0kbPSKYB9wEyhXb2w@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

On 2 April 2014 16:35, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 2 April 2014 16:33, Sachin Kamat <sachin.kamat@linaro.org> wrote:
>> The current exynos cpufreq drivers are not multiplatform compliant
>> and give build errors as they refer to header files from machine
>> directory. Work to migrate them to generic cpufreq framework is under
>> progress. Till such time disable the build on multiplatform so that
>> other multiplatform ready features get tested.
>>
>> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
>> Cc: Arnd Bergmann <arnd@arndb.de>

>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Rafael,
Please queue this patch for your upcoming pull request to Linus.

-- 
With warm regards,
Sachin
