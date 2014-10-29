From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH v2 10/10] power/reset: brcmstb: Register with kernel
 restart handler
Date: Tue, 28 Oct 2014 18:51:58 -0700
Message-ID: <20141029015158.GC23619@ld-irv-0074>
References: <1412099316-23167-1-git-send-email-linux@roeck-us.net>
 <1412099316-23167-11-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1412099316-23167-11-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-kernel@vger.kernel.org, Marc Carino <marc.ceeeee@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Tue, Sep 30, 2014 at 10:48:36AM -0700, Guenter Roeck wrote:
> Register with kernel restart handler instead of setting arm_pm_restart directly.
> 
> Cc: Marc Carino <marc.ceeeee@gmail.com>
> Cc: Brian Norris <computersforpeace@gmail.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Tested on top of linux-next:

Tested-by: Brian Norris <computersforpeace@gmail.com>
Acked-by: Brian Norris <computersforpeace@gmail.com>
