From: Evan Green <evgreen@chromium.org>
Subject: Re: [PATCH v7 1/8] interconnect: Add generic on-chip interconnect API
Date: Fri, 3 Aug 2018 15:59:15 -0700
Message-ID: <CAE=gft5vxheWYyF2JODuGAKcfHfYOS6sg-vCar=dZG5tFm9SVw@mail.gmail.com>
References: <20180731161340.13000-1-georgi.djakov@linaro.org> <20180731161340.13000-2-georgi.djakov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180731161340.13000-2-georgi.djakov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: georgi.djakov@linaro.org
Cc: linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, rjw@rjwysocki.net, robh+dt@kernel.org, Michael Turquette <mturquette@baylibre.com>, khilman@baylibre.com, Vincent Guittot <vincent.guittot@linaro.org>, Saravana Kannan <skannan@codeaurora.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, amit.kucheria@linaro.org, seansw@qti.qualcomm.com, daidavid1@codeaurora.org, mark.rutland@arm.com, lorenzo.pieralisi@arm.com, Alexandre Bailon <abailon@baylibre.com>, arnd@arndb.de, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, Jul 31, 2018 at 9:13 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
>
> This patch introduces a new API to get requirements and configure the
> interconnect buses across the entire chipset to fit with the current
> demand.
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
>  Documentation/interconnect/interconnect.rst |  96 ++++
>  drivers/Kconfig                             |   2 +
>  drivers/Makefile                            |   1 +
>  drivers/interconnect/Kconfig                |  10 +
>  drivers/interconnect/Makefile               |   2 +
>  drivers/interconnect/core.c                 | 569 ++++++++++++++++++++
>  include/linux/interconnect-provider.h       | 125 +++++
>  include/linux/interconnect.h                |  42 ++
>  8 files changed, 847 insertions(+)
>  create mode 100644 Documentation/interconnect/interconnect.rst
>  create mode 100644 drivers/interconnect/Kconfig
>  create mode 100644 drivers/interconnect/Makefile
>  create mode 100644 drivers/interconnect/core.c
>  create mode 100644 include/linux/interconnect-provider.h
>  create mode 100644 include/linux/interconnect.h
>

Thanks Georgi. This looks great!

Reviewed-by: Evan Green <evgreen@chromium.org>
