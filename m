From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RFC/PATCH 10/12] cpufreq: Add a cpufreq-krait based on cpufreq-cpu0
Date: Wed, 25 Jun 2014 14:17:41 +0530
Message-ID: <CAOh2x=ktLkZYF-xAUKCNAhUuLAED76EpnYx2B2SwiottwAxBUA@mail.gmail.com>
References: <1403654783-7176-1-git-send-email-sboyd@codeaurora.org>
	<1403654783-7176-11-git-send-email-sboyd@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1403654783-7176-11-git-send-email-sboyd@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: linux-arm-msm@vger.kernel.org, Mike Turquette <mturquette@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Jun 25, 2014 at 5:36 AM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> Krait processors have individual clocks for each CPU that can
> scale independently from one another. cpufreq-cpu0 is fairly
> close to this, but assumes that there is only one clock for all
> CPUs. Add a driver to support the Krait configuration.

You missed both cpufreq maintainers and PM-list in cc :(

> TODO: Merge into cpufreq-cpu0? Or make generic?

Haven't gone into minute details of this driver but have tried
what looks to be the way ahead.

As you also mentioned merging with cpufreq-cpu0 might be
worth and I have tried extending cpufreq-cpu0's support
for all CPUs..

It should work for Krait. I have tested it for Exynos dual-A15
and it didn't explode :)

Links aren't available yet but you can find that in your
mailbox with this subject:

[PATCH 0/2] cpufreq: cpu0: Extend support beyond CPU0

Cc'd everybody from this thread..
