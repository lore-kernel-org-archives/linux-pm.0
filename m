From: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH v3 1/3] interconnect: Add generic on-chip interconnect API
Date: Fri, 20 Oct 2017 15:34:53 -0700
Message-ID: <20171020223452.GD1165@minitux>
References: <20170908171830.13813-1-georgi.djakov@linaro.org>
 <20170908171830.13813-2-georgi.djakov@linaro.org>
 <a7cf55ba-0475-d74c-f759-a24e58ccde47@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <a7cf55ba-0475-d74c-f759-a24e58ccde47@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Georgi Djakov <georgi.djakov@linaro.org>
Cc: linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, rjw@rjwysocki.net, robh+dt@kernel.org, khilman@baylibre.com, mturquette@baylibre.com, vincent.guittot@linaro.org, skannan@codeaurora.org, sboyd@codeaurora.org, andy.gross@linaro.org, seansw@qti.qualcomm.com, davidai@quicinc.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, mark.rutland@arm.com, lorenzo.pieralisi@arm.com
List-Id: linux-pm@vger.kernel.org

On Fri 20 Oct 07:43 PDT 2017, Georgi Djakov wrote:

> Hi,
> 
> On 09/08/2017 08:18 PM, Georgi Djakov wrote:
> > This patch introduce a new API to get requirements and configure the
> > interconnect buses across the entire chipset to fit with the current demand.
> > 
> > The API is using a consumer/provider-based model, where the providers are
> > the interconnect buses and the consumers could be various drivers.
> > The consumers request interconnect resources (path) between endpoints and
> > set the desired constraints on this data flow path. The providers receive
> > requests from consumers and aggregate these requests for all master-slave
> > pairs on that path. Then the providers configure each participating in the
> > topology node according to the requested data flow path, physical links and
> > constraints. The topology could be complicated and multi-tiered and is SoC
> > specific.
> > 
> > Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> > ---
> >  Documentation/interconnect/interconnect.rst |  93 +++++++
> >  drivers/Kconfig                             |   2 +
> >  drivers/Makefile                            |   1 +
> >  drivers/interconnect/Kconfig                |  10 +
> >  drivers/interconnect/Makefile               |   1 +
> >  drivers/interconnect/interconnect.c         | 382 ++++++++++++++++++++++++++++
> >  include/linux/interconnect-consumer.h       |  73 ++++++
> >  include/linux/interconnect-provider.h       | 119 +++++++++
> >  8 files changed, 681 insertions(+)
> >  create mode 100644 Documentation/interconnect/interconnect.rst
> >  create mode 100644 drivers/interconnect/Kconfig
> >  create mode 100644 drivers/interconnect/Makefile
> >  create mode 100644 drivers/interconnect/interconnect.c
> >  create mode 100644 include/linux/interconnect-consumer.h
> >  create mode 100644 include/linux/interconnect-provider.h
> 
> Any comments on this patch?
> 

Sorry, I still haven't found the time to do a proper review of this yet.

> I am planning to change the prefix that is used for naming for example
> the functions from "interconnect_" to something shorter like icbus_.
> 

This isn't implementing a bus; if you feel that just ic_ is too short I
would suggest naming things inter_. (But keep the full name in the file
names)

Regards,
Bjorn
