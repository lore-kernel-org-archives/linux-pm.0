From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH v2 7/7] ARM: smp: Add runtime PM support for CPU hotplug
Date: Fri, 4 Sep 2015 14:45:29 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1509041443360.29995-100000@iolanthe.rowland.org>
References: <55E9DB76.3080904@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:55061 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1760197AbbIDSpa (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 4 Sep 2015 14:45:30 -0400
In-Reply-To: <55E9DB76.3080904@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Lina Iyer <lina.iyer@linaro.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Mark Rutland <mark.rutland@arm.com>, ulf.hansson@linaro.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-pm@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, rjw@rjwysocki.net, k.kozlowski@samsung.com, msivasub@codeaurora.org, khilman@linaro.org, geert@linux-m68k.org, agross@codeaurora.org, sboyd@codeaurora.org, linux-arm-kernel@lists.infradead.org

On Fri, 4 Sep 2015, Grygorii Strashko wrote:

> There is one "small" problem with such approach :(
> 
> - It's incompatible with -RT kernel, because PM runtime can't be used
> in atomic context on -RT.

Can you explain this more fully?  Why can't runtime PM be used in 
atomic context in the -rt kernels?

Alan Stern

