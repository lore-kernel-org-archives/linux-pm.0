From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: Re: [PATCH v4 7/8] PM / devfreq: Define the constant governor name
Date: Wed, 18 Oct 2017 00:02:21 +0900
Message-ID: <CAJ0PZbTBmTB+N-p_2bJ5vjTj2uNBmjq5An5fBD2_nTCkW3O1kQ@mail.gmail.com>
References: <CGME20171013074836epcas2p4e70bca2ebe9446353abf5c14a9d16460@epcas2p4.samsung.com>
 <1507880904-31956-1-git-send-email-cw00.choi@samsung.com> <1507880904-31956-8-git-send-email-cw00.choi@samsung.com>
Reply-To: myungjoo.ham@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1507880904-31956-8-git-send-email-cw00.choi@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, chanwoo@kernel.org, =?UTF-8?B?64yA7J246riw?= <inki.dae@samsung.com>, LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Linux Samsung SoC <linux-samsung-soc@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Oct 13, 2017 at 4:48 PM, Chanwoo Choi <cw00.choi@samsung.com> wrote:
> Prior to that, the devfreq device uses the governor name when adding
> the itself. In order to prevent the mistake used the wrong governor name,
> this patch defines the governor name as a constant and then uses them
> instead of using the string directly.
>
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: linux-samsung-soc@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org

Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>

> ---
>  drivers/devfreq/exynos-bus.c              | 5 +++--
>  drivers/devfreq/governor_passive.c        | 2 +-
>  drivers/devfreq/governor_performance.c    | 2 +-
>  drivers/devfreq/governor_powersave.c      | 2 +-
>  drivers/devfreq/governor_simpleondemand.c | 2 +-
>  drivers/devfreq/governor_userspace.c      | 2 +-
>  drivers/devfreq/rk3399_dmc.c              | 2 +-
>  include/linux/devfreq.h                   | 7 +++++++
>  8 files changed, 16 insertions(+), 8 deletions(-)
>
[]


-- 
MyungJoo Ham, Ph.D.
S/W Center, Samsung Electronics
