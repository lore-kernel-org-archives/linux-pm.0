From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v6] Cpufreq: Fix governor start/stop race condition
Date: Wed, 19 Jun 2013 08:46:06 +0530
Message-ID: <CAKohpont42JcdLH-TawNWVDJeiLNHeAWx4fgvAkyerOD=64MLQ@mail.gmail.com>
References: <1371606191-5618-1-git-send-email-chenxg@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1371606191-5618-1-git-send-email-chenxg@marvell.com>
Sender: cpufreq-owner@vger.kernel.org
To: Xiaoguang Chen <chenxg@marvell.com>
Cc: rjw@sisk.pl, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, njiang1@marvell.com, zjwu@marvell.com, ylmao@marvell.com, chenxg.marvell@gmail.com
List-Id: linux-pm@vger.kernel.org

On 19 June 2013 07:13, Xiaoguang Chen <chenxg@marvell.com> wrote:
> There are 4 CPUs and policy->cpu=cpu0, cpu1/2/3 are linked to cpu0.
> The normal sequence is as below:

I thought Rafael asked to write cpu0 as CPU0, ...
