From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 0/2] cpufreq/opp: rework regulator initialization
Date: Fri, 8 Feb 2019 15:58:35 +0530
Message-ID: <20190208102835.fjxyeyp3kkdwar5d@vireshk-i7>
References: <CGME20190207122255eucas1p1cdebed838c799eca46cce6a654a26187@eucas1p1.samsung.com>
 <20190207122227.19873-1-m.szyprowski@samsung.com>
 <20190208064957.zhyue42kpgaoslwm@vireshk-i7>
 <dc3802db-2931-e4fa-72f4-fa6e9b5c0e9a@samsung.com>
 <20190208085544.vqkebcgg7jpbv2a6@vireshk-i7>
 <CAJZ5v0jB7CDd9+gX+R3e+yrEsJty1E2MwuJGnuaJS0QeHeJ5rg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jB7CDd9+gX+R3e+yrEsJty1E2MwuJGnuaJS0QeHeJ5rg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Samsung SoC <linux-samsung-soc@vger.kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Dave Gerlach <d-gerlach@ti.com>, Wolfram Sang <wsa@the-dreams.de>
List-Id: linux-pm@vger.kernel.org

On 08-02-19, 11:18, Rafael J. Wysocki wrote:
> Obviously, all I2C transfers need to take place either before
> suspending the I2C controller or after resuming it.

Right. But all I am saying is that it is the responsibility of the
cpufreq core/driver to make sure we call ->init() only when the
resources are available to be used. For example during driver load, we
defer probe if resources aren't available and that makes sure ->init()
gets called when we can actually change the frequency.

Shouldn't the same be true during resume? That is make sure all
resources are in place before ->init() gets called ?

-- 
viresh
