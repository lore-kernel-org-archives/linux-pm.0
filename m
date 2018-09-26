From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 3/4] dt-bindings: power: Add Spreadtrum SC27XX fuel
 gauge unit documentation
Date: Wed, 26 Sep 2018 10:04:31 +0200
Message-ID: <CACRpkdb1SAWk7EaF5-O5QNXrMVZU7GCwp+XqskmGC==VG2zVLQ@mail.gmail.com>
References: <358665e3f4f9ec105dc2f8a2dc6dd98dbe761fae.1537930252.git.baolin.wang@linaro.org>
 <b4b36b7b54cc227e6e7f14c314b4617863a205f5.1537930252.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <b4b36b7b54cc227e6e7f14c314b4617863a205f5.1537930252.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Linux PM list <linux-pm@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, yuanjiang.yu@unisoc.com, Mark Brown <broonie@kernel.org>, Craig Tatlor <ctatlor97@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Wed, Sep 26, 2018 at 5:00 AM Baolin Wang <baolin.wang@linaro.org> wrote:

> This patch adds the binding documentation for Spreadtrum SC27XX series PMICs
> fuel gauge unit device, which is used to calculate the battery capacity.
>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
> Changes from v1:
>  - Renamed GPIO property.
>  - Use standand battery properties instead of 'sprd,inner-resist' and
>    'sprd,ocv-cap-table'.
>  - Remove battery node's description.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
