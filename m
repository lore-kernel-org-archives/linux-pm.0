From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v3 2/2] Documentation: devicetree: Add boost-frequency
 binding to list boost mode frequency
Date: Wed, 14 May 2014 16:06:03 +0100
Message-ID: <5373865B.2040205@arm.com>
References: <1400029380-5372-1-git-send-email-thomas.ab@samsung.com> <1400029380-5372-3-git-send-email-thomas.ab@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: 8BIT
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1400029380-5372-3-git-send-email-thomas.ab@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Thomas Abraham <ta.omasab@gmail.com>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "kgene.kim@samsung.com" <kgene.kim@samsung.com>, "t.figa@samsung.com" <t.figa@samsung.com>, "l.majewski@samsung.com" <l.majewski@samsung.com>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "thomas.ab@samsung.com" <thomas.ab@samsung.com>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <Pawel.Moll@arm.com>, Mark Rutland <Mark.Rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>
List-Id: linux-pm@vger.kernel.org



On 14/05/14 02:03, Thomas Abraham wrote:
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
>   .../devicetree/bindings/cpufreq/cpufreq-boost.txt  |   11 +++++++++++
>   1 files changed, 11 insertions(+), 0 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-boost.txt
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
> +  This list should be a subset of frequencies listed in "operating-points"
> +  property. Refer to Documentation/devicetree/bindings/power/opp.txt for
> +  details about "operating-points" property.
>

Though I understand the need of it, I think the binding is designed to suffice
the need of the boost frequency support in cpufreq.

Typically SoC would provide characteristics like under-drive(hits performance
but most energy efficient), nominal(highest sustained performance w/o any
external constraint like power, thermal) and over-drive(maximum performance but
not sustainable for long periods)

IMO the binding could represent these unique points on the curve instead.

Regards,
Sudeep
