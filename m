From: Georgi Djakov <georgi.djakov@linaro.org>
Subject: Re: [PATCH v12 0/7] Introduce on-chip interconnect API
Date: Sun, 9 Dec 2018 07:15:35 +0200
Message-ID: <19e55a84-08d9-8cfa-02cb-be963f08ca61@linaro.org>
References: <20181208170216.32555-1-georgi.djakov@linaro.org>
 <CAOesGMgZYheG77L_nuNtTA8xY-PtDpseHOKf8kCjusiYsv5Mmw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAOesGMgZYheG77L_nuNtTA8xY-PtDpseHOKf8kCjusiYsv5Mmw@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Olof Johansson <olof@lixom.net>
Cc: Mark Rutland <mark.rutland@arm.com>, sanjayc@nvidia.com, Maxime Ripard <maxime.ripard@bootlin.com>, Michael Turquette <mturquette@baylibre.com>, daidavid1@codeaurora.org, Bjorn Andersson <bjorn.andersson@linaro.org>, Saravana Kannan <skannan@codeaurora.org>, Alexandre Bailon <abailon@baylibre.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, seansw@qti.qualcomm.com, Kevin Hilman <khilman@baylibre.com>, evgreen@chromium.org, ksitaraman@nvidia.com, DTML <devicetree@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-pm@vger.kernel.org, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Andy Gross <andy.gross@linaro.org>, Rob Herring <robh+dt@kernel.org>, linux-tegra@vger.kernel.org, Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rjw@rjwys>
List-Id: linux-pm@vger.kernel.org

Hi Olof,

On 9.12.18 2:33, Olof Johansson wrote:
> Hi Georgi,
> 
> On Sat, Dec 8, 2018 at 9:02 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
>>
>> Modern SoCs have multiple processors and various dedicated cores (video, gpu,
>> graphics, modem). These cores are talking to each other and can generate a
>> lot of data flowing through the on-chip interconnects. These interconnect
>> buses could form different topologies such as crossbar, point to point buses,
>> hierarchical buses or use the network-on-chip concept.
>>
>> These buses have been sized usually to handle use cases with high data
>> throughput but it is not necessary all the time and consume a lot of power.
>> Furthermore, the priority between masters can vary depending on the running
>> use case like video playback or CPU intensive tasks.
>>
>> Having an API to control the requirement of the system in terms of bandwidth
>> and QoS, so we can adapt the interconnect configuration to match those by
>> scaling the frequencies, setting link priority and tuning QoS parameters.
>> This configuration can be a static, one-time operation done at boot for some
>> platforms or a dynamic set of operations that happen at run-time.
>>
>> This patchset introduce a new API to get the requirement and configure the
>> interconnect buses across the entire chipset to fit with the current demand.
>> The API is NOT for changing the performance of the endpoint devices, but only
>> the interconnect path in between them.
>>
>> The API is using a consumer/provider-based model, where the providers are
>> the interconnect buses and the consumers could be various drivers.
>> The consumers request interconnect resources (path) to an endpoint and set
>> the desired constraints on this data flow path. The provider(s) receive
>> requests from consumers and aggregate these requests for all master-slave
>> pairs on that path. Then the providers configure each participating in the
>> topology node according to the requested data flow path, physical links and
>> constraints. The topology could be complicated and multi-tiered and is SoC
>> specific.
> 
> This patch series description fails to describe why you need a brand
> new subsystem for this instead of either using one of the current
> ones, or adapting it to fit the needs you have.
> 
> Primarily, I'm wondering what's missing from drivers/devfreq to fit your needs?

The devfreq subsystem seems to be more oriented towards a device (like GPU or CPU) that controls the power/performance characteristics by itself and not the performance of other devices. The main problem of using it is that it's using a reactive approach - for example monitor some performance counters and then reconfigure bandwidth after some bottleneck has already occurred. This is suboptimal and might not work well. The new solution does the opposite by allowing drivers to express their needs in advance and be proactive. Devfreq also does not seem suitable for configuring complex, multi-tiered bus topologies and aggregating constraints provided by drivers.

> The series also doesn't seem to provide any kind of indication how
> this will be used by end points. You have one driver for one SoC that
> just contains large tables that are parsed at probe time, but no
> driver hooks anywhere that will actually change any settings depending
> on use cases. Also, the bindings as posted don't seem to include any
> of this kind of information. So it's hard to get a picture of how this
> is going to be used in reality, which makes it hard to judge whether
> it is a good solution or not.

Here are links to some of the examples that are on the mailing list already. I really should have  included them in the cover letter. 
https://lkml.org/lkml/2018/12/7/584
https://lkml.org/lkml/2018/10/11/499
https://lkml.org/lkml/2018/9/20/986
https://lkml.org/lkml/2018/11/22/772

Platforms drivers for different SoCs are available:
https://lkml.org/lkml/2018/11/17/368
https://lkml.org/lkml/2018/8/10/380
There is a discussion on linux-pm about supporting also Tegra platforms in addition to NXP and Qualcomm.

> Overall, exposing all of this to software is obviously a nightmare
> from a complexity point of view, and one in which it will surely be
> very very hard to make the system behave properly for generic
> workloads beyond benchmark tuning.

It allows the consumer drivers to dynamically express their performance needs in the system in a more fine grained way (if they want/need to) and this helps the system to keep the lowest power profile. This has already been done for a long time in various different kernels shipping with Android devices, for example, and basically every vendor uses a different custom approach. So I believe that this is doing the generalization that was needed.

> Having more information about the above would definitely help tell if
> this whole effort is a step in the right direction, or if it is
> needless complexity that is better solved in other ways.

Sure, hope that this answers your questions.

Thanks,
Georgi

> 
> -Olof
> 
