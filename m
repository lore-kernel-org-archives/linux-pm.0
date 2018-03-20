From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 06/10] ARM64: dts: meson: Remove
 "cooling-{min|max}-level" for CPU nodes
Date: Tue, 20 Mar 2018 09:37:31 +0800
Message-ID: <20180320013731.olxjil4qfj6ppjsl@vireshk-mac-ubuntu>
References: <cover.1518166039.git.viresh.kumar@linaro.org>
 <6c91ebfecf86da98a7682c6d262ff1218a1d7343.1518166039.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6c91ebfecf86da98a7682c6d262ff1218a1d7343.1518166039.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: arm@kernel.org, arnd.bergmann@linaro.org, Rafael Wysocki <rjw@rjwysocki.net>, Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>
Cc: linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Eduardo Valentin <edubezval@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Zhang Rui <rui.zhang@intel.com>, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, daniel.lezcano@linaro.org, linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 09-02-18, 14:28, Viresh Kumar wrote:
> The "cooling-min-level" and "cooling-max-level" properties are not
> parsed by any part of the kernel currently and the max cooling state of
> a CPU cooling device is found by referring to the cpufreq table instead.
> 
> Remove the unused properties from the CPU nodes.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts | 4 ----
>  1 file changed, 4 deletions(-)

@Arnd: Can you please pick this and patch 8/10 from this series for 4.17 ? Both
are already Acked by Neil. I have just re-bounced both the messages to
arm@kernel.org. Thanks.

--
viresh
