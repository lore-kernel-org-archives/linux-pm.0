From: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH] thermal: qcom: tsens: Allow number of sensors to come
 from DT
Date: Mon, 14 May 2018 10:46:49 -0700
Message-ID: <20180514174649.GM14924@minitux>
References: <20180507235339.8836-1-bjorn.andersson@linaro.org>
 <CAHLCerN9zQEJK4WoV6BY6hga2BxwzMsyScWnTdYcLgEk0Bjg4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHLCerN9zQEJK4WoV6BY6hga2BxwzMsyScWnTdYcLgEk0Bjg4w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Amit Kucheria <amit.kucheria@linaro.org>
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Rajendra Nayak <rnayak@codeaurora.org>, Linux PM list <linux-pm@vger.kernel.org>, devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-arm-msm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon 14 May 07:45 PDT 2018, Amit Kucheria wrote:

> On Tue, May 8, 2018 at 2:53 AM, Bjorn Andersson
> <bjorn.andersson@linaro.org> wrote:
> > For platforms that has multiple copies of the TSENS hardware block it's
> > necessary to be able to specify the number of sensors per block in DeviceTree.
> 
> I assume you want to replace the hardcoded num_sensors values in the
> tsens-xxxx.c files with values in device tree atleast on platforms
> that use devicetree?
> 

Right, e.g. in msm8998 we have two blocks with 12 and 8 sensors
respectively. With the patch we will overwrite the num_sensors with a
value from DT, iff specified.

As probe will fail if num_sensors is 0 we can reuse ops_8996 and just
not provide num_sensors for 8998, hence requiring it to be specified in
DT.


PS. Looking at the register spec 8996 too seems to have two tsens
blocks, so in order to access sensors off the second bank this patch
would be needed (and would work and be backwards compatible).

Regards,
Bjorn
