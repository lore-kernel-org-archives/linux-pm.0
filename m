From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH 1/3] drivers: cpuidle: add status property to ARM idle
 states
Date: Mon, 10 Nov 2014 12:48:09 +0000
Message-ID: <20141110124809.GB15484@red-moon>
References: <1413467997-32131-1-git-send-email-lorenzo.pieralisi@arm.com>
 <7hbnp6e81x.fsf@deeprootsystems.com>
 <20141021162058.GA17610@e102568-lin.cambridge.arm.com>
 <54606D1C.3000300@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss-mx-na.foss.arm.com ([217.140.108.86]:55463 "EHLO
	foss-mx-na.foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751887AbaKJMsK (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 10 Nov 2014 07:48:10 -0500
Content-Disposition: inline
In-Reply-To: <54606D1C.3000300@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Kevin Hilman <khilman@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Mark Rutland <Mark.Rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Chander Kashyap <k.chander@samsung.com>, Stephen Boyd <sboyd@codeaurora.org>

On Mon, Nov 10, 2014 at 07:45:32AM +0000, Daniel Lezcano wrote:
> On 10/21/2014 06:20 PM, Lorenzo Pieralisi wrote:
> > On Mon, Oct 20, 2014 at 10:38:02PM +0100, Kevin Hilman wrote:
> >> Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> writes:
> >>
> >>> On some platforms the device tree bindings must provide the kernel
> >>> with a status flag for idle states, that defines whether the idle
> >>> state is operational or not in the current configuration.
> >>>
> >>> This patch adds a status property to the ARM idle states compliant
> >>> with ePAPR v1.1 and updates the DT parsing code accordingly.
> >>>
> >>> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> >>
> >> For the series:
> >>
> >> Acked-by: Kevin Hilman <khilman@linaro.org>
> >
> > Thanks ! I will queue it for 3.19 then.
> 
> Applied to my tree for 3.19.
> 
> Thanks
>    -- Daniel

Thank you !

Lorenzo
