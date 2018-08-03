From: Evan Green <evgreen@chromium.org>
Subject: Re: [PATCH v7 3/8] interconnect: Add debugfs support
Date: Fri, 3 Aug 2018 15:59:22 -0700
Message-ID: <CAE=gft5Fkp485u6NVDf_cOfxmUgmLM3KtoXZHe0u77o8nFJLmQ@mail.gmail.com>
References: <20180731161340.13000-1-georgi.djakov@linaro.org> <20180731161340.13000-4-georgi.djakov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180731161340.13000-4-georgi.djakov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: georgi.djakov@linaro.org
Cc: linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, rjw@rjwysocki.net, robh+dt@kernel.org, Michael Turquette <mturquette@baylibre.com>, khilman@baylibre.com, Vincent Guittot <vincent.guittot@linaro.org>, Saravana Kannan <skannan@codeaurora.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, amit.kucheria@linaro.org, seansw@qti.qualcomm.com, daidavid1@codeaurora.org, mark.rutland@arm.com, lorenzo.pieralisi@arm.com, Alexandre Bailon <abailon@baylibre.com>, arnd@arndb.de, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, Jul 31, 2018 at 9:13 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
>
> Add a functionality to provide information about the current constraints
> per each node and provider.
>
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
>  drivers/interconnect/core.c | 78 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 78 insertions(+)
>

Reviewed-by: Evan Green <evgreen@chromium.org>
