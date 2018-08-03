From: Evan Green <evgreen@chromium.org>
Subject: Re: [PATCH v7 6/8] interconnect: qcom: Add msm8916 interconnect
 provider driver
Date: Fri, 3 Aug 2018 15:59:42 -0700
Message-ID: <CAE=gft6eTnCm2CoUkhG8COHC+rMdrWGf2A+PqZYB+gq4djm5xQ@mail.gmail.com>
References: <20180731161340.13000-1-georgi.djakov@linaro.org> <20180731161340.13000-7-georgi.djakov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180731161340.13000-7-georgi.djakov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: georgi.djakov@linaro.org
Cc: linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, rjw@rjwysocki.net, robh+dt@kernel.org, Michael Turquette <mturquette@baylibre.com>, khilman@baylibre.com, Vincent Guittot <vincent.guittot@linaro.org>, Saravana Kannan <skannan@codeaurora.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, amit.kucheria@linaro.org, seansw@qti.qualcomm.com, daidavid1@codeaurora.org, mark.rutland@arm.com, lorenzo.pieralisi@arm.com, Alexandre Bailon <abailon@baylibre.com>, arnd@arndb.de, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, Jul 31, 2018 at 9:13 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
>
> Add driver for the Qualcomm interconnect buses found in msm8916 based
> platforms.
>
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
>  drivers/interconnect/Kconfig        |   5 +
>  drivers/interconnect/Makefile       |   1 +
>  drivers/interconnect/qcom/Kconfig   |   9 +
>  drivers/interconnect/qcom/Makefile  |   2 +
>  drivers/interconnect/qcom/msm8916.c | 510 ++++++++++++++++++++++++++++
>  5 files changed, 527 insertions(+)
>  create mode 100644 drivers/interconnect/qcom/msm8916.c
>

Reviewed-by: Evan Green <evgreen@chromium.org>
