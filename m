From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/3] cpufreq: cpu0: Release clk and regulator in remove function
Date: Thu, 28 Aug 2014 11:23:35 +0530
Message-ID: <CAOh2x=mLsGNZGJVDNVh4QvyKKkGZFnHdKktB_YtAHKHxZd=vFw@mail.gmail.com>
References: <1409209212-18730-1-git-send-email-pramod.gurav@smartplayin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1409209212-18730-1-git-send-email-pramod.gurav@smartplayin.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Pramod Gurav <pramod.gurav@smartplayin.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arm-msm@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>, Shawn Guo <shawn.guo@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
List-Id: linux-pm@vger.kernel.org

On Thu, Aug 28, 2014 at 12:30 PM, Pramod Gurav
<pramod.gurav@smartplayin.com> wrote:
> This function releases clk and regulator in remove function for clean
> unloading.
>
> CC: Shawn Guo <shawn.guo@linaro.org>
> CC: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> CC: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Pramod Gurav <pramod.gurav@smartplayin.com>
> ---
>  drivers/cpufreq/cpufreq-cpu0.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)

I already have most of this queued up, have sent V3 and cc'd now. See
if you need anything over that.
