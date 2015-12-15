From: Andy Gross <andy.gross@linaro.org>
Subject: Re: [PATCH v4 1/3] dt-binding: power: Add otg regulator binding
Date: Tue, 15 Dec 2015 16:37:39 -0600
Message-ID: <20151215223739.GB4246@Agamemnon.attlocal.net>
References: <1450209132-20185-1-git-send-email-tim.bird@sonymobile.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1450209132-20185-1-git-send-email-tim.bird@sonymobile.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Tim Bird <tim.bird@sonymobile.com>
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, sre@kernel.org, courtney.cavin@sonymobile.com, dbaryshkov@gmail.com, dwmw2@infradead.org, agross@codeaurora.org, Bjorn.Andersson@sonymobile.com, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, tbird20d@gmail.com
List-Id: linux-pm@vger.kernel.org

On Tue, Dec 15, 2015 at 11:52:10AM -0800, Tim Bird wrote:
> Add a binding for the regulator which controls the OTG chargepath switch.
> The OTG switch gets its power from pm8941_5vs1, and that should be
> expressed as a usb_otg_in-supply property in the DT node for the
> charger driver.  The regulator name is "otg-vbus".
> 
> Signed-off-by: Tim Bird <tim.bird@sonymobile.com>
> ---
> Changes since v3
>  - switch supply name to have underscores instead of dashes
>    - (switched back to match the name used in data sheets)
>  - switch regulator node name to otg-vbus
> Changes since v1
>  - switch supply name to have dashes instead of underscores
>  - remove superfluous DT explanations in the otg node description

Reviewed-by: Andy Gross <andy.gross@linaro.org>
