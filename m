From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCH] thermal: exynos: Disable the regulator on probe failure
Date: Mon, 8 Jun 2015 08:54:44 +0200
Message-ID: <CABxcv=me__Nor+grdD+GaGJNZT5hRt6Tq7VBN1=yNzj+qw-zww@mail.gmail.com>
References: <1433727349-23330-1-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1433727349-23330-1-git-send-email-k.kozlowski@samsung.com>
Sender: stable-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Lukasz Majewski <l.majewski@samsung.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Kukjin Kim <kgene@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux Kernel <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hello Krzysztof,

On Mon, Jun 8, 2015 at 3:35 AM, Krzysztof Kozlowski
<k.kozlowski@samsung.com> wrote:
> During probe the regulator (if present) was enabled but not disabled in
> case of failure. So an unsuccessful probe lead to enabling the
> regulator which was actually not needed because the device was not
> enabled.
>
> Additionally each deferred probe lead to increase of regulator enable
> count so it would not be effectively disabled during removal of the
> device.
>
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Fixes: 498d22f616f6 ("thermal: exynos: Support for TMU regulator defined at device tree")
> Cc: <stable@vger.kernel.org>
>

Reviewed-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>

> ---
>
> I am not entirely convinced that this should go to stable. Leaving a
> regulator enabled in case of probe failure (no exynos TMU device) or
> after deferred probe (regulator won't be disabled during device removal)
> is not a critical issue, just leaks power.


Yes, as you said leaving the regulator enabled is not critical but
OTOH is a very small patch and is fixing a very evident bug so I think
it's OK.

Best regards,
Javier
