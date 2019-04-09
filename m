From: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH 2/3] interconnect: qcom: Add QCS404 interconnect provider
 driver
Date: Mon, 8 Apr 2019 20:27:14 -0700
Message-ID: <20190409032714.GT1843@tuxbook-pro>
References: <20190405035446.31886-1-georgi.djakov@linaro.org>
 <20190405035446.31886-3-georgi.djakov@linaro.org>
 <20190405145756.GN1843@tuxbook-pro>
 <0ca7862f-31ba-748a-945d-a925a40a16de@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <0ca7862f-31ba-748a-945d-a925a40a16de@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Georgi Djakov <georgi.djakov@linaro.org>
Cc: robh+dt@kernel.org, vkoul@kernel.org, evgreen@chromium.org, daidavid1@codeaurora.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon 08 Apr 07:33 PDT 2019, Georgi Djakov wrote:
> On 4/5/19 17:57, Bjorn Andersson wrote:
> > On Fri 05 Apr 10:54 +07 2019, Georgi Djakov wrote:
> > [..]
[..]
> >> diff --git a/drivers/interconnect/qcom/qcs404_ids.h b/drivers/interconnect/qcom/qcs404_ids.h
> > 
> > You use these defines in the driver, so I think this file should be the
> > one in include/dt-bindings...
> 
> The ids in this header are in a single global namespace in order to
> build the internal topology and could be used for drivers that support
> only platform data (although not sure if there would be any).
> 

As you say these numbers could be used by drivers on non-DT enabled
platforms, but for that this include file should be in
include/linux/interconnect. That said, there are no such Qualcomm
platforms, so these numbers will only ever be used internally in the
qcs404.c provider, so it would be better to just define them in that
file - to remove the risk of confusion.

> > 
> > [..]
> >> diff --git a/include/dt-bindings/interconnect/qcom,qcs404.h b/include/dt-bindings/interconnect/qcom,qcs404.h
> > 
> 
> These header is using per NoC local ids and should be used on DT enabled
> platforms.
> 

I had missed that you implemented support for xlating NoC-specific ids,
so this makes sense now, nice. I presume we won't ever include files in
a way where these defines collide - so this looks good.

Regards,
Bjorn
