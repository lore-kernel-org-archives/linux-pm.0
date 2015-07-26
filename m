From: Bjorn Andersson <bjorn.andersson@sonymobile.com>
Subject: Re: [PATCH 3/4] power: Add Qualcomm SMBB driver
Date: Sat, 25 Jul 2015 18:04:14 -0700
Message-ID: <20150726010414.GK4753@usrtlx11787.corpusers.net>
References: <1434662025-9485-1-git-send-email-bjorn.andersson@sonymobile.com>
 <1434662025-9485-4-git-send-email-bjorn.andersson@sonymobile.com>
 <20150725154159.GA17373@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150725154159.GA17373@earth>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "Cavin, Courtney" <Courtney.Cavin@sonymobile.com>
List-Id: linux-pm@vger.kernel.org

On Sat 25 Jul 08:42 PDT 2015, Sebastian Reichel wrote:

> Hi,
> 
> On Thu, Jun 18, 2015 at 02:13:44PM -0700, Bjorn Andersson wrote:
> > Add the Qualcomm Switch-Mode Battery Charger and Boost driver, found in
> > pm8941.
> 
> The driver's sourcecode looks fine to me.

Thanks.

> I'm not convinced by all those new DT properties, though.  I think
> "watermark" should be replaced with "threshold" and "control" with
> "current" for all properties. Additionally some comments.

I think both of these comes from the documentation, but I agree with
your suggestion.

> Note, that I only used the driver's sourcecode as reference, since the
> DT binding document was neither send to me, nor to linux-pm
> mailinglist.
> 

Sorry about that, I will make sure to double check my recipients in the
future.

>  * battery-charge-control-limit
> 
> It's unclear, what this property is used for. Is the limit only
> for "normal" charging or also for fast charging?
> 

This is described as the current limit during fast charging. However,
"fast charging" is the normal state.

I think the most consistent (regards documentation and other properties)
would be:

 qcom,fast-charge-current-limit

>  * fast-charge-low-watermark
>  * fast-charge-high-watermark
> 
> Add a unit to this property. Maybe "fast-charge-start-voltage"
> and "fast-charge-stop-voltage"?
> 

Will update to:

 qcom,fast-charge-{low,high}-threshold-voltage

>  * fast-charge-safe-voltage
>  * fast-charge-safe-current
> 
> These properties are fine to me. I wonder if they should be named
> fast-charge-max-*, though.
> 

The safe naming is in accordance with the hw documentation, so I think
we should keep those.

>  * auto-recharge-low-watermark
> 
> I think the "low" can be dropped. Instead a -voltage
> should be appended, since it could also be a percentage.
> 

qcom,auto-charge-threshold-voltage

>  * minimum-input-voltage
> 
> Add a vendor prefix to this property.
> 

Shouldn't they all have a vendor prefix?

>  * usb-charge-control-limit
> 
> I suggest to remove this from DT. If no USB detection is
> implemented, the default should be 100mA according to USB
> standard.
> 

Right, this have been convenient during testing as no-one actually does
implement the USB current limit propagation. But that should be
corrected and then you're right that this should only default to 100mA.

I'll drop it.

>  * dc-charge-control-limit
> 
> Please add a vendor prefix and I think "dc-current-limit"
> is a more fitting name.
> 

Sounds good.

>  * disable-dc
> 
> Please add a vendor prefix.
> 

Ok

>  * jeita-extended-temp-range
> 
> Looks ok to me.

Thanks for the review, I'll update the patches accordingly and will send
out v2 (and make sure you get the dt binding document as well).

Regards,
Bjorn
