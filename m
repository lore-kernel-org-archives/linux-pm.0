From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: Re: [PATCH] devfreq: Use of_node_name_eq for node name comparisons
Date: Sun, 16 Dec 2018 18:12:11 +0900
Message-ID: <CAJ0PZbQRNGoKsMZjpwaemzpK677v0T5n6h9OtZMdd5UTvq-drA@mail.gmail.com>
References: <20181205195050.4759-6-robh@kernel.org>
Reply-To: myungjoo.ham@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181205195050.4759-6-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Linux Samsung SoC <linux-samsung-soc@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Dec 6, 2018 at 4:54 AM Rob Herring <robh@kernel.org> wrote:
>
> Convert string compares of DT node names to use of_node_name_eq helper
> instead. This removes direct access to the node name pointer.
>
> For instances using of_node_cmp, this has the side effect of now using
> case sensitive comparisons. This should not matter for any FDT based
> system which all of these are.
>
> Cc: Chanwoo Choi <cw00.choi@samsung.com>
> Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
> Cc: Kyungmin Park <kyungmin.park@samsung.com>
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: linux-pm@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-samsung-soc@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>

Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>

> ---
>  drivers/devfreq/devfreq-event.c     | 2 +-
>  drivers/devfreq/event/exynos-ppmu.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
