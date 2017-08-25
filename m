From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH V1] thermal: qcom-spmi-temp-alarm: add support for GEN2
 PMIC peripherals
Date: Fri, 25 Aug 2017 16:19:48 -0700
Message-ID: <20170825231948.GQ21656@codeaurora.org>
References: <1499947772-19199-1-git-send-email-kgunda@codeaurora.org>
 <1502179943.4296.12.camel@intel.com>
 <f5c6c5f73b78c407684482cdeed30294@codeaurora.org>
 <5d3f612dca4181b2038e442cfba5594e@codeaurora.org>
 <1503627189.2774.3.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1503627189.2774.3.camel@intel.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: kgunda@codeaurora.org, Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, iivanov@mm-sol.com, linux-arm-msm@vger.kernel.org, David Collins <collinsd@codeaurora.org>, linux-arm-msm-owner@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, Jean Delvare <jdelvare@suse.de>, Lukasz Majewski <l.majewski@samsung.com>, Darren Hart <dvhart@linux.intel.com>, Heiko Stuebner <heiko@sntech.de>, Peter Feuerer <peter@piie.net>, bjorn.andersson@linaro.org
List-Id: linux-pm@vger.kernel.org

On 08/25, Zhang Rui wrote:
> On Thu, 2017-08-17 at 13:12 +0530, kgunda@codeaurora.org wrote:
> > On 2017-08-16 17:53, kgunda@codeaurora.org wrote:
> > > 
> > > On 2017-08-08 13:42, Zhang Rui wrote:
> > > > 
> > > > On Thu, 2017-07-13 at 17:39 +0530, Kiran Gunda wrote:
> > > > > 
> > > > > From: David Collins <collinsd@codeaurora.org>
> > > > > 
> > > > > Add support for the TEMP_ALARM GEN2 PMIC peripheral
> > > > > subtype.  The
> > > > > GEN2 subtype defines an over temperature state with hysteresis
> > > > > instead of stage in the status register.  There are two GEN2
> > > > > states corresponding to stages 1 and 2.
> > > > > 
> > > > > Signed-off-by: David Collins <collinsd@codeaurora.org>
> > > > > Signed-off-by: Kiran Gunda <kgunda@codeaurora.org>
> > > > Ivan,
> > > > 
> > > > can you please review this patch and let me know your opinion?
> > > > 
> > > > thanks,
> > > > rui
> > > Ivan,
> > > Could you please review this patch ?
> > > 
> > > Thanks,
> > > Kiran
> > Looks like Ivan is no more reviewing the patches for qcom.
> > Adding Bjorn and Stephen Boyd for the review.
> > 
> Given this is a platform specific change, I will queue it for next
> merge window, and let's see if there is any problem reported.
> 

FWIW,

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
