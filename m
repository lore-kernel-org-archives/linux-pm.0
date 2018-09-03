From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v2 2/2] power: supply: Add Spreadtrum SC2731 charger support
Date: Mon, 3 Sep 2018 12:20:26 +0200
Message-ID: <CAJKOXPf+Y+QLVJ+jUBcUFeBsxXQxK62UNQ9P+gFbP3RLCBz+wQ@mail.gmail.com>
References: <a582871f84c4dd588ae1651d1d9192cc80e2b272.1535964281.git.baolin.wang@linaro.org>
 <22074e17cb853123f926e909eac4418d88af0b98.1535964281.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <22074e17cb853123f926e909eac4418d88af0b98.1535964281.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: baolin.wang@linaro.org
Cc: sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, yuanjiang.yu@unisoc.com, broonie@kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, 3 Sep 2018 at 10:56, Baolin Wang <baolin.wang@linaro.org> wrote:
>
> This patch adds the SC2731 PMIC switch charger support.
>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
> Changes from v1:
>  - Remove some redundant head files.
>  - Add one mutex to make sure getting the charger status is correct.
>  - Fix some coding style issues.
>  - Use standard DT properties.
> ---
>  drivers/power/supply/Kconfig          |    7 +
>  drivers/power/supply/Makefile         |    1 +
>  drivers/power/supply/sc2731_charger.c |  503 +++++++++++++++++++++++++++++++++
>  3 files changed, 511 insertions(+)
>  create mode 100644 drivers/power/supply/sc2731_charger.c

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
