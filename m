From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RFC PATCH v2 01/17] OPP: Allow to request stub voltage
 regulators
Date: Wed, 24 Oct 2018 12:11:23 +0530
Message-ID: <20181024064123.lbpbeervghp35fe7@vireshk-i7>
References: <20181021205501.23943-1-digetx@gmail.com>
 <20181021205501.23943-2-digetx@gmail.com>
 <20181022053636.ag62j3rj3vovbz53@vireshk-i7>
 <e4027793-9436-413d-2a7b-34cf519218c3@gmail.com>
 <20181022113224.b5fiebgy2aap66nd@vireshk-i7>
 <29f893be-feed-c4c5-8468-51f7228dd468@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <29f893be-feed-c4c5-8468-51f7228dd468@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Osipenko <digetx@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Rob Herring <robh+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, Marcel Ziswiler <marcel.ziswiler@toradex.com>, linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 22-10-18, 15:12, Dmitry Osipenko wrote:
> Because there is one Tegra20 board (tegra20-trimslice) that doesn't declare
> necessary regulators, but we want to have CPU frequency scaling. I couldn't
> find board schematics and so don't know if CPU / CORE voltages are fixed on
> Trim-Slice or it is just preferable not to have DVFS for that board, it is an
> outlet-powered device [0]. Hence tegra20-cpufreq driver will request a dummy
> regulators when appropriate. 

We have been using the regulator_get_optional() variant until now in the OPP
core to make sure that we don't do DVFS for the CPU without the mandatory
regulators being present, as that may make things unstable and cause harm to the
SoC if we try to take CPU to frequency range over the currently programmed
regulator can support.

Now coming back to tegra-20 SoC, which actually requires a regulator normally by
design. On one of the boards (which is outlet powered), you aren't sure if there
is a programmable regulator or not, or if DVFS should really be done or not.
Isn't it worth checking the same from Tegra maintainers, or whomsoever has
information on that board ? What would happen if there actually was a regulator
and its default settings aren't good enough for high end frequencies ?

On the other hand, the tegra20 cpufreq driver is common across a lot of boards.
What will happen if the DT for some of the boards isn't correct and missed the
necessary regulator node ? And because you are moving to regulator_get() API for
the entire SoC (i.e. its cpufreq driver), people will never find the missing
regulator.

If we can do it safely for all tegra20 boards, why not migrate to using
regulator_get() instead of regulator_get_optional() in the OPP core API itself
for everyone ?

-- 
viresh
