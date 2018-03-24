From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v1 11/16] rtc: mediatek: move the declaration into a
 globally visible header file
Date: Sat, 24 Mar 2018 17:00:02 -0300
Message-ID: <CAOMZO5DuVpcCrQYzoWfN=ZqXeTGC-U1FfwoDFxhQ8frno5-1GQ@mail.gmail.com>
References: <cover.1521794176.git.sean.wang@mediatek.com> <53afbe8172fb1afd809ce9ba1afeda924b9ea705.1521794177.git.sean.wang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <53afbe8172fb1afd809ce9ba1afeda924b9ea705.1521794177.git.sean.wang@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: sean.wang@mediatek.com
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Sebastian Reichel <sre@kernel.org>, Lee Jones <lee.jones@linaro.org>, Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, eddie.huang@mediatek.com, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, "open list:REAL TIME CLOCK (RTC) SUBSYSTEM" <linux-rtc@vger.kernel.org>, linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Mar 23, 2018 at 6:15 AM,  <sean.wang@mediatek.com> wrote:

> --- /dev/null
> +++ b/include/linux/rtc/mt6397.h
> @@ -0,0 +1,72 @@
> +
> +// SPDX-License-Identifier: GPL-2.0

According to Documentation/process/license-rules.rst the SPDX notation
for C header file should be:

/* SPDX-License-Identifier: GPL-2.0 */
