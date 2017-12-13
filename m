From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v5 6/9] ACPI/PPTT: Add topology parsing code
Date: Wed, 13 Dec 2017 17:38:51 +0000
Message-ID: <20171213173851.GA4060@red-moon>
References: <20171201222330.18863-1-jeremy.linton@arm.com>
 <20171201222330.18863-7-jeremy.linton@arm.com>
 <9009154.M66RGdQJXA@aspire.rjw.lan>
 <fc12696c-15e1-cea4-42bf-db4b5daa45f2@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:33064 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753739AbdLMRiP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 13 Dec 2017 12:38:15 -0500
Content-Disposition: inline
In-Reply-To: <fc12696c-15e1-cea4-42bf-db4b5daa45f2@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, sudeep.holla@arm.com, hanjun.guo@linaro.org, will.deacon@arm.com, catalin.marinas@arm.com, gregkh@linuxfoundation.org, viresh.kumar@linaro.org, mark.rutland@arm.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, jhugo@codeaurora.org, wangxiongfeng2@huawei.com, Jonathan.Zhang@cavium.com, ahs3@redhat.com, Jayachandran.Nair@cavium.com, austinwc@codeaurora.org, lenb@kernel.org

On Tue, Dec 12, 2017 at 10:13:08AM -0600, Jeremy Linton wrote:
> Hi,
> 
> First, thanks for taking a look at this.
> 
> On 12/11/2017 07:12 PM, Rafael J. Wysocki wrote:
> >On Friday, December 1, 2017 11:23:27 PM CET Jeremy Linton wrote:
> >>The PPTT can be used to determine the groupings of CPU's at
> >>given levels in the system. Lets add a few routines to the PPTT
> >>parsing code to return a unique id for each unique level in the
> >>processor hierarchy. This can then be matched to build
> >>thread/core/cluster/die/package/etc mappings for each processing
> >>element in the system.
> >>
> >>Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> >
> >Why can't this be folded into patch [2/9]?
> 
> It can, and I will be happy squash it.
> 
> It was requested that the topology portion of the parser be split
> out back in v3.
> 
> https://www.spinics.net/lists/linux-acpi/msg78487.html

I asked to split cache/topology since I am not familiar with cache
code and Sudeep - who looks after the cache code - won't be able
to review this series in time for v4.16.

Lorenzo
