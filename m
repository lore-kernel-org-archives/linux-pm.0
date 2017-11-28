From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [RFC V7 2/2] OPP: Allow "opp-hz" and "opp-microvolt" to contain
 magic values
Date: Tue, 28 Nov 2017 17:14:57 +0100
Message-ID: <CAPDyKFrBsb_gKQpPkSTNpSjqYGir9nXKzSE09qkyU=zr_S-5xA@mail.gmail.com>
References: <cover.1509453284.git.viresh.kumar@linaro.org> <23ba51eaa6b52117458165dccc00a95cf8e86e1d.1509453284.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <23ba51eaa6b52117458165dccc00a95cf8e86e1d.1509453284.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Kevin Hilman <khilman@kernel.org>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, Rafael Wysocki <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Rob Herring <robh+dt@kernel.org>, Rajendra Nayak <rnayak@codeaurora.org>, Sudeep Holla <sudeep.holla@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 31 October 2017 at 13:47, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On some platforms the exact frequency or voltage may be hidden from the
> OS by the firmware. Allow such configurations to pass magic values in
> the "opp-hz" or the "opp-microvolt" properties, which should be
> interpreted in a platform dependent way.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

This seems like a reasonable extension to me!

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  Documentation/devicetree/bindings/opp/opp.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/opp/opp.txt b/Documentation/devicetree/bindings/opp/opp.txt
> index 203e09fe7698..9c5056fb120f 100644
> --- a/Documentation/devicetree/bindings/opp/opp.txt
> +++ b/Documentation/devicetree/bindings/opp/opp.txt
> @@ -166,6 +166,12 @@ properties.
>    "power-domains" property. Also, either all or none of the OPP nodes in an OPP
>    table should have it set.
>
> +
> +On some platforms the exact frequency or voltage may be hidden from the OS by
> +the firmware and the "opp-hz" or the "opp-microvolt" properties may contain
> +magic values that represent the frequency or voltage in a firmware dependent
> +way, for example an index of an array in the firmware.
> +
>  Example 1: Single cluster Dual-core ARM cortex A9, switch DVFS states together.
>
>  / {
> --
> 2.15.0.rc1.236.g92ea95045093
>
