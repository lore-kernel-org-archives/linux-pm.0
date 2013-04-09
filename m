From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 14/18] cpufreq: sh: move cpufreq driver to drivers/cpufreq
Date: Tue, 9 Apr 2013 19:42:51 +0530
Message-ID: <CAKohpomqfVqiw1PJxBRRA8=A6hV_63AW4nRpM8TfZPA5bypcKQ@mail.gmail.com>
References: <cover.1365079581.git.viresh.kumar@linaro.org>
	<3167220d1e262ff22078993a5beec55e82dfd951.1365079581.git.viresh.kumar@linaro.org>
	<20130409125509.GH15412@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <20130409125509.GH15412@verge.net.au>
Sender: cpufreq-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: rjw@sisk.pl, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com, charles.garcia-tobin@arm.com, arvind.chauhan@arm.com, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-kernel@lists.linaro.org, patches@linaro.org, Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 9 April 2013 18:25, Simon Horman <horms@verge.net.au> wrote:
> On Thu, Apr 04, 2013 at 06:24:22PM +0530, Viresh Kumar wrote:
>> This patch moves cpufreq driver of SUPERH architecture to drivers/cpufreq.
>
> Why?
>
> I am missing the cover email where I assume the explanation lies.

Hi Simon,

The idea was to keep all cpufreq drivers at a common and most suitable
place, so that future consolidation work can be done easily and efficiently.

So, functionally this patch shouldn't change anything.
