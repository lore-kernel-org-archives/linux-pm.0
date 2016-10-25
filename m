From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 3/4] dt-bindings: Update domain-idle-state binding to use
 correct compatibles
Date: Tue, 25 Oct 2016 16:59:38 +0100
Message-ID: <383a62dd-b4d7-f764-baf1-ff73691b3cbc@arm.com>
References: <1477409199-52182-1-git-send-email-lina.iyer@linaro.org>
 <1477409199-52182-4-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1477409199-52182-4-git-send-email-lina.iyer@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>, ulf.hansson@linaro.org, khilman@kernel.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, andy.gross@linaro.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, brendan.jackman@arm.com, lorenzo.pieralisi@arm.com, Juri.Lelli@arm.com, devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>
List-Id: linux-pm@vger.kernel.org



On 25/10/16 16:26, Lina Iyer wrote:
> Update domain-idle-state binding to use "domain-idle-state" compatible
> from Documentation/devicetree/bindings/arm/idle-states.txt.
>
> Cc: <devicetree@vger.kernel.org>
> Cc: Rob Herring <robh@kernel.org>
> Suggested-by: Sudeep Holla <sudeep.holla@arm.com>
> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
> ---
>  Documentation/devicetree/bindings/power/power_domain.txt | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/power/power_domain.txt b/Documentation/devicetree/bindings/power/power_domain.txt
> index e165036..6fb53a3 100644
> --- a/Documentation/devicetree/bindings/power/power_domain.txt
> +++ b/Documentation/devicetree/bindings/power/power_domain.txt
> @@ -30,8 +30,9 @@ Optional properties:
>     available in the next section.
>
>  - domain-idle-states : A phandle of an idle-state that shall be soaked into a
> -                generic domain power state. The idle state definitions are
> -                compatible with arm,idle-state specified in [1].
> +                generic domain power state. The idle state definitions must be
> +                compatible with "domain-idle-state"

I would reword the below a bit different so that it's flexible to be
reused without "arm,idle-state".

> as well as
> +                "arm,idle-state" as defined in [1].

'Idle states that are "arm,idle-state" compatible are generally
"domain-idle-state" compatible as well if it's a PM domain.'

or something like that in line with what's in patch 2/4.

That would give us the scope of reuse of "domain-idle-state" in device
for future. Also it aligns with your patch 4/4.

Otherwise, it looks good.

-- 
Regards,
Sudeep
