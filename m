From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v6 2/4] power: supply: Add support for the Qualcomm
 Battery Monitoring System
Date: Thu, 14 Jun 2018 16:06:40 +0200
Message-ID: <CACRpkdYzCN1cFBDwznO6p-US1B94+kbBcWmH-o-qxvXdvCCsiw@mail.gmail.com>
References: <20180407135934.26122-1-ctatlor97@gmail.com> <20180613160643.12638-1-ctatlor97@gmail.com>
 <20180613160643.12638-2-ctatlor97@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180613160643.12638-2-ctatlor97@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Craig Tatlor <ctatlor97@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "David S. Miller" <davem@davemloft.net>, Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, Linux PM list <linux-pm@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Jun 13, 2018 at 6:06 PM, Craig Tatlor <ctatlor97@gmail.com> wrote:

> This patch adds a driver for the BMS (Battery Monitoring System)
> block of the PM8941 PMIC, it uses a lookup table defined in the
> device tree to generate a capacity from the BMS supplied OCV, it
> then amends the coulomb counter to that to increase the accuracy
> of the estimated capacity.
>
> Signed-off-by: Craig Tatlor <ctatlor97@gmail.com>
> ---
>
> * Changes from v5:
>   Uses select for REGMAP_SPMI.

Looks very nice to me!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
