From: Georgi Djakov <georgi.djakov@linaro.org>
Subject: Re: [PATCH v1 3/3] dt-bindings: Interconnect device-tree bindings
 draft
Date: Fri, 30 Jun 2017 15:57:13 +0300
Message-ID: <635775cb-fc4f-370c-297b-f12cd5d3f4ce@linaro.org>
References: <20170627174903.27978-1-georgi.djakov@linaro.org>
 <20170627174903.27978-4-georgi.djakov@linaro.org>
 <20170629213247.qk54ocaomcz42gn7@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170629213247.qk54ocaomcz42gn7@rob-hp-laptop>
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
To: Rob Herring <robh@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, vincent.guittot@linaro.org, linux-pm@vger.kernel.org, seansw@qti.qualcomm.com, khilman@baylibre.com, mturquette@baylibre.com, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, davidai@quicinc.com, skannan@codeaurora.org, gregkh@linuxfoundation.org, andy.gross@linaro.org, sboyd@codeaurora.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Hi Rob,

On 06/30/2017 12:32 AM, Rob Herring wrote:
> On Tue, Jun 27, 2017 at 08:49:03PM +0300, Georgi Djakov wrote:
>> The interconnect API is not yet using DT bindings for expressing
>> the relations between the API consumers and providers. This is
>> posted a separate patch as it needs further discussions on how
>> to represent this with DT.
> 
> I would recommend continuing to sort out how this works within the 
> kernel before fixing things in DT. Something like this needs to be a 
> core binding in the DT spec.

Yes, that's the plan. Do you prefer me to drop this patch for now?

> 
> Also, you should CC some ARM, Ltd. folks like Mark R and Lorenzo. 
> There's been some discussion in the past how to describe the DMA master 
> side of the bus topology.

Thanks for the information! I will CC them on the next version!

BR,
Georgi
