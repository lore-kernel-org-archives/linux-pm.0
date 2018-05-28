From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: RE: [PATCH 03/11] PM / devfreq: Remove check for df->max_freq == 0
 from governors
Date: Mon, 28 May 2018 13:51:21 +0900
Message-ID: <20180528045121epcms1p2f7bf3a2f366a85364753e47858cad632@epcms1p2>
References: <20180525203043.249193-4-mka@chromium.org>
        <20180525203043.249193-1-mka@chromium.org>
        <CGME20180525203122epcas3p42a494949f50aa933355840b7e46bb0fe@epcms1p2>
Reply-To: myungjoo.ham@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180525203043.249193-4-mka@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Brian Norris <briannorris@chromium.org>, Douglas Anderson <dianders@chromium.org>, Matthias Kaehlcke <mka@chromium.org>
List-Id: linux-pm@vger.kernel.org

>Commit "PM / devfreq: Fix handling of min/max_freq == 0" ensures that
>df->max_freq is not 0, remove unnecessary checks.
>
>Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
>---
> drivers/devfreq/governor_performance.c    | 5 +----
> drivers/devfreq/governor_simpleondemand.c | 7 +++----
> 2 files changed, 4 insertions(+), 8 deletions(-)
>
>diff --git a/drivers/devfreq/governor_performance.c b/drivers/devfreq/governor_performance.c
>index 4d23ecfbd948..1c990cb45098 100644
>

Thanks!

Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>
