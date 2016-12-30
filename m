From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: Re: [PATCH v2 3/8] PM / devfreq: exynos-bus: Print the real clock
 rate of bus
Date: Fri, 30 Dec 2016 19:33:42 +0900
Message-ID: <CAJ0PZbQS9VYEiHV60hhxqhNiCFdjGZQPFoLtjeQzM8+8f+apdw@mail.gmail.com>
References: <CGME20161228115654epcas1p159c2daa73a697956085cb4b9fcd46e7d@epcas1p1.samsung.com>
 <1482926212-19223-1-git-send-email-cw00.choi@samsung.com> <1482926212-19223-4-git-send-email-cw00.choi@samsung.com>
Reply-To: myungjoo.ham@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1482926212-19223-4-git-send-email-cw00.choi@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>, chanwoo@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Linux Samsung SoC <linux-samsung-soc@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Dec 28, 2016 at 8:56 PM, Chanwoo Choi <cw00.choi@samsung.com> wrote:
> This patch shows the real clock rate after calling clk_set_rate()
> to debug it.
>
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Javier Martinez Canillas <javier@osg.samsung.com>
> Cc: linux-samsung-soc@vger.kernel.org
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>

Acked-by: MyungJoo Ham <myungjoo.ham@gmail.com>


> ---
>  drivers/devfreq/exynos-bus.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
