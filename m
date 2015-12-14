From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: Re: [PATCH] clk: exynos: use irqsave version of spin_lock to avoid
 deadlock with irqs
Date: Mon, 14 Dec 2015 20:02:54 +0900
Message-ID: <CA+Ln22Fgn3JjbQ0MgMdsZk_4xsAy3Y6i2DEqm6WN2ORuJYZCPQ@mail.gmail.com>
References: <1449844798-27384-1-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1449844798-27384-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Mike Turquette <mturquette@baylibre.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Viresh Kumar <viresh.kumar@linaro.org>, Thomas Abraham <thomas.ab@samsung.com>, Ben Gamari <ben@smart-cactus.org>, Lukasz Majewski <l.majewski@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Kevin Hilman <khilman@linaro.org>, stable@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Marek,

2015-12-11 23:38 GMT+09:00 Marek Szyprowski <m.szyprowski@samsung.com>:
> It is allowed to enable/disable clocks from interrupts, so common Exynos
> ARM clock management code for CPUfreq should use 'irqsave' version of
> spin_lock calls to avoid potential deadlock caused by spin_lock recursion.
> The same spin_lock is used by gate/mux clocks during enable/disable calls.
>
> This deadlock, can be reproduced by enabling CPUfreq (ondemand or
> userspace) and decoding video with s5p-mfc driver.

Good catch.

Acked-by: Tomasz Figa <tomasz.figa@gmail.com>

Best regards,
Tomasz
