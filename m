From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v3 2/2] Documentation: devicetree: Add boost-frequency
 binding to list boost mode frequency
Date: Tue, 13 May 2014 21:02:23 -0500
Message-ID: <CAGo_u6ozaKjzVQsJjzi5g13ysBT6UDwsgW3O1=K3RD4Y-ODtDA@mail.gmail.com>
References: <1400029380-5372-1-git-send-email-thomas.ab@samsung.com>
	<1400029380-5372-3-git-send-email-thomas.ab@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1400029380-5372-3-git-send-email-thomas.ab@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Thomas Abraham <ta.omasab@gmail.com>
Cc: "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, dt list <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, Kukjin Kim <kgene.kim@samsung.com>, Tomasz Figa <t.figa@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>, Viresh Kumar <viresh.kumar@linaro.org>, "thomas.ab@samsung.com" <thomas.ab@samsung.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

On Tue, May 13, 2014 at 8:03 PM, Thomas Abraham <ta.omasab@gmail.com> wrote:
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
>  .../devicetree/bindings/cpufreq/cpufreq-boost.txt  |   11 +++++++++++
>  1 files changed, 11 insertions(+), 0 deletions(-)
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

"operate at"?

> +operating conditions.

"normal operating conditions" probably need a little bit of an
expansion here perhaps?

> +
> +Optional Properties:
> +- boost-frequency: list of frequencies in KHz to be used only in boost mode.

probably boost-frequencies?

> +  This list should be a subset of frequencies listed in "operating-points"
> +  property. Refer to Documentation/devicetree/bindings/power/opp.txt for
> +  details about "operating-points" property.


an example is expected here.

personally, I think I understand the intent here, but as a hardware
description, will let folks comment if it is acceptable.

--
Regards,
Nishanth Menon
