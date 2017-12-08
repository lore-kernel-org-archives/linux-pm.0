From: Amit Kucheria <amit.kucheria@verdurent.com>
Subject: Re: [PATCH v3 1/3] interconnect: Add generic on-chip interconnect API
Date: Sat, 9 Dec 2017 00:08:22 +0530
Message-ID: <CAHLCerOgm+T6S1pxjo5hFajyU+vqUgBFcwfuBCsphgECRMf3Yw@mail.gmail.com>
References: <20170908171830.13813-1-georgi.djakov@linaro.org> <20170908171830.13813-2-georgi.djakov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ot0-f196.google.com ([74.125.82.196]:38448 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752270AbdLHSiX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 8 Dec 2017 13:38:23 -0500
Received: by mail-ot0-f196.google.com with SMTP id p3so9906918oti.5
        for <linux-pm@vger.kernel.org>; Fri, 08 Dec 2017 10:38:23 -0800 (PST)
In-Reply-To: <20170908171830.13813-2-georgi.djakov@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Georgi Djakov <georgi.djakov@linaro.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, gregkh@linuxfoundation.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, robh+dt@kernel.org, khilman@baylibre.com, Michael Turquette <mturquette@baylibre.com>, Vincent Guittot <vincent.guittot@linaro.org>, Saravana Kannan <skannan@codeaurora.org>, Stephen Boyd <sboyd@codeaurora.org>, Andy Gross <andy.gross@linaro.org>, seansw@qti.qualcomm.com, davidai@quicinc.com, LKML <linux-kernel@vger.kernel.org>, lakml <linux-arm-kernel@lists.infradead.org>, linux-arm-msm@vger.kernel.org, mark.rutland@arm.com, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

On Fri, Sep 8, 2017 at 10:48 PM, Georgi Djakov <georgi.djakov@linaro.org> wrote:
> This patch introduce a new API to get requirements and configure the
> interconnect buses across the entire chipset to fit with the current demand.
>
> The API is using a consumer/provider-based model, where the providers are
> the interconnect buses and the consumers could be various drivers.
> The consumers request interconnect resources (path) between endpoints and
> set the desired constraints on this data flow path. The providers receive
> requests from consumers and aggregate these requests for all master-slave
> pairs on that path. Then the providers configure each participating in the
> topology node according to the requested data flow path, physical links and
> constraints. The topology could be complicated and multi-tiered and is SoC
> specific.
>
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
>  Documentation/interconnect/interconnect.rst |  93 +++++++
>  drivers/Kconfig                             |   2 +
>  drivers/Makefile                            |   1 +
>  drivers/interconnect/Kconfig                |  10 +
>  drivers/interconnect/Makefile               |   1 +
>  drivers/interconnect/interconnect.c         | 382 ++++++++++++++++++++++++++++
>  include/linux/interconnect-consumer.h       |  73 ++++++
>  include/linux/interconnect-provider.h       | 119 +++++++++
>  8 files changed, 681 insertions(+)
>  create mode 100644 Documentation/interconnect/interconnect.rst
>  create mode 100644 drivers/interconnect/Kconfig
>  create mode 100644 drivers/interconnect/Makefile
>  create mode 100644 drivers/interconnect/interconnect.c
>  create mode 100644 include/linux/interconnect-consumer.h
>  create mode 100644 include/linux/interconnect-provider.h
>

<snip>

> diff --git a/include/linux/interconnect-consumer.h b/include/linux/interconnect-consumer.h
> new file mode 100644
> index 000000000000..6e71bf7a63c0
> --- /dev/null
> +++ b/include/linux/interconnect-consumer.h
> @@ -0,0 +1,73 @@
> +/*
> + * Copyright (c) 2017, Linaro Ltd.
> + *
> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#ifndef _LINUX_INTERCONNECT_CONSUMER_H
> +#define _LINUX_INTERCONNECT_CONSUMER_H
> +
> +struct interconnect_node;
> +struct interconnect_path;
> +
> +#if IS_ENABLED(CONFIG_INTERCONNECT)
> +
> +struct interconnect_path *interconnect_get(const char *sdev, const int sid,
> +                                          const char *ddev, const int did);
> +
> +void interconnect_put(struct interconnect_path *path);
> +
> +/**
> + * struct creq - interconnect consumer request
> + * @avg_bw: the average requested bandwidth (over longer period of time) in kbps
> + * @peak_bw: the peak (maximum) bandwidth in kpbs
> + */
> +struct interconnect_creq {
> +       u32 avg_bw;
> +       u32 peak_bw;
> +};
> +
> +/**
> + * interconnect_set() - set constraints on a path between two endpoints
> + * @path: reference to the path returned by interconnect_get()
> + * @creq: request from the consumer, containing its requirements
> + *
> + * This function is used by an interconnect consumer to express its own needs
> + * in term of bandwidth and QoS for a previously requested path between two
> + * endpoints. The requests are aggregated and each node is updated accordingly.
> + *
> + * Returns 0 on success, or an approproate error code otherwise.
> + */
> +int interconnect_set(struct interconnect_path *path,
> +                    struct interconnect_creq *creq);
> +
> +#else
> +
> +inline struct interconnect_path *interconnect_get(const char *sdev,
> +                                                        const int sid,
> +                                                        const char *ddev,
> +                                                        const int did)
> +{
> +       return ERR_PTR(-ENOTSUPP);
> +}
> +
> +inline void interconnect_put(struct interconnect_path *path)
> +{
> +}
> +
> +inline int interconnect_set(struct interconnect_path *path,
> +                           struct interconnect_creq *creq);

Remove the semi colon

> +{
> +       return -ENOTSUPP

return ERR_PTR(-ENOTSUPP);

> +}
> +

This breaks the build with INTERCONNECT disabled in Kconfig.
