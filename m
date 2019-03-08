From: Evan Green <evgreen@chromium.org>
Subject: Re: [PATCH v1 1/2] interconnect: Add support for path tags
Date: Fri, 8 Mar 2019 10:40:40 -0800
Message-ID: <CAE=gft7uKN_EXqkuPvu+sSmJU69Le18yfqHcfmFApUHQyaBZ-Q@mail.gmail.com>
References: <20190208172152.1807-1-georgi.djakov@linaro.org> <20190208172152.1807-2-georgi.djakov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190208172152.1807-2-georgi.djakov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Georgi Djakov <georgi.djakov@linaro.org>
Cc: linux-pm@vger.kernel.org, daidavid1@codeaurora.org, Vincent Guittot <vincent.guittot@linaro.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, amit.kucheria@linaro.org, Doug Anderson <dianders@chromium.org>, Sean Sweeney <seansw@qti.qualcomm.com>, Michael Turquette <mturquette@baylibre.com>, Alexandre Bailon <abailon@baylibre.com>, Thierry Reding <thierry.reding@gmail.com>, ksitaraman@nvidia.com, sanjayc@nvidia.com, henryc.chen@mediatek.com, LKML <linux-kernel@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, linux-arm-msm <linux-arm-msm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Feb 8, 2019 at 9:21 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
>
> Consumers may have use cases with different bandwidth requirements based
> on the system or driver state. The consumer driver can append a specific
> tag to the path and pass this information to the interconnect platform
> driver to do the aggregation based on this state.
>
> Introduce icc_set_tag() function that will allow the consumers to append
> an optional tag to each path. The aggregation of these tagged paths is
> platform specific.
>
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
>  drivers/interconnect/core.c           | 27 +++++++++++++++++++++++----
>  drivers/interconnect/qcom/sdm845.c    |  2 +-
>  include/linux/interconnect-provider.h |  4 ++--
>  include/linux/interconnect.h          |  5 +++++
>  4 files changed, 31 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
> index 6005a1c189f6..31eacd0f5349 100644
> --- a/drivers/interconnect/core.c
> +++ b/drivers/interconnect/core.c
> @@ -42,10 +42,12 @@ struct icc_req {
>
>  /**
>   * struct icc_path - interconnect path structure
> + * @tag: path tag (optional)
>   * @num_nodes: number of hops (nodes)
>   * @reqs: array of the requests applicable to this path of nodes
>   */
>  struct icc_path {
> +       u32 tag;
>         size_t num_nodes;
>         struct icc_req reqs[];
>  };
> @@ -206,7 +208,7 @@ static struct icc_path *path_find(struct device *dev, struct icc_node *src,
>   * implementing its own aggregate() function.
>   */
>
> -static int aggregate_requests(struct icc_node *node)
> +static int aggregate_requests(struct icc_node *node, u32 tag)
>  {
>         struct icc_provider *p = node->provider;
>         struct icc_req *r;
> @@ -215,7 +217,7 @@ static int aggregate_requests(struct icc_node *node)
>         node->peak_bw = 0;

For my suggestion in patch 2, this is where you'd need the callback to
reset the SLEEP/WAKE shadow aggregation buckets that the provider is
keeping, since the core just reset the values here. I wonder if you'd
want to pass the &node->avg_bw and &node->peak_bw in with this
callback as well... not sure if that's useful. Something like:

        if (p->begin_aggregation)
                p->begin_aggregation(node);

>
>         hlist_for_each_entry(r, &node->req_list, req_node)
> -               p->aggregate(node, r->avg_bw, r->peak_bw,
> +               p->aggregate(node, tag, r->avg_bw, r->peak_bw,
>                              &node->avg_bw, &node->peak_bw);

Wait I'm confused. The tag is associated with a particular path. But
now aren't you looping over all the other requests and coloring them
with whatever tag this is? Don't you need to store the tag with the
request, and then pass r->tag for each r rather than the tag from
whichever request happened to initiate the re-aggregation?

>
>         return 0;
> @@ -396,6 +398,23 @@ struct icc_path *of_icc_get(struct device *dev, const char *name)
>  }
>  EXPORT_SYMBOL_GPL(of_icc_get);
>
