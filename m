From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: power: Add Spreadtrum SC2731 charger documentation
Date: Mon, 3 Sep 2018 12:14:56 +0200
Message-ID: <CAJKOXPcx1AC-xp4TPLQrzbwrPmKWK0tB2F+=e+Nb8afviABPHQ@mail.gmail.com>
References: <a582871f84c4dd588ae1651d1d9192cc80e2b272.1535964281.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <a582871f84c4dd588ae1651d1d9192cc80e2b272.1535964281.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: baolin.wang@linaro.org
Cc: sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, yuanjiang.yu@unisoc.com, broonie@kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, 3 Sep 2018 at 10:56, Baolin Wang <baolin.wang@linaro.org> wrote:
>
> This patch adds the binding documentation for Spreadtrum SC2731 charger
> device.
>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
> Changes from v1:
>  - Add parent node.
>  - Add some battery standard properties.
> ---
>  .../bindings/power/supply/sc2731_charger.txt       |   40 ++++++++++++++++++++
>  1 file changed, 40 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/sc2731_charger.txt

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
