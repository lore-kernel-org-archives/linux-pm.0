From: Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH v9 2/3] MAINTAINERS: add zx2967 thermal drivers to ARM
 ZTE architecture
Date: Wed, 8 Feb 2017 13:12:30 +0800
Message-ID: <20170208051228.GL3407@dragon>
References: <1486429001-31940-1-git-send-email-baoyou.xie@linaro.org>
 <1486429001-31940-2-git-send-email-baoyou.xie@linaro.org>
 <20170208044537.GA20633@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20170208044537.GA20633@localhost.localdomain>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, mathieu.poirier@linaro.org, linux-pm@vger.kernel.org, xie.baoyou@zte.com.cn, linux-kernel@vger.kernel.org, robh+dt@kernel.org, chen.chaokai@zte.com.cn, wang.qiang01@zte.com.cn, jun.nie@linaro.org, Baoyou Xie <baoyou.xie@linaro.org>, rui.zhang@intel.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Hi Eduardo,

On Tue, Feb 07, 2017 at 08:45:39PM -0800, Eduardo Valentin wrote:
> 
> On Tue, Feb 07, 2017 at 08:56:40AM +0800, Baoyou Xie wrote:
> > Add the zx2967 thermal drivers as maintained by ARM ZTE
> > architecture maintainers, as they're parts of the core IP.
> 
> What kernel version is this based off? I could not apply this one
> cleanly.

I think you can skip this one.  We will update MAINTAINERS separately
through arm-soc tree, after the patch lands on mainline.

Shawn
