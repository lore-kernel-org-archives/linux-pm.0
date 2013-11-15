From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: suspend/resume governors with PM notifiers
Date: Fri, 15 Nov 2013 21:04:45 +0530
Message-ID: <CAKohpokDFr4=XPAwG1g75g=0iHHCEgpHYtSv4hbvfOFfEZRewg@mail.gmail.com>
References: <0e476d16e0ae4b001f5dd4f9ac191f899095928a.1384510171.git.viresh.kumar@linaro.org>
	<52862648.4000304@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <52862648.4000304@ti.com>
Sender: cpufreq-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Patch Tracking <patches@linaro.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Lan Tianyu <tianyu.lan@intel.com>, jinchoi@broadcom.com, Sebastian Capella <sebastian.capella@linaro.org>
List-Id: linux-pm@vger.kernel.org

On 15 November 2013 19:18, Nishanth Menon <nm@ti.com> wrote:
> Yes, this does fix the issue for me.
>
> Tested-by: Nishanth Menon <nm@ti.com>
> based on vendor kernel on top of v3.12 tag (equivalent diff:
> http://pastebin.mozilla.org/3609407)
>
> OMAP5-uEVM(OMAP5432): http://pastebin.mozilla.org/3609396

Thanks a lot for verifying buddy!! Glad that your issue is fixed..
