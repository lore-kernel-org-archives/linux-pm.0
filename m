From: Georgi Djakov <georgi.djakov@linaro.org>
Subject: Re: [PATCH v5 1/8] interconnect: Add generic on-chip interconnect API
Date: Sun, 1 Jul 2018 14:09:26 +0300
Message-ID: <730fac43-e99f-e4bd-bc40-eddeb8338e6e@linaro.org>
References: <20180620121141.15403-1-georgi.djakov@linaro.org>
 <20180620121141.15403-2-georgi.djakov@linaro.org>
 <CAKfTPtBApjf9rhJm3paeXdgbVG50ALeun=zMUddc-f+RnrvkqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKfTPtBApjf9rhJm3paeXdgbVG50ALeun=zMUddc-f+RnrvkqQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: "open list:THERMAL" <linux-pm@vger.kernel.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Rob Herring <robh+dt@kernel.org>, mturquette <mturquette@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, Saravana Kannan <skannan@codeaurora.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, "Sweeney, Sean" <seansw@qti.qualcomm.com>, daidavid1@codeaurora.org, Evan Green <evgreen@chromium.org>, Mark Rutland <mark.rutland@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, abailon@baylibre.com, linux-kernel <linux-kernel@vger.kernel.org>, LAK <linux-arm-kernel@lists.infradead.org>, linux-arm-msm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Vincent,

On 27.06.18 г. 9:19, Vincent Guittot wrote:
> Hi Georgi
> 
> On Wed, 20 Jun 2018 at 14:11, Georgi Djakov <georgi.djakov@linaro.org> wrote:
> 
> [snip]
> 
>> +
>> +static struct icc_path *path_allocate(struct icc_node *dst, ssize_t num_nodes)
>> +{
>> +       struct icc_node *node = dst;
>> +       struct icc_path *path;
>> +       size_t i;
>> +
>> +       path = kzalloc(sizeof(*path) + num_nodes * sizeof(*path->reqs),
> 
> Should be (num_nodes -1) * sizeof(*path->reqs) as there is already 1
> icc_req in icc_path struct

reqs[] is a flexible array member and it's size is not included in
sizeof(*path)

Thanks,
Georgi

>> +                      GFP_KERNEL);
>> +       if (!path)
>> +               return ERR_PTR(-ENOMEM);
>> +
>> +       path->num_nodes = num_nodes;
>> +
>> +       for (i = 0; i < num_nodes; i++) {
>> +               hlist_add_head(&path->reqs[i].req_node, &node->req_list);
>> +
>> +               path->reqs[i].node = node;
>> +               /* reference to previous node was saved during path traversal */
>> +               node = node->reverse;
>> +       }
>> +
>> +       return path;
>> +}
>> +
> 
> [snip]
> 
