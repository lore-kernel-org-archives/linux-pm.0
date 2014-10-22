From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2 36/47] arm64: psci: Register with kernel poweroff
 handler
Date: Wed, 22 Oct 2014 08:38:07 -0700
Message-ID: <20141022153807.GB26229@roeck-us.net>
References: <1413864783-3271-1-git-send-email-linux@roeck-us.net>
 <1413864783-3271-37-git-send-email-linux@roeck-us.net>
 <20141022112300.GA15370@e104818-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20141022112300.GA15370@e104818-lin.cambridge.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Will Deacon <Will.Deacon@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Oct 22, 2014 at 12:23:03PM +0100, Catalin Marinas wrote:
> On Tue, Oct 21, 2014 at 05:12:52AM +0100, Guenter Roeck wrote:
> > Register with kernel poweroff handler instead of setting pm_power_off
> > directly.
> > 
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will.deacon@arm.com>
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> 
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>

Thanks!

Guenter
