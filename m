From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: Tegra: drop wrapper around tegra_update_cpu_speed()
Date: Fri, 16 May 2014 11:36:48 +0530
Message-ID: <CAKohponB_wiJZ9jq+JrJGxe7Y-447FpEjSZRZ+snXpxmOP=Erg@mail.gmail.com>
References: <a38df05b91198f393b1c4b78f39110c6bece3627.1400133049.git.viresh.kumar@linaro.org>
	<53750B27.4020708@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <53750B27.4020708@wwwdotorg.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Stephen Warren <swarren@nvidia.com>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arvind Chauhan <arvind.chauhan@arm.com>
List-Id: linux-pm@vger.kernel.org

On 16 May 2014 00:14, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 05/14/2014 11:51 PM, Viresh Kumar wrote:
>> Tegra has implemented an unnecessary wrapper over tegra_update_cpu_speed(), i.e.
>> tegra_target(), which wasn't doing anything apart of calling
>> tegra_update_cpu_speed(). Get rid of that and use tegra_target() directly.
>
> I think it used to do something until some refactoring happened? Anyway,

Yep..

> Acked-by: Stephen Warren <swarren@nvidia.com>
>
