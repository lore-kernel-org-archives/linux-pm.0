From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: Set CPU frequency target
Date: Sun, 1 Dec 2013 08:22:20 +0530
Message-ID: <CAKohpo=3J3eD8q20_9pJCgnuHzeg5GtHCVrWZCuz-LUrfhr=bg@mail.gmail.com>
References: <CAKDJKT6cQVem2PNsceTBEVYh28vPnEiqGEaq6xLoQubBb2GPoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAKDJKT6cQVem2PNsceTBEVYh28vPnEiqGEaq6xLoQubBb2GPoA@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Manish Badarkhe <badarkhe.manish@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 1 December 2013 00:43, Manish Badarkhe <badarkhe.manish@gmail.com> wrote:
> I have some doubts in order to set "target" frequency in cpu-frequency
> driver. I gone through code which set
> "target" CPU frequency and got details as below:
>
> 1. Core CPU frequency driver "target" function calls
> (__cpufreq_driver_target) a platform specific "target"
>     functions(for e.g. exynos_target, davinci_target).
> 2. I observed some of problems in setting target frequency especially
> when doing target freq > current frequency.
> 3. Consider an example of davinci frequency driver if want to set a
> frequency higher than current frequency then
>                      1. Firstly, set regulator voltage and if it fails
> then return error.
>                      2. Set clock rate and if it fails return error.
>                      3. Consider a scenario that regulator works fine
> while setting voltage but somehow "clk_set_rate"
>                          fails then here is a bug, that CPU runs at
> higher voltage even though that is not required.
>
>  I have not seen anywhere in code that regulator is brought back to
> original voltage if CPU set rate for frequency
>  is failed. Am I missing something in code flow? or there is no need
> to care about regulator voltage in such case.

Its probably a bug, but people doesn't get around it unless clk_set_rate()
fails. And so nobody has cared to fix it up..

See cpufreq-cpu0 instead, which probably has all the error handling code
in place.
