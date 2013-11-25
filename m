From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 2/2] cpufreq: Change freq before suspending governors
Date: Mon, 25 Nov 2013 15:44:02 +0530
Message-ID: <CAKohpompkiUqOati4B8F0HqN2eTMEADm01SnUuE0_GxnTAWJdQ@mail.gmail.com>
References: <cover.1385118255.git.viresh.kumar@linaro.org>
	<CAKohpo=RWi1nRUJq4qx8K+Y7swMDaqwEOH24-KfBCMgdbW=hMQ@mail.gmail.com>
	<528FB2EC.2020202@wwwdotorg.org>
	<2065978.h16hV1Cgky@vostro.rjw.lan>
	<CAKohpomEL8aU_ETaHFG_G8mhYMZc6M6x7i4m+McozP=i7Fzz5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKohpomEL8aU_ETaHFG_G8mhYMZc6M6x7i4m+McozP=i7Fzz5A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Stephen Warren <swarren@nvidia.com>, Kukjin Kim <kgene@kernel.org>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Sachin Kamat <sachin.kamat@linaro.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Patch Tracking <patches@linaro.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Lan Tianyu <tianyu.lan@intel.com>, Nishanth Menon <nm@ti.com>, jinchoi@broadcom.com, Sebastian Capella <sebastian.capella@linaro.org>, Peter De Schrijver <pdeschrijver@nvidia.com>
List-Id: linux-pm@vger.kernel.org

On 25 November 2013 09:58, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> Giving cpufreq-drivers a chance to do whatever they want looks to be
> correct. So, maybe prepare() or suspend_prepare() for them can be
> implemented.

I have used the existing infrastructure here, i.e. suspend/resume callbacks
for drivers.. As we don't need two suspend calls now..
