From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [RFC v2 1/3] interconnect: Add generic interconnect controller
 API
Date: Tue, 13 Jun 2017 15:42:00 +0200
Message-ID: <20170613134200.GA4769@kroah.com>
References: <20170612141359.26117-1-georgi.djakov@linaro.org>
 <20170612141359.26117-2-georgi.djakov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:55444 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753351AbdFMNmI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Jun 2017 09:42:08 -0400
Content-Disposition: inline
In-Reply-To: <20170612141359.26117-2-georgi.djakov@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Georgi Djakov <georgi.djakov@linaro.org>
Cc: linux-pm@vger.kernel.org, rjw@rjwysocki.net, robh+dt@kernel.org, khilman@baylibre.com, mturquette@baylibre.com, vincent.guittot@linaro.org, skannan@codeaurora.org, sboyd@codeaurora.org, andy.gross@linaro.org, seansw@qti.qualcomm.com, davidai@quicinc.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org

On Mon, Jun 12, 2017 at 05:13:57PM +0300, Georgi Djakov wrote:
> This patch introduce a new API to get the requirement and configure the
> interconnect buses across the entire chipset to fit with the current demand.
> 
> The API is using a consumer/provider-based model, where the providers are
> the interconnect controllers and the consumers could be various drivers.
> The consumers request interconnect resources (path) to an endpoint and set
> the desired constraints on this data flow path. The provider(s) receive
> requests from consumers and aggregate these requests for all master-slave
> pairs on that path. Then the providers configure each participating in the
> topology node according to the requested data flow path, physical links and
> constraints. The topology could be complicated and multi-tiered and is SoC
> specific.
> 
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
>  Documentation/interconnect/interconnect.txt |  65 +++++
>  drivers/Kconfig                             |   2 +
>  drivers/Makefile                            |   1 +
>  drivers/interconnect/Kconfig                |  10 +
>  drivers/interconnect/Makefile               |   1 +
>  drivers/interconnect/interconnect.c         | 376 ++++++++++++++++++++++++++++
>  include/linux/interconnect-consumer.h       |  72 ++++++
>  include/linux/interconnect-provider.h       | 120 +++++++++
>  8 files changed, 647 insertions(+)
>  create mode 100644 Documentation/interconnect/interconnect.txt
>  create mode 100644 drivers/interconnect/Kconfig
>  create mode 100644 drivers/interconnect/Makefile
>  create mode 100644 drivers/interconnect/interconnect.c
>  create mode 100644 include/linux/interconnect-consumer.h
>  create mode 100644 include/linux/interconnect-provider.h
> 
> diff --git a/Documentation/interconnect/interconnect.txt b/Documentation/interconnect/interconnect.txt
> new file mode 100644
> index 000000000000..f761a2fb553c
> --- /dev/null
> +++ b/Documentation/interconnect/interconnect.txt

.rst for new Documenation files please, and hook it up to the larger
documentation build process at the same time.

And why are these RFC patches?  Don't you feel they are ready to be
reviewed?  I know I ignore RFC patches for the most part as obviously
the author does not think they are ready :)

thanks,

greg k-h
