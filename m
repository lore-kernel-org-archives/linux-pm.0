From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH v2 5/5] thermal: Add Tegra BPMP thermal sensor driver
Date: Fri, 01 Sep 2017 09:23:44 +0800
Message-ID: <1504229024.2638.10.camel@intel.com>
References: <20170724162918.21050-1-mperttunen@nvidia.com>
         <20170724162918.21050-5-mperttunen@nvidia.com>
         <1502420276.2598.5.camel@intel.com>
         <4315091f-03b1-2df6-b224-6a29d3261371@nvidia.com>
         <20170831124506.GA16437@ulmo.fritz.box>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:2755 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750925AbdIABXw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 31 Aug 2017 21:23:52 -0400
In-Reply-To: <20170831124506.GA16437@ulmo.fritz.box>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Wei Ni <wni@nvidia.com>, Mikko Perttunen <mperttunen@nvidia.com>, edubezval@gmail.com, jonathanh@nvidia.com, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org

On Thu, 2017-08-31 at 14:45 +0200, Thierry Reding wrote:
> On Mon, Aug 21, 2017 at 10:40:44AM +0800, Wei Ni wrote:
> > 
> > 
> > 
> > On Friday, August 11, 2017 10:57 AM, Zhang Rui wrote:
> > > 
> > > On Mon, 2017-07-24 at 19:29 +0300, Mikko Perttunen wrote:
> > > > 
> > > > On Tegra186, the BPMP (Boot and Power Management Processor)
> > > > exposes
> > > > an
> > > > interface to thermal sensors on the system-on-chip. This driver
> > > > implements access to the interface. It supports reading the
> > > > temperature, setting trip points and receiving notification of
> > > > a
> > > > tripped trip point.
> > > > 
> > > > Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>

Acked-by: Zhang Rui <rui.zhang@intel.com>
for this patch and patch 1/5.


> > > Wei Ni,
> > > 
> > > what do you think of this patch?
> > Reviewed this patch, it looked fine to me.
> Hi Zhang,
> 
> given the build-time dependencies, how about if I take this into the
> Tegra tree with an Acked-by from you?

Sounds okay to me. Done. :)

thanks,
rui

>  I can provide a stable branch with
> the dependencies included if you want to pull it into your tree in
> order
> to resolve dependencies.
> 
> Thierry
