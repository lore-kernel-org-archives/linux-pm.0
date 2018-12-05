From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v10 1/7] interconnect: Add generic on-chip interconnect API
Date: Wed, 5 Dec 2018 10:16:20 -0600
Message-ID: <CAL_JsqJyPH9WVw2VqGTjUvhxoq3+KGpfqtAMf9iH07N7m3P4yw@mail.gmail.com>
References: <20181127180349.29997-1-georgi.djakov@linaro.org> <20181127180349.29997-2-georgi.djakov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181127180349.29997-2-georgi.djakov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Georgi Djakov <georgi.djakov@linaro.org>
Cc: "open list:THERMAL" <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Michael Turquette <mturquette@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, Vincent Guittot <vincent.guittot@linaro.org>, Saravana Kannan <skannan@codeaurora.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, seansw@qti.qualcomm.com, daidavid1@codeaurora.org, Evan Green <evgreen@chromium.org>, Mark Rutland <mark.rutland@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Alexandre Bailon <abailon@baylibre.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Arnd Bergmann <arnd@arndb.de>, Thierry Reding <thierry.reding@gmail.com>, ksitaraman@nvidia.com, sanjayc@nvidi
List-Id: linux-pm@vger.kernel.org

On Tue, Nov 27, 2018 at 12:03 PM Georgi Djakov <georgi.djakov@linaro.org> wrote:
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
> Reviewed-by: Evan Green <evgreen@chromium.org>

[...]

> +struct icc_path *icc_get(struct device *dev, const int src_id,
> +                        const int dst_id);
> +void icc_put(struct icc_path *path);
> +int icc_set(struct icc_path *path, u32 avg_bw, u32 peak_bw);

icc_set() is very generic, but this function isn't easily extended to
other parameters than bandwidth. Perhaps icc_set_bandwidth() instead.
Then when you add some other setting, you just add a new function. Of
course, if you wind up with a bunch of different parameters, then
you'll probably need an atomic type interface where you test all the
settings together and then commit them separately in one call. But
from a DT perspective, I certainly hope there are not lots of new
settings folks want to add. :)

Rob
