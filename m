From: Rob Herring <robherring2@gmail.com>
Subject: Re: [PATCH 2/2] Documentation: devicetree: Add boost-opp binding to
 list boost mode OPPs
Date: Tue, 4 Feb 2014 08:02:17 -0600
Message-ID: <CAL_JsqKRYCEadfpEPGwjsxdSaC4o0BrwDNL5bXDZeX-23=QKTg@mail.gmail.com>
References: <1391506890-7335-1-git-send-email-thomas.ab@samsung.com>
 <1391506890-7335-3-git-send-email-thomas.ab@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1391506890-7335-3-git-send-email-thomas.ab@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Thomas Abraham <ta.omasab@gmail.com>
Cc: Nishanth Menon <nm@ti.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Lukasz Majewski <l.majewski@samsung.com>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Pawel Moll <pawel.moll@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Tomasz Figa <t.figa@samsung.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Rob Herring <robh+dt@kernel.org>, Kukjin Kim <kgene.kim@samsung.com>, thomas.ab@samsung.com, Kumar Gala <galak@codeaurora.org>, Mark Rutland <mark.rutland@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Feb 4, 2014 at 3:41 AM, Thomas Abraham <ta.omasab@gmail.com> wrote:
> From: Thomas Abraham <thomas.ab@samsung.com>
>
> Certain CPUs or devices can support optional boost operating modes. Add a new
> binding to list OPPs to be additionally made available in boost operating modes.
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
>  Documentation/devicetree/bindings/power/opp.txt |    9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/power/opp.txt b/Documentation/devicetree/bindings/power/opp.txt
> index 74499e5..4df5cca 100644
> --- a/Documentation/devicetree/bindings/power/opp.txt
> +++ b/Documentation/devicetree/bindings/power/opp.txt
> @@ -10,6 +10,10 @@ Properties:
>         freq: clock frequency in kHz
>         vol: voltage in microvolt
>
> +Optional Properties:
> +- boost-opp: Similar to "operating-points" property but usable only in
> +  optional boost operating modes.
> +
>  Examples:
>
>  cpu@0 {
> @@ -22,4 +26,9 @@ cpu@0 {
>                 396000  950000
>                 198000  850000
>         >;
> +       boost-opp = <
> +               /* kHz     uV */
> +               1500000 1350000
> +               1400000 1285000
> +       >;

This looks like an example of needing to add more properties to the
OPP table. There are ongoing discussions on how to extend OPP table
and map to C states. This should be part of that discussion.

Rob
