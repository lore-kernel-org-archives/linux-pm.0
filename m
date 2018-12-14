From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v12 5/7] interconnect: qcom: Add sdm845 interconnect
 provider driver
Date: Fri, 14 Dec 2018 09:07:02 -0600
Message-ID: <CAL_JsqJrCBDegU5CpFfDrZeyfcbAAdhcn2AscrVA=uK7XqkvGw@mail.gmail.com>
References: <20181208170216.32555-1-georgi.djakov@linaro.org> <20181208170216.32555-6-georgi.djakov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181208170216.32555-6-georgi.djakov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Georgi Djakov <georgi.djakov@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andy Gross <andy.gross@linaro.org>, Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>, "open list:THERMAL" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Michael Turquette <mturquette@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, Vincent Guittot <vincent.guittot@linaro.org>, Saravana Kannan <skannan@codeaurora.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, seansw@qti.qualcomm.com, daidavid1@codeaurora.org, Evan Green <evgreen@chromium.org>, Doug Anderson <dianders@chromium.org>, Mark Rutland <mark.rutland@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Alexandre Bailon <abailon@baylibre.com>, Maxime
List-Id: linux-pm@vger.kernel.org

On Sat, Dec 8, 2018 at 11:02 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
>
> From: David Dai <daidavid1@codeaurora.org>
>
> Introduce Qualcomm SDM845 specific provider driver using the
> interconnect framework.
>
> Signed-off-by: David Dai <daidavid1@codeaurora.org>
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
>  .../bindings/interconnect/qcom,sdm845.txt     |  24 +

This and the binding header should have been a separate patch, but I'm
not going to tell you that now on v12.

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/interconnect/Kconfig                  |   5 +
>  drivers/interconnect/Makefile                 |   1 +
>  drivers/interconnect/qcom/Kconfig             |  13 +
>  drivers/interconnect/qcom/Makefile            |   5 +
>  drivers/interconnect/qcom/sdm845.c            | 838 ++++++++++++++++++
>  .../dt-bindings/interconnect/qcom,sdm845.h    | 143 +++
>  7 files changed, 1029 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sdm845.txt
>  create mode 100644 drivers/interconnect/qcom/Kconfig
>  create mode 100644 drivers/interconnect/qcom/Makefile
>  create mode 100644 drivers/interconnect/qcom/sdm845.c
>  create mode 100644 include/dt-bindings/interconnect/qcom,sdm845.h
