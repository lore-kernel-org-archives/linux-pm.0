From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 2/2 v4] cpufreq: qoriq: Don't look at clock implementation details
Date: Mon, 13 Feb 2017 22:24:40 +0100
Message-ID: <CAJZ5v0gcJVDgQ7fXCkXcz4JguaQeqUHUaxYtkKS9ma_CqhbRgA@mail.gmail.com>
References: <1486956655-4261-1-git-send-email-yuantian.tang@nxp.com> <1486956655-4261-2-git-send-email-yuantian.tang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1486956655-4261-2-git-send-email-yuantian.tang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: yuantian.tang@nxp.com
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, leoyang.li@nxp.com, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Scott Wood <scottwood@nxp.com>
List-Id: linux-pm@vger.kernel.org

On Mon, Feb 13, 2017 at 4:30 AM,  <yuantian.tang@nxp.com> wrote:
> From: Tang Yuantian <Yuantian.Tang@nxp.com>
>
> Get the CPU clock's potential parent clocks from the clock interface
> itself, rather than manually parsing the clocks property to find a
> phandle, looking at the clock-names property of that, and assuming that
> those are valid parent clocks for the cpu clock.
>
> This is necessary now that the clocks are generated based on the clock
> driver's knowledge of the chip rather than a fragile device-tree
> description of the mux options.
>
> We can now rely on the clock driver to ensure that the mux only exposes
> options that are valid.  The cpufreq driver was currently being overly
> conservative in some cases -- for example, the "min_cpufreq =
> get_bus_freq()" restriction only applies to chips with erratum
> A-004510, and whether the freq_mask used on p5020 is needed depends on
> the actual frequencies of the PLLs (FWIW, p5040 has a similar
> limitation but its .freq_mask was zero) -- and the frequency mask
> mechanism made assumptions about particular parent clock indices that
> are no longer valid.
>
> Signed-off-by: Scott Wood <scottwood@nxp.com>
> Signed-off-by: Tang Yuantian <yuantian.tang@nxp.com>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> v2: added more soc compatible strings
> v3: Remove the now-unused pnode and the call to of_node_put()
> v4: fixed warning:
>         >> [-Werror=implicit-function-declaration]
>         >      return get_hard_smp_processor_id(cpu);

The previous version of this is in my tree already and I'd rather not rebase it.

Please send the fix as a separate patch on top of v3.

Thanks,
Rafael
