From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/3] cpufreq: exynos: Adding cpufreq driver for exynos5440
Date: Thu, 7 Feb 2013 16:49:44 +0530
Message-ID: <CAOh2x=n+-PenMYNf9iZG0SeS4ENYdh0aKFWVZtLqWVHDUYhaMw@mail.gmail.com>
References: <1360179562-19950-1-git-send-email-amit.daniel@samsung.com>
	<1360179562-19950-2-git-send-email-amit.daniel@samsung.com>
	<CAG17yqSh3bk8C9YSXtEsh4F5AJttwbVjFY0tdoy6=SZX5qibkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAG17yqSh3bk8C9YSXtEsh4F5AJttwbVjFY0tdoy6=SZX5qibkQ@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Inderpal Singh <inderpal.singh@linaro.org>
Cc: Amit Daniel Kachhap <amit.daniel@samsung.com>, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kgene.kim@samsung.com, Thomas Abraham <thomas.abraham@linaro.org>, cpufreq@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu, Feb 7, 2013 at 10:39 AM, Inderpal Singh
<inderpal.singh@linaro.org> wrote:
>> +#define DRIVER_NAME            "exynos5440_dvfs"

>> +static struct cpufreq_driver exynos_driver = {
>> +       .name           = DRIVER_NAME,
>> +};
>> +
>
> Since this driver is only for exynos5440, having the same names as
> common exynos-cpufreq is misleading.

Where is it same?
