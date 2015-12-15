From: Bjorn Andersson <bjorn.andersson@sonymobile.com>
Subject: Re: [PATCH v4 2/3] power: qcom_smbb: Add otg regulator for control
 of vbus
Date: Tue, 15 Dec 2015 14:11:14 -0800
Message-ID: <20151215221114.GW4000@usrtlx11787.corpusers.net>
References: <1450209132-20185-1-git-send-email-tim.bird@sonymobile.com>
 <1450209132-20185-2-git-send-email-tim.bird@sonymobile.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1450209132-20185-2-git-send-email-tim.bird@sonymobile.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Tim Bird <tim.bird@sonymobile.com>
Cc: "robh+dt@kernel.org" <robh+dt@kernel.org>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "sre@kernel.org" <sre@kernel.org>, "Cavin, Courtney" <Courtney.Cavin@sonymobile.com>, "dbaryshkov@gmail.com" <dbaryshkov@gmail.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>, "agross@codeaurora.org" <agross@codeaurora.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "tbird20d@gmail.com" <tbird20d@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Tue 15 Dec 11:52 PST 2015, Tim Bird wrote:

> Add a regulator to control the OTG chargepath switch.  This
> is used by USB code to control VBUS direction - out for host mode
> on the OTG port, and in for charging mode.
> 
> Signed-off-by: Tim Bird <tim.bird@sonymobile.com>
> ---
> Changes since v3:
>  - changed DT node name to otg-vbus
>  - removed fixed-voltage setup from otg regulator rdesc
> Changes since v1:
>  - changed name of supply to remove underscores
> ---

Acked-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>

Regards,
Bjorn
