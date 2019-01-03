From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RFC RESEND PATCH 0/7] Add driver for dvfsrc and add support for
 active state of scpsys on mt8183
Date: Thu, 3 Jan 2019 10:18:52 +0530
Message-ID: <20190103044852.l7sxfqeqnxx2xbp5@vireshk-i7>
References: <1546438198-1677-1-git-send-email-henryc.chen@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1546438198-1677-1-git-send-email-henryc.chen@mediatek.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Henry Chen <henryc.chen@mediatek.com>
Cc: Mark Rutland <mark.rutland@arm.com>, James Liao <jamesjj.liao@mediatek.com>, Ulf Hansson <ulf.hansson@linaro.org>, Kees Cook <keescook@chromium.org>, Weiyi Lu <weiyi.lu@mediatek.com>, linux-pm@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>, Viresh Kumar <vireshk@kernel.org>, linux-kernel@vger.kernel.org, Fan Chen <fan.chen@mediatek.com>, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On 02-01-19, 22:09, Henry Chen wrote:
> The patchsets add support for MediaTek hardware module named DVFSRC
> (dynamic voltage and frequency scaling resource collector). The DVFSRC is
> a HW module which is used to collect all the requests from both software
> and hardware and turn into the decision of minimum operating voltage and
> minimum DRAM frequency to fulfill those requests.
> 
> So, This series is to implement the dvfsrc driver to collect all the
> requests of operating voltage or DRAM bandwidth from other device drivers
> likes GPU/Camera through 2 frameworks basically:
> 
> 1. PM_QOS_MEMORY_BANDWIDTH from PM QOS: to aggregate the bandwidth
>    requirements from different clients
> 2. Active state management of power domains[1]: to handle the operating
>    voltage opp requirement from different power domains

Honestly speaking I wasn't sure if anyone apart from Qcom will ever use this
feature when I wrote it first and I am quite surprised and happy to see your
patches.

They are mostly very neat and clean patches and I don't have complaints with
most of them. Lets see what comments others provide on them.

Thanks.

-- 
viresh
