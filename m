From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 1/2] cpufreq: suspend governors on system suspend/hibernate
Date: Fri, 22 Nov 2013 18:18:46 +0530
Message-ID: <CAKohpomaRUBL8HP-LVyN-E9w_rb9c9StW4xaR+kormfjskw_CA@mail.gmail.com>
References: <cover.1385118255.git.viresh.kumar@linaro.org>
	<e4bc55fac6bc68694e9905cc3cc6844173b64925.1385118256.git.viresh.kumar@linaro.org>
	<230872262.gyF1HmIKoj@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <230872262.gyF1HmIKoj@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Patch Tracking <patches@linaro.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Lan Tianyu <tianyu.lan@intel.com>, Nishanth Menon <nm@ti.com>, jinchoi@broadcom.com, Sebastian Capella <sebastian.capella@linaro.org>
List-Id: linux-pm@vger.kernel.org

On 22 November 2013 18:03, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> The locking here is pointless.  It doesn't prevent any race conditions
> from happening.

All comments accepted..
