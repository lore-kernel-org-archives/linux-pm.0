From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 1/2] cpufreq: suspend governors on system suspend/hibernate
Date: Tue, 26 Nov 2013 07:46:11 +0530
Message-ID: <CAKohpokAL9iTN8KSONwBS1JHBg93RyBS6nJVBruxddjO-UvYcg@mail.gmail.com>
References: <cover.1385118255.git.viresh.kumar@linaro.org>
	<e4bc55fac6bc68694e9905cc3cc6844173b64925.1385118256.git.viresh.kumar@linaro.org>
	<5293C16D.80605@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5293C16D.80605@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Patch Tracking <patches@linaro.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Lan Tianyu <tianyu.lan@intel.com>, jinchoi@broadcom.com, Sebastian Capella <sebastian.capella@linaro.org>
List-Id: linux-pm@vger.kernel.org

On 26 November 2013 03:00, Nishanth Menon <nm@ti.com> wrote:
> yes, this seems to work for me as well.
> http://pastebin.mozilla.org/3670909 - no cpufreq attempts to
> transition were triggered.

Ahh.. Thanks for confirming..
But we still can't work with noirq handlers as there are platforms
which want to change frequency before going into suspend and
so we need to do this from dpm_suspend() :)

Thanks for trying.

--
viresh
