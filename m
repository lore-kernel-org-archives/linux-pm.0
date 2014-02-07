From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v2 2/2] Documentation: devicetree: Add boost-frequency
 binding to list boost mode frequency
Date: Fri, 7 Feb 2014 09:27:23 -0600
Message-ID: <CAGo_u6rymex=EZf0jj6rs2SpRARz2tA5F5jtT0+D-8BnSrfi9A@mail.gmail.com>
References: <1391786342-11812-1-git-send-email-thomas.ab@samsung.com>
	<1391786342-11812-3-git-send-email-thomas.ab@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1391786342-11812-3-git-send-email-thomas.ab@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Thomas Abraham <ta.omasab@gmail.com>
Cc: linux-pm@vger.kernel.org, dt list <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, rjw@rjwysocki.net, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Kukjin Kim <kgene.kim@samsung.com>, Tomasz Figa <t.figa@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>, Viresh Kumar <viresh.kumar@linaro.org>, thomas.ab@samsung.com, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Feb 7, 2014 at 9:19 AM, Thomas Abraham <ta.omasab@gmail.com> wrote:
> From: Thomas Abraham <thomas.ab@samsung.com>
>
> Add a new optional boost-frequency binding for specifying the frequencies
> usable in boost mode.
>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Lukasz Majewski <l.majewski@samsung.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Pawel Moll <pawel.moll@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
> Cc: Kumar Gala <galak@codeaurora.org>
> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
> ---
>  Documentation/devicetree/bindings/cpufreq/cpufreq-boost.txt |   11 +++++++++++
>  1 file changed, 11 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-boost.txt
>
> diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-boost.txt b/Documentation/devicetree/bindings/cpufreq/cpufreq-boost.txt
> new file mode 100644
> index 0000000..d925e38
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-boost.txt
> @@ -0,0 +1,11 @@
> +* Device tree binding for CPU boost frequency (aka over-clocking)
> +
> +Certain CPU's can be operated in optional 'boost' mode (or sometimes referred as
> +overclocking) in which the CPU can operate in frequencies beyond the normal
> +operating conditions.
> +
> +Optional Properties:
> +- boost-frequency: list of frequencies in KHz to be used only in boost mode.

boost-frequencies?

> +  This list should be a subset of frequencies listed in "operating-points"
> +  property. Refer to Documentation/devicetree/bindings/power/opp.txt for
> +  details about "operating-points" property.
> --
> 1.7.10.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
