From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V3 09/10] cpufreq: cpu0: rename driver and internals to 'cpufreq_generic'
Date: Tue, 9 Sep 2014 19:22:59 +0530
Message-ID: <CAKohpo=LYuNn7=7wH+rEV_P7522+qxZWsq2DWA4CmtE10L_26g@mail.gmail.com>
References: <cover.1409201048.git.viresh.kumar@linaro.org>
	<540E435D.1070706@codeaurora.org>
	<CAKohpokisuO8vQ+p5sq-ojYjU55YQm+Q==+rEWCa95J37j_a7w@mail.gmail.com>
	<2522658.WeeDA1knhn@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <2522658.WeeDA1knhn@vostro.rjw.lan>
Sender: linux-arm-msm-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Stephen Boyd <sboyd@codeaurora.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Shawn Guo <shawn.guo@linaro.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Sachin Kamat <spk.linux@gmail.com>, Thomas Abraham <thomas.ab@samsung.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, "pramod.gurav@smartplayin.com" <pramod.gurav@smartplayin.com>
List-Id: linux-pm@vger.kernel.org

On 9 September 2014 18:59, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> - cpufreq_dt
>
> If it relies on DTs being used, this probably is the right name to call it.

Okay then. Let it be cpufreq-dt.c.. Will send patches shortly..
