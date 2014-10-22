From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v2 36/47] arm64: psci: Register with kernel poweroff
 handler
Date: Wed, 22 Oct 2014 12:23:03 +0100
Message-ID: <20141022112300.GA15370@e104818-lin.cambridge.arm.com>
References: <1413864783-3271-1-git-send-email-linux@roeck-us.net>
 <1413864783-3271-37-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss-mx-na.foss.arm.com ([217.140.108.86]:46958 "EHLO
	foss-mx-na.foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932474AbaJVLX3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 22 Oct 2014 07:23:29 -0400
Content-Disposition: inline
In-Reply-To: <1413864783-3271-37-git-send-email-linux@roeck-us.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Will Deacon <Will.Deacon@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Tue, Oct 21, 2014 at 05:12:52AM +0100, Guenter Roeck wrote:
> Register with kernel poweroff handler instead of setting pm_power_off
> directly.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
