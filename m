From: Georgi Djakov <georgi.djakov@linaro.org>
Subject: Re: [PATCH v4 1/7] interconnect: Add generic on-chip interconnect API
Date: Wed, 6 Jun 2018 21:09:24 +0300
Message-ID: <c98d2ee2-c4fa-eb35-e6ae-f6d9c91ffe6c@linaro.org>
References: <20180309210958.16672-1-georgi.djakov@linaro.org>
 <20180309210958.16672-2-georgi.djakov@linaro.org>
 <CAE=gft76VpU1mXgNPK9-XTj6WoLHj-_SxAGuV-bUSNYVpfSn6w@mail.gmail.com>
 <43fedb5b-f4a5-8362-d0a2-534b85473bc1@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <43fedb5b-f4a5-8362-d0a2-534b85473bc1@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Evan Green <evgreen@chromium.org>
Cc: linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, rjw@rjwysocki.net, robh+dt@kernel.org, Michael Turquette <mturquette@baylibre.com>, khilman@baylibre.com, vincent.guittot@linaro.org, skannan@codeaurora.org, Bjorn Andersson <bjorn.andersson@linaro.org>, amit.kucheria@linaro.org, seansw@qti.qualcomm.com, davidai@quicinc.com, mark.rutland@arm.com, lorenzo.pieralisi@arm.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Evan,

On 06/06/2018 05:59 PM, Georgi Djakov wrote:
>>> +
>>> +/**
>>> + * icc_node_create() - create a node
>>> + * @id: node id
>>> + *
>>> + * Return: icc_node pointer on success, or ERR_PTR() on error
>>> + */
>>> +struct icc_node *icc_node_create(int id)
>>> +{
>>> +       struct icc_node *node;
>>> +
>>> +       /* check if node already exists */
>>> +       node = node_find(id);
>>> +       if (node)
>>> +               return node;
>>
>> This is probably going to do more harm than good once icc_node_delete comes
>> in, since it almost certainly indicates a programmer error or ID collision,
>> and will likely result in a double free. We should probably fail with
>> EEXIST instead.
> 
> In the current approach we create the nodes one by one, and the linked
> nodes are created when they are referenced. The other way around would
> be to create first all the nodes and then populate the links to avoid
> the "chicken and egg" problem.
> 

Just to elaborate a bit more on that: We can't actually register all the
nodes in advance, as we might have multiple interconnect providers
probing in different order. Each provider may have nodes linking to
nodes belonging to other providers (not probed yet). That's why we
create the nodes on the first reference and then, when the actual
provider driver is probed, the rest of the node data is filled.

Thanks,
Georgi
