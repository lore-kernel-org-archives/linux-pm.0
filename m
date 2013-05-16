From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 03/33] drivers/cpufreq: don't check resource with devm_ioremap_resource
Date: Thu, 16 May 2013 16:45:56 +0530
Message-ID: <CAKohpo=WoERP1MVMQ4APcwtf1yVjrPYGuejb1mk4=rM7buXeCw@mail.gmail.com>
References: <1368702961-4325-1-git-send-email-wsa@the-dreams.de>
	<1368702961-4325-4-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1368702961-4325-4-git-send-email-wsa@the-dreams.de>
Sender: cpufreq-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 16 May 2013 16:45, Wolfram Sang <wsa@the-dreams.de> wrote:
> devm_ioremap_resource does sanity checks on the given resource. No need to
> duplicate this in the driver.
>
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> ---
>  drivers/cpufreq/kirkwood-cpufreq.c |    4 ----
>  1 file changed, 4 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
