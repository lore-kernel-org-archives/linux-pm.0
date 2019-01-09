From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v12 6/7] arm64: dts: sdm845: Add interconnect provider DT nodes
Date: Wed, 9 Jan 2019 15:18:01 -0800
Message-ID: <CAD=FV=Xg5Sz029_UjuDg-ms05Ez+riv8qr0FLWkvg6axPYbZ_g@mail.gmail.com>
References: <20181208170216.32555-1-georgi.djakov@linaro.org> <20181208170216.32555-7-georgi.djakov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181208170216.32555-7-georgi.djakov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Georgi Djakov <georgi.djakov@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andy Gross <andy.gross@linaro.org>, Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Rob Herring <robh+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, Vincent Guittot <vincent.guittot@linaro.org>, Saravana Kannan <skannan@codeaurora.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, seansw@qti.qualcomm.com, daidavid1@codeaurora.org, Evan Green <evgreen@chromium.org>, Mark Rutland <mark.rutland@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Alexandre Bailon <abailon@baylibre.com>, maxime.ripard@bootlin.com, Thierry
List-Id: linux-pm@vger.kernel.org

Hi,

On Sat, Dec 8, 2018 at 9:02 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
>
> From: David Dai <daidavid1@codeaurora.org>
>
> Add RSC (Resource State Coordinator) provider
> dictating network-on-chip interconnect bus performance
> found on SDM845-based platforms.
>
> Signed-off-by: David Dai <daidavid1@codeaurora.org>
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index b72bdb0a31a5..b3cd256a154e 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -1324,6 +1324,11 @@
>                                 compatible = "qcom,sdm845-rpmh-clk";
>                                 #clock-cells = <1>;
>                         };
> +
> +                       rsc_hlos: interconnect {
> +                               compatible = "qcom,sdm845-rsc-hlos";
> +                               #interconnect-cells = <1>;
> +                       };

It would have been convenient if this patch had also added an include above:

#include <dt-bindings/interconnect/qcom,sdm845.h>

...while the include isn't technically needed by this patch, all the
patches that want to actually _use_ the interconnect will need to add
the #include and then you get to some fun fights about who has to add
the include in which patch.  For instance these two patches won't
compile:

* https://lkml.kernel.org/r/1545373748-1416-1-git-send-email-jshekhar@codeaurora.org
* https://lkml.kernel.org/r/20181220173026.3857-4-jcrouse@codeaurora.org

...because neither of them happened to add the include.  Maybe they
were both assuming someone else would do it?


If nobody else wants to, I'm happy to post a patch to add that include
myself and it can be applied atop this one.  ...or if this patch needs
to spin for some other reason maybe you could add it into this patch
directly?

-Doug
