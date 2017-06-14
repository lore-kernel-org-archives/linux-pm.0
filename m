From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH] dt-bindings: Drop k2g genpd device ID macros
Date: Wed, 14 Jun 2017 10:07:23 +0300
Message-ID: <3de2ed22-2de9-101a-5ee6-0077fe523ce2@ti.com>
References: <20170522183737.24946-1-d-gerlach@ti.com>
 <20170531162850.mf6giowmxj5vetxq@rob-hp-laptop>
 <ca91000a-627b-a655-4304-b64b78bbcf9a@ti.com>
 <fc503960-d225-895c-c993-974ba6c5a92d@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <fc503960-d225-895c-c993-974ba6c5a92d@oracle.com>
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
To: Santosh Shilimkar <santosh.shilimkar@oracle.com>, Dave Gerlach <d-gerlach@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>
Cc: Nishanth Menon <nm@ti.com>, Rob Herring <robh@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Arnd Bergmann <arnd@arndb.de>, devicetree@vger.kernel.org, Keerthy <j-keerthy@ti.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Davis <afd@ti.com>, Kevin Hilman <khilman@kernel.org>, Franklin Cooper <fcooper@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On 13/06/17 23:32, Santosh Shilimkar wrote:
> On 6/13/2017 1:16 PM, Dave Gerlach wrote:
>> Santosh,
>> On 05/31/2017 11:28 AM, Rob Herring wrote:
>>> On Mon, May 22, 2017 at 01:37:37PM -0500, Dave Gerlach wrote:
> [...]
> 
>>>> [1] https://www.spinics.net/lists/arm-kernel/msg577079.html
>>>>
>>>>   .../devicetree/bindings/soc/ti/sci-pm-domain.txt   |  5 +-
>>>>   include/dt-bindings/genpd/k2g.h                    | 90 
>>>> ----------------------
>>>>   2 files changed, 3 insertions(+), 92 deletions(-)
>>>>   delete mode 100644 include/dt-bindings/genpd/k2g.h
>>>
>>> Acked-by: Rob Herring <robh@kernel.org>
>>>
>>
>> Gentle ping on this. If you're OK with the patch any chance you can 
>> pick it up?
>>
> Sorry Dave I missed to pick this one in pull request for 4.13. Will pick 
> this
> one along with what Suman and Tero have been working for following merge
> window. Thanks for reminding about this one.

I think Stephen will probably be picking up the clock part directly by 
himself.

-Tero
