From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v6 10/11] cpuidle/powernv: Add support for POWER ISA v3
 idle states
Date: Tue, 14 Jun 2016 21:29:48 +1000
Message-ID: <1465903788.30200.8.camel@kernel.crashing.org>
References: <1465404871-5406-1-git-send-email-shreyas@linux.vnet.ibm.com>
 <1465404871-5406-11-git-send-email-shreyas@linux.vnet.ibm.com>
 <20160613153446.GF10634@linaro.org>
	 <575FE0B0.4030309@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:44467 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750760AbcFNLa3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 14 Jun 2016 07:30:29 -0400
In-Reply-To: <575FE0B0.4030309@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Shreyas B Prabhu <shreyas@linux.vnet.ibm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: ego@linux.vnet.ibm.com, mikey@neuling.org, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, maddy@linux.vnet.ibm.com, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, linuxppc-dev@lists.ozlabs.org

On Tue, 2016-06-14 at 16:17 +0530, Shreyas B Prabhu wrote:

> 
> I ignored adding this check because this is part of initcall and we are
> unlikely to run out of memory at this state. But I'll add the check in
> next version.

Why do you malloc the u64 array and not the string pointer array ?
Shouldn't you either have both on stack or both allocated ?

Cheers,
Ben.

