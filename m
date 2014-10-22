From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2 22/47] power/reset: restart-poweroff: Register with
 kernel poweroff handler
Date: Wed, 22 Oct 2014 15:19:12 -0700
Message-ID: <20141022221912.GB15671@roeck-us.net>
References: <1413864783-3271-1-git-send-email-linux@roeck-us.net>
 <1413864783-3271-23-git-send-email-linux@roeck-us.net>
 <20141022213222.GA28840@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20141022213222.GA28840@earth.universe>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Oct 22, 2014 at 11:32:22PM +0200, Sebastian Reichel wrote:
> Hi,
> 
> On Mon, Oct 20, 2014 at 09:12:38PM -0700, Guenter Roeck wrote:
> > Register with kernel poweroff handler instead of setting pm_power_off
> > directly.  Register as poweroff handler of last resort since the driver
> > does not really power off the system but executes a restart.
> > 
> > Drop remove function since it is no longer needed.
> > 
> > Cc: Sebastian Reichel <sre@kernel.org>
> > Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> > Cc: David Woodhouse <dwmw2@infradead.org>
> > Acked-by: Andrew Lunn <andrew@lunn.ch>
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> 
> Acked-By: Sebastian Reichel <sre@kernel.org>
> 
Thanks for all the Acks!

Guenter
