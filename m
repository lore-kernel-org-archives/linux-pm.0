From: Henry Chen <henryc.chen@mediatek.com>
Subject: Re: [RFC RESEND PATCH 0/7] Add driver for dvfsrc and add support
 for active state of scpsys on mt8183
Date: Thu, 3 Jan 2019 22:31:23 +0800
Message-ID: <1546525883.6818.62.camel@mtksdaap41>
References: <1546438198-1677-1-git-send-email-henryc.chen@mediatek.com>
         <20190103044852.l7sxfqeqnxx2xbp5@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190103044852.l7sxfqeqnxx2xbp5@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Viresh Kumar <vireshk@kernel.org>, Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Fan Chen <fan.chen@mediatek.com>, Weiyi Lu <weiyi.lu@mediatek.com>, James Liao <jamesjj.liao@mediatek.com>, Kees Cook <keescook@chromium.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu, 2019-01-03 at 10:18 +0530, Viresh Kumar wrote:
> On 02-01-19, 22:09, Henry Chen wrote:
> > The patchsets add support for MediaTek hardware module named DVFSRC
> > (dynamic voltage and frequency scaling resource collector). The DVFSRC is
> > a HW module which is used to collect all the requests from both software
> > and hardware and turn into the decision of minimum operating voltage and
> > minimum DRAM frequency to fulfill those requests.
> > 
> > So, This series is to implement the dvfsrc driver to collect all the
> > requests of operating voltage or DRAM bandwidth from other device drivers
> > likes GPU/Camera through 2 frameworks basically:
> > 
> > 1. PM_QOS_MEMORY_BANDWIDTH from PM QOS: to aggregate the bandwidth
> >    requirements from different clients
> > 2. Active state management of power domains[1]: to handle the operating
> >    voltage opp requirement from different power domains
> 
> Honestly speaking I wasn't sure if anyone apart from Qcom will ever use this
> feature when I wrote it first and I am quite surprised and happy to see your
> patches.
> 
> They are mostly very neat and clean patches and I don't have complaints with
> most of them. Lets see what comments others provide on them.
> 
> Thanks.
> 

Thanks for your review and the comments.
Henry
