From: Evan Green <evgreen@chromium.org>
Subject: Re: [PATCH v4 1/7] interconnect: Add generic on-chip interconnect API
Date: Wed, 6 Jun 2018 18:06:05 -0700
Message-ID: <CAE=gft71Y+0dcYtJmq6nxG99--yRGUXf+B9_+GWPTTrin+TBjA@mail.gmail.com>
References: <20180309210958.16672-1-georgi.djakov@linaro.org>
 <20180309210958.16672-2-georgi.djakov@linaro.org>
 <CAE=gft76VpU1mXgNPK9-XTj6WoLHj-_SxAGuV-bUSNYVpfSn6w@mail.gmail.com>
 <43fedb5b-f4a5-8362-d0a2-534b85473bc1@linaro.org>
 <c98d2ee2-c4fa-eb35-e6ae-f6d9c91ffe6c@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <c98d2ee2-c4fa-eb35-e6ae-f6d9c91ffe6c@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: georgi.djakov@linaro.org
Cc: mark.rutland@arm.com, lorenzo.pieralisi@arm.com, Vincent Guittot <vincent.guittot@linaro.org>, linux-pm@vger.kernel.org, seansw@qti.qualcomm.com, gregkh@linuxfoundation.org, Michael Turquette <mturquette@baylibre.com>, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, amit.kucheria@linaro.org, Bjorn Andersson <bjorn.andersson@linaro.org>, robh+dt@kernel.org, Saravana Kannan <skannan@codeaurora.org>, khilman@baylibre.com, davidai@quicinc.com, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Wed, Jun 6, 2018 at 11:09 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
>
> Hi Evan,
>
> On 06/06/2018 05:59 PM, Georgi Djakov wrote:
> >>> +
> >>> +/**
> >>> + * icc_node_create() - create a node
> >>> + * @id: node id
> >>> + *
> >>> + * Return: icc_node pointer on success, or ERR_PTR() on error
> >>> + */
> >>> +struct icc_node *icc_node_create(int id)
> >>> +{
> >>> +       struct icc_node *node;
> >>> +
> >>> +       /* check if node already exists */
> >>> +       node = node_find(id);
> >>> +       if (node)
> >>> +               return node;
> >>
> >> This is probably going to do more harm than good once icc_node_delete comes
> >> in, since it almost certainly indicates a programmer error or ID collision,
> >> and will likely result in a double free. We should probably fail with
> >> EEXIST instead.
> >
> > In the current approach we create the nodes one by one, and the linked
> > nodes are created when they are referenced. The other way around would
> > be to create first all the nodes and then populate the links to avoid
> > the "chicken and egg" problem.
> >
>
> Just to elaborate a bit more on that: We can't actually register all the
> nodes in advance, as we might have multiple interconnect providers
> probing in different order. Each provider may have nodes linking to
> nodes belonging to other providers (not probed yet). That's why we
> create the nodes on the first reference and then, when the actual
> provider driver is probed, the rest of the node data is filled.
>

Ah ok, the extra explanation helped a lot. This makes sense to me. Thanks.
-Evan
