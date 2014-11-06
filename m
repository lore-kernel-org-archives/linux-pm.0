From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v5 36/48] arm64: psci: Register with kernel power-off
 handler
Date: Thu, 6 Nov 2014 10:51:58 -0800
Message-ID: <20141106185158.GC31712@roeck-us.net>
References: <1415292213-28652-1-git-send-email-linux@roeck-us.net>
 <1415292213-28652-37-git-send-email-linux@roeck-us.net>
 <20141106172222.GA15384@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20141106172222.GA15384@leverpostej>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Nov 06, 2014 at 05:22:23PM +0000, Mark Rutland wrote:
> On Thu, Nov 06, 2014 at 04:43:20PM +0000, Guenter Roeck wrote:
> > Register with kernel power-off handler instead of setting pm_power_off
> > directly.
> > 
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will.deacon@arm.com>
> > Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> 
> I just fetched your current poweroff-handler branch and gave it a spin
> on Juno. It looks like this hasn't broken since the last time I tried
> it. :)
> 
> Tested-by: Mark Rutland <mark.rutland@arm.com>
> 
Thanks a lot!

Guenter
