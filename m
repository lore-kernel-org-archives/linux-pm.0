From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH V4 3/3] cpufreq: Tegra: implement intermediate frequency
 callbacks
Date: Mon, 02 Jun 2014 10:50:20 -0600
Message-ID: <538CAB4C.9070103@wwwdotorg.org>
References: <cover.1400662383.git.viresh.kumar@linaro.org>	<dc2702973028425e3ded689a6da227658fb914c4.1400662383.git.viresh.kumar@linaro.org>	<53877103.8070604@wwwdotorg.org>	<CAKohponsZOpV74+SLMDLy0oCV-j896wA9--bwbwk4GUL59m1ug@mail.gmail.com>	<5388B134.9090307@wwwdotorg.org> <CAKohpokxnyu5qk+Jb+LAfHsoFe0iFAg55k1DPN3PO7t+0obBkg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKohpokxnyu5qk+Jb+LAfHsoFe0iFAg55k1DPN3PO7t+0obBkg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arvind Chauhan <arvind.chauhan@arm.com>, Stephen Warren <swarren@nvidia.com>, Doug Anderson <dianders@chromium.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Nicolas Pitre <nicolas.pitre@linaro.org>, Thomas Abraham <thomas.abraham@linaro.org>, Peter De Schrijver <pdeschrijver@nvidia.com>
List-Id: linux-pm@vger.kernel.org

On 06/02/2014 04:06 AM, Viresh Kumar wrote:
> On 30 May 2014 21:56, Stephen Warren <swarren@wwwdotorg.org> wrote:
>> ... [This patch causes issues on Tegra20] ...
>> I believe the issue is this:
...
> Okay, that was very helpful..
> 
> What about this ? (Attached for testing) :
> 
> Author: Viresh Kumar <viresh.kumar@linaro.org>
> Date:   Fri May 16 14:22:40 2014 +0530
> 
>     cpufreq: Tegra: implement intermediate frequency callbacks
> 
>     Tegra had always been switching to intermediate frequency (pll_p_clk) since
>     ever. CPUFreq core has better support for handling notifications for these
>     frequencies and so we can adapt Tegra's driver to it.
> 
>     Also do a WARN() if clk_set_parent() fails while moving back to pll_x as we
>     should have atleast restored to earlier frequency on error.

Tested-by: Stephen Warren <swarren@nvidia.com>

I'd prefer a couple of changes though:

a) Rename "pll_p_clk_count" to better describe what it represents. It
represents the fact that pll_x has been prepare_enabled, so why not call
it "pll_x_prepared"?

b) I think it should be a Boolean not an integer; there should never be
a case where the value is not 0 or 1. The only way that could happen is
if the cpufreq core called tegra_target_intermediate() out of sequence
too many times.
