From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH RFC 25/27] devicetree: bindings: Document qcom,msm-id and qcom,board-id
Date: Thu, 19 Nov 2015 08:36:52 -0600
Message-ID: <CAL_JsqJAOEvs08Jydn9wWtM7-Oxd=MmmDER48VRF7z3Gkzt0CQ@mail.gmail.com>
References: <1447799871-56374-1-git-send-email-lina.iyer@linaro.org> <1447799871-56374-26-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1447799871-56374-26-git-send-email-lina.iyer@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Geert Uytterhoeven <geert@linux-m68k.org>, =?UTF-8?Q?Krzysztof_Koz=C5=82owski?= <k.kozlowski@samsung.com>, msivasub@codeaurora.org, Andy Gross <agross@codeaurora.org>, Stephen Boyd <sboyd@codeaurora.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, ahaslam@baylibre.com, mtitinger@baylibre.com, Kumar Gala <galak@codeaurora.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Nov 17, 2015 at 4:37 PM, Lina Iyer <lina.iyer@linaro.org> wrote:
> From: Kumar Gala <galak@codeaurora.org>
>
> The top level qcom,msm-id and qcom,board-id are utilized by bootloaders
> on Qualcomm MSM platforms to determine which device tree should be
> utilized and passed to the kernel.

See [1] and the link there to the prior version which is like this one.

Rob

[1] https://lkml.org/lkml/2015/10/26/651
