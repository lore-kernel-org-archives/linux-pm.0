From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] driver core: Add missing dev->bus->need_parent_lock
 checks
Date: Thu, 13 Dec 2018 19:53:04 +0100
Message-ID: <20181213185304.GB18107@kroah.com>
References: <7586985.G9YL5ver76@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7586985.G9YL5ver76@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Martin Liu <liumartin@google.com>, Alan Stern <stern@rowland.harvard.edu>, LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Daniel Vetter <daniel.vetter@ffwll.ch>
List-Id: linux-pm@vger.kernel.org

On Thu, Dec 13, 2018 at 07:27:47PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> __device_release_driver() has to check dev->bus->need_parent_lock
> before dropping the parent lock and acquiring it again as it may
> attempt to drop a lock that hasn't been acquired or lock a device
> that shouldn't be locked and create a lock imbalance.
> 
> Fixes: 8c97a46af04b (driver core: hold dev's parent lock when needed)
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> This should go into -stable for everything over 4.18 methinks.

Does this fix Daniel's lockdep splat?

thanks,

greg k-h
