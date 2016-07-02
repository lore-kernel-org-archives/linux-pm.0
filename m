From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH v6 00/11] qcom: Add support for TSENS driver
Date: Fri, 1 Jul 2016 18:23:03 -0700
Message-ID: <20160702012301.GB9035@localhost.localdomain>
References: <1462438309-11196-1-git-send-email-rnayak@codeaurora.org>
 <575A57F8.6060004@codeaurora.org>
 <576391B3.7090508@codeaurora.org>
 <57749F20.4010700@codeaurora.org>
 <20160701205223.GA7814@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160701205223.GA7814@localhost.localdomain>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Rajendra Nayak <rnayak@codeaurora.org>
Cc: andy.gross@linaro.org, rui.zhang@intel.com, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, sboyd@codeaurora.org, nrajan@codeaurora.org, lina.iyer@linaro.org, punit.agrawal@arm.com
List-Id: linux-pm@vger.kernel.org

On Fri, Jul 01, 2016 at 01:52:25PM -0700, Eduardo Valentin wrote:
> On Thu, Jun 30, 2016 at 09:55:04AM +0530, Rajendra Nayak wrote:
> > Rui,
> > 
> > On 06/17/2016 11:29 AM, Nayak, Rajendra wrote:
> > > Hey Eduardo,
> > > 
> > > On 6/10/2016 11:32 AM, Rajendra Nayak wrote:
> > >> Eduardo,
> > >>
> > >> On 05/05/2016 02:21 PM, Rajendra Nayak wrote:
> > >>> Current set of patches apply on 4.6-rc6. Fixes for the nvmem apis
> > >>> are now posted [1] and queued in -next [2]
> > >>> Patches [1-6] will need to be merged via thermal tree/Eduardo.
> > >>
> > >> Any plans to pull these in for 4.8?
> > > 
> > > These patches have been on the list for quite a while, and they
> > > do not have any outstanding dependencies or comments to be
> > > addressed. I would really hope to see these in for 4.8.
> > > Let me know if there is something you want me to address before
> > > you pull them in.
> > 
> > Would you be able to pull this driver in? I haven't heard back
> > anything from Eduardo despite multiple pings.
> > These patches (v6) have been on the list for a couple months now,
> > which address all issues/concerns that were raised by Eduardo
> > in his previous reviews.
> 
> Apologize for the late answer. I will take care of queueing them.

Applied patches 1-6. The DT patches lack the cooling map, on all of
them. In case you do not have a working cooling device in your
platform, at least add an empty map with a TODO flag.

After you fix the DT patch, you may add my

Acked-by: Eduardo Valentin <edubezval@gmail.com>

on them.

> 
> BR,
> 
