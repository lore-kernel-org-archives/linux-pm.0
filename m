From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 1/6] clk: Tegra: Add CPU0 clock driver
Date: Thu, 08 Aug 2013 12:50:28 -0600
Message-ID: <5203E874.7070907@wwwdotorg.org>
References: <cover.1375886595.git.viresh.kumar@linaro.org> <8d192a13cb7e088943da40689d62bc6353bd8604.1375886595.git.viresh.kumar@linaro.org> <52028620.6000608@wwwdotorg.org> <CAKohpokVgcMfmKmjkxc9Dr3z6mBKad23uUdB4ydN_xzGHdfedQ@mail.gmail.com> <52028859.20008@wwwdotorg.org> <CAKohpokK7F7tYJnisVjF=NCRb9zUjQNzrFdXs+QsPSb4oqyytA@mail.gmail.com> <52029713.5070808@wwwdotorg.org> <CAKohpoky9-E2XoxAQy_oQ3sMxvAv5ZfBdDQPd6zUxcSwyKmzXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAKohpoky9-E2XoxAQy_oQ3sMxvAv5ZfBdDQPd6zUxcSwyKmzXg@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@sisk.pl, swarren@nvidia.com, linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, mturquette@linaro.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On 08/07/2013 08:42 PM, Viresh Kumar wrote:
> On 8 August 2013 00:20, Stephen Warren <swarren@wwwdotorg.org> wrote:
>> Right, and that's *exactly* what having a cpufreq driver is for; to
>> implement the details of CPU clock management.
> 
> cpufreq drivers used to keep such information since a long time,
> probably because there wasn't another place to keep them and
> provide generic API's (like generic clock framework).. And so this
> replication started to get in place which we are trying to get rid of
> now.
> 
> All cpufreq drivers share a lot of common code which can go
> away and so cpufreq-cpu0 was introduced..
> 
> With this patchset this replication goes away for tegra atleast at
> the cost of a platform specific clk-cpu driver.. I think that's a good
> deal, isn't it?

I think this patch series is simply moving the custom per-SoC code
somewhere else (clock driver) so that the cpufreq drivers can be
simpler. However, the clock drivers are more complex, and now represent
concepts that aren't really clocks.

So, no I'm not sure it's good.

> And that's the only way you can use these generic drivers that we
> have...

I don't think so. I think it's reasonable to have a per-SoC cpufreq
driver whose primary content is the parameterization data and/or custom
hooks for a unified core cpufreq driver. The duplicate parts of each
cpufreq driver can be moved into the core cpufreq driver, but the
non-duplicate parts remain. That's how many other subsystems work (MMC,
USB, ASoC spring to mind).
