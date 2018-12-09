From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v12 0/7] Introduce on-chip interconnect API
Date: Sat, 8 Dec 2018 16:33:46 -0800
Message-ID: <CAOesGMgZYheG77L_nuNtTA8xY-PtDpseHOKf8kCjusiYsv5Mmw@mail.gmail.com>
References: <20181208170216.32555-1-georgi.djakov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181208170216.32555-1-georgi.djakov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Georgi Djakov <georgi.djakov@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andy Gross <andy.gross@linaro.org>, Arnd Bergmann <arnd@arndb.de>, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Rob Herring <robh+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, Vincent Guittot <vincent.guittot@linaro.org>, Saravana Kannan <skannan@codeaurora.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, seansw@qti.qualcomm.com, daidavid1@codeaurora.org, evgreen@chromium.org, Doug Anderson <dianders@chromium.org>, Mark Rutland <mark.rutland@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Alexandre Bailon <abailon@baylibre.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Thier
List-Id: linux-pm@vger.kernel.org

Hi Georgi,

On Sat, Dec 8, 2018 at 9:02 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
>
> Modern SoCs have multiple processors and various dedicated cores (video, gpu,
> graphics, modem). These cores are talking to each other and can generate a
> lot of data flowing through the on-chip interconnects. These interconnect
> buses could form different topologies such as crossbar, point to point buses,
> hierarchical buses or use the network-on-chip concept.
>
> These buses have been sized usually to handle use cases with high data
> throughput but it is not necessary all the time and consume a lot of power.
> Furthermore, the priority between masters can vary depending on the running
> use case like video playback or CPU intensive tasks.
>
> Having an API to control the requirement of the system in terms of bandwidth
> and QoS, so we can adapt the interconnect configuration to match those by
> scaling the frequencies, setting link priority and tuning QoS parameters.
> This configuration can be a static, one-time operation done at boot for some
> platforms or a dynamic set of operations that happen at run-time.
>
> This patchset introduce a new API to get the requirement and configure the
> interconnect buses across the entire chipset to fit with the current demand.
> The API is NOT for changing the performance of the endpoint devices, but only
> the interconnect path in between them.
>
> The API is using a consumer/provider-based model, where the providers are
> the interconnect buses and the consumers could be various drivers.
> The consumers request interconnect resources (path) to an endpoint and set
> the desired constraints on this data flow path. The provider(s) receive
> requests from consumers and aggregate these requests for all master-slave
> pairs on that path. Then the providers configure each participating in the
> topology node according to the requested data flow path, physical links and
> constraints. The topology could be complicated and multi-tiered and is SoC
> specific.

This patch series description fails to describe why you need a brand
new subsystem for this instead of either using one of the current
ones, or adapting it to fit the needs you have.

Primarily, I'm wondering what's missing from drivers/devfreq to fit your needs?

The series also doesn't seem to provide any kind of indication how
this will be used by end points. You have one driver for one SoC that
just contains large tables that are parsed at probe time, but no
driver hooks anywhere that will actually change any settings depending
on use cases. Also, the bindings as posted don't seem to include any
of this kind of information. So it's hard to get a picture of how this
is going to be used in reality, which makes it hard to judge whether
it is a good solution or not.

Overall, exposing all of this to software is obviously a nightmare
from a complexity point of view, and one in which it will surely be
very very hard to make the system behave properly for generic
workloads beyond benchmark tuning.

Having more information about the above would definitely help tell if
this whole effort is a step in the right direction, or if it is
needless complexity that is better solved in other ways.


-Olof
