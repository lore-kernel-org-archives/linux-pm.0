From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V5 0/4] cpufreq: exynos5440: support for cpufreq driver
Date: Thu, 28 Mar 2013 14:03:58 +0530
Message-ID: <CAKohponyHMWB6f=5uMcyyR7ym-B6KKR9J_AavsYaHTDvMWPV9w@mail.gmail.com>
References: <1364457923-8499-1-git-send-email-amit.daniel@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1364457923-8499-1-git-send-email-amit.daniel@samsung.com>
Sender: cpufreq-owner@vger.kernel.org
To: Amit Daniel Kachhap <amit.daniel@samsung.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kukjin Kim <kgene.kim@samsung.com>, Thomas Abraham <thomas.abraham@linaro.org>, cpufreq@vger.kernel.org, Inderpal Singh <inderpal.singh@linaro.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>
List-Id: linux-pm@vger.kernel.org

On 28 March 2013 13:35, Amit Daniel Kachhap <amit.daniel@samsung.com> wrote:
> Submitting the V5 version of exynos5440 cpufreq driver. This patchset addresses
> all the coding and design concerns raised especially by Viresh.
>
> Changes in V5:
> * Removed the unnecessary DT look up entry from mach-exynos5-dt.c.
> * Fixed all coding and comments issue raised by Viresh.

People normally forget what they commented on earlier and that's why
this change log phenomenon was introduced. Some more details would
be better here for next time.
