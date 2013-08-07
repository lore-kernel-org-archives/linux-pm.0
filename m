From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 3/6] ARM: Tegra: Enable OPP library
Date: Wed, 07 Aug 2013 11:43:33 -0600
Message-ID: <52028745.6080707@wwwdotorg.org>
References: <cover.1375886595.git.viresh.kumar@linaro.org> <bfa34bd91e0fa4c6e215517e10c93ab271486418.1375886595.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <bfa34bd91e0fa4c6e215517e10c93ab271486418.1375886595.git.viresh.kumar@linaro.org>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@sisk.pl, swarren@nvidia.com, linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, mturquette@linaro.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On 08/07/2013 08:46 AM, Viresh Kumar wrote:
> cpufreq-cpu0 driver is dependent on OPP library and hence we need to enable it
> for Tegra as we are going to use cpufreq-cpu0.

Shouldn't these be selected by something in drivers/cpufreq/Kconfig?
