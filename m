From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 4/8] Thermal: Add Thermal_trip sysfs node
Date: Wed, 19 Dec 2012 21:42:01 -0800
Message-ID: <20121220054201.GE28007@kroah.com>
References: <1355822977-4804-1-git-send-email-durgadoss.r@intel.com>
 <1355822977-4804-5-git-send-email-durgadoss.r@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1355822977-4804-5-git-send-email-durgadoss.r@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Durgadoss R <durgadoss.r@intel.com>
Cc: rui.zhang@intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, hongbo.zhang@linaro.org, wni@nvidia.com
List-Id: linux-pm@vger.kernel.org

On Tue, Dec 18, 2012 at 02:59:33PM +0530, Durgadoss R wrote:
> This patch adds a thermal_trip directory under
> /sys/class/thermal/zoneX. This directory contains
> the trip point values for sensors bound to this
> zone.

Eeek, you just broke userspace tools that now can no longer see these
entries :(

Why do you need to create a subdirectory?  As you found out, doing so
isn't the easiest, right?  That is on purpose.

I really wouldn't recommend doing this at all, please stick within the
'struct device' framework here, don't create new kobjects and hang sysfs
files off of them.

thanks,

greg k-h
