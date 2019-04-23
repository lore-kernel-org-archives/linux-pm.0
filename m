From: Jiada Wang <jiada_wang@mentor.com>
Subject: Re: [PATCH v2 1/2] thermal: rcar_gen3_thermal: fix interrupt type
Date: Tue, 23 Apr 2019 22:09:33 +0900
Message-ID: <f01e4a8e-04da-ac93-1e0f-1999e2670851@mentor.com>
References: <20190423130724.GA10913@vmlxhi-102.adit-jv.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190423130724.GA10913@vmlxhi-102.adit-jv.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Eugeniu Rosca <erosca@de.adit-jv.com>
Cc: rui.zhang@intel.com, edubezval@gmail.com, daniel.lezcano@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, joshua_frkuska@mentor.com, horms+renesas@verge.net.au, niklas.soderlund+renesas@ragnatech.se, geert+renesas@glider.be, sergei.shtylyov@cogentembedded.com, marek.vasut+renesas@gmail.com, kuninori.morimoto.gx@renesas.com, hien.dang.eb@renesas.com, fabrizio.castro@bp.renesas.com, dien.pham.ry@renesas.com, biju.das@bp.renesas.com, Eugeniu Rosca <rosca.eugeniu@gmail.com>
List-Id: linux-pm@vger.kernel.org

Hi Eugeniu

On 2019/04/23 22:07, Eugeniu Rosca wrote:
> Hi Jiada,
> 
> On Tue, Apr 23, 2019 at 03:12:17PM +0900, Jiada Wang wrote:
>> Currently IRQF_SHARED type interrupt line is allocated, but it
>> is not appropriate, as the interrupt line isn't shared between
>> different devices, instead IRQF_ONESHOT is the proper type.
>>
>> By changing interrupt type to IRQF_ONESHOT, now irq handler is
>> no longer needed, as clear of interrupt status can be done in
>> threaded interrupt context.
>>
>> Because IRQF_ONESHOT type interrupt line is kept disabled until
>> the threaded handler has been run, so there is no need to protect
>> read/write of REG_GEN3_IRQSTR with lock.
>>
>> Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
>> ---
>>   drivers/thermal/rcar_gen3_thermal.c | 40 ++++++++---------------------
>>   1 file changed, 10 insertions(+), 30 deletions(-)
>>
> 
> [..]
> 
> I might be doing something wrong, but I couldn't apply this patch on top
Oops, I think I used wrong code base,
I will send out v3 patch-set soon

sorry about that

Thanks,
Jiada
> of v5.1-rc6-4-g7142eaa58b49. All below commands failed (git v2.21.0):
>   - git am this.patch
>   - git apply this.patch
>   - patch -p1 < this.patch
> 
