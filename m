From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH 1/3] drivers: cpuidle: add status property to ARM idle
 states
Date: Tue, 21 Oct 2014 17:20:58 +0100
Message-ID: <20141021162058.GA17610@e102568-lin.cambridge.arm.com>
References: <1413467997-32131-1-git-send-email-lorenzo.pieralisi@arm.com>
 <7hbnp6e81x.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:60441 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932553AbaJUQVG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 21 Oct 2014 12:21:06 -0400
In-Reply-To: <7hbnp6e81x.fsf@deeprootsystems.com>
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kevin Hilman <khilman@kernel.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Mark Rutland <Mark.Rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Chander Kashyap <k.chander@samsung.com>, Stephen Boyd <sboyd@codeaurora.org>

On Mon, Oct 20, 2014 at 10:38:02PM +0100, Kevin Hilman wrote:
> Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> writes:
> 
> > On some platforms the device tree bindings must provide the kernel
> > with a status flag for idle states, that defines whether the idle
> > state is operational or not in the current configuration.
> >
> > This patch adds a status property to the ARM idle states compliant
> > with ePAPR v1.1 and updates the DT parsing code accordingly.
> >
> > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> 
> For the series:
> 
> Acked-by: Kevin Hilman <khilman@linaro.org>

Thanks ! I will queue it for 3.19 then.

Lorenzo

