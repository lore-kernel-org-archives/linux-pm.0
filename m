From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v5 1/1] cpufreq: tegra: Re-model Tegra20 cpufreq driver
Date: Fri, 20 Dec 2013 16:03:47 +0530
Message-ID: <CAKohpontQwTc4KP7XMvtkvS2sQTyF+ngXnXfbJ1ev+MLEp-H0g@mail.gmail.com>
References: <1387451926-21373-1-git-send-email-bilhuang@nvidia.com>
	<CAKohpomCPJYd+d_NnM9gxwQ7bH6C6=iLxbiWZbfNcjZ8Bi+2wA@mail.gmail.com>
	<52B41B18.30302@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <52B41B18.30302@nvidia.com>
Sender: cpufreq-owner@vger.kernel.org
To: bilhuang <bilhuang@nvidia.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 20 December 2013 15:55, bilhuang <bilhuang@nvidia.com> wrote:
> Don't you think it worth creating a file here so this can be shared to
> arm64?

We will see how to handle virtual devices when we will start getting
arm64 SoCs. Probably we might end up writing a single file in cpufreq,
if required, that will create virtual devices for every arm64 platform..

So, some people might use it and others wouldn't.. But no platform
specific files for such stuff. So, the best we can do for now is to move
these to platform code as we are talking about arm32 SoC's for now
which do have a mach-* directory..
