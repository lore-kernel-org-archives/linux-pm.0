From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V3 11/16] cpufreq: dt: Pass regulator name to the OPP core
Date: Wed, 18 Jul 2018 12:46:22 +0530
Message-ID: <20180718071622.ujb7xm2whryyhu5v@vireshk-i7>
References: <cover.1454992186.git.viresh.kumar@linaro.org>
 <ad55cd1a03e712e2c0c49701e87a37199cb8376e.1454992187.git.viresh.kumar@linaro.org>
 <CAMuHMdXgE3oOVdYFy3kzmOv4FXvjU4rC39gUDUtMNJCdB__2AA@mail.gmail.com>
 <20180718055029.rdo427kozpwqm2bc@vireshk-i7>
 <CAMuHMdU=FNhWh_oroBZb8NkUr_fsvUvYxBHH6=KErqU9_Xi4ZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdU=FNhWh_oroBZb8NkUr_fsvUvYxBHH6=KErqU9_Xi4ZQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linaro-kernel <linaro-kernel@lists.linaro.org>, Linux PM list <linux-pm@vger.kernel.org>, Stephen Boyd <sboyd@codeaurora.org>, Nishanth Menon <nm@ti.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-pm@vger.kernel.org

On 18-07-18, 09:09, Geert Uytterhoeven wrote:
> IMHO they should be documented somewhere, with a link to
> Documentation/devicetree/bindings/regulator/regulator.txt.
> How else can a DTS writer know he/she needs them?
> Without cpu-supply (and clock!) properties, cpufreq can't work.
> 
> Candidates:
>   - Documentation/devicetree/bindings/cpufreq/cpufreq-dt.txt
>     This has operating points without clocks nor cpu-supply, but with
>     clock-latency (for which clock? ;-)
>   - Documentation/devicetree/bindings/cpufreq/arm_big_little_dt.txt
>     Again, operating points without clocks nor cpu-supply, but with
>     clock-latency.

Sounds reasonable. Will cook patches for that soon. Thanks.

-- 
viresh
