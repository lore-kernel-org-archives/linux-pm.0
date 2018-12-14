From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v12 2/7] dt-bindings: Introduce interconnect binding
Date: Fri, 14 Dec 2018 09:04:16 -0600
Message-ID: <CAL_JsqLG32ZE2Ljfkz5wC_yfs4NVWYA0VfQPaB9Q-3=vFjO4=Q@mail.gmail.com>
References: <20181208170216.32555-1-georgi.djakov@linaro.org> <20181208170216.32555-3-georgi.djakov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181208170216.32555-3-georgi.djakov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Georgi Djakov <georgi.djakov@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andy Gross <andy.gross@linaro.org>, Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>, "open list:THERMAL" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Michael Turquette <mturquette@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, Vincent Guittot <vincent.guittot@linaro.org>, Saravana Kannan <skannan@codeaurora.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, seansw@qti.qualcomm.com, daidavid1@codeaurora.org, Evan Green <evgreen@chromium.org>, Doug Anderson <dianders@chromium.org>, Mark Rutland <mark.rutland@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Alexandre Bailon <abailon@baylibre.com>, Maxime
List-Id: linux-pm@vger.kernel.org

On Sat, Dec 8, 2018 at 11:02 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
>
> This binding is intended to represent the relations between interconnect
> controllers (providers) and consumer device nodes. It will allow creating
> links between consumers and interconnect paths (exposed by interconnect
> providers).
>
> Reviewed-by: Evan Green <evgreen@chromium.org>
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
>  .../bindings/interconnect/interconnect.txt    | 60 +++++++++++++++++++
>  1 file changed, 60 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interconnect/interconnect.txt

Reviewed-by: Rob Herring <robh@kernel.org>
