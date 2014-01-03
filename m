From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/3] cpufreq: s3c2440: Remove hardware.h inclusion
Date: Fri, 3 Jan 2014 15:41:39 +0530
Message-ID: <CAKohpo=7Z5F+jKSzYEdb9VYzbwgJN_V1ZvxFkYkMToqNeMWfWg@mail.gmail.com>
References: <1388741257-26438-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1388741257-26438-1-git-send-email-sachin.kamat@linaro.org>
Sender: cpufreq-owner@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Patch Tracking <patches@linaro.org>
List-Id: linux-pm@vger.kernel.org

On 3 January 2014 14:57, Sachin Kamat <sachin.kamat@linaro.org> wrote:
> The contents of this header file are not referenced in the driver.
> Remove its inclusion.
>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> ---
>  drivers/cpufreq/s3c2440-cpufreq.c |    2 --
>  1 file changed, 2 deletions(-)

For all three patches:

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
