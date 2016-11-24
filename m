From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] PM / OPP: fix CPU device to be removed from OPP table in
 wrong order
Date: Thu, 24 Nov 2016 14:04:03 +0530
Message-ID: <20161124083403.GA29969@vireshk-i7>
References: <1479973761-21225-1-git-send-email-jy0922.shim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1479973761-21225-1-git-send-email-jy0922.shim@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joonyoung Shim <jy0922.shim@samsung.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, vireshk@kernel.org, nm@ti.com, sboyd@codeaurora.org, rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz, gregkh@linuxfoundation.org
List-Id: linux-pm@vger.kernel.org

Ho Joonyoung,

On 24-11-16, 16:49, Joonyoung Shim wrote:
> The device that creates OPP table first should be removed from dev_list
> of OPP table in last because it can be used by other resources
> (supported_hw, prop_name, regulator), but not now.

I am not sure what you are trying to do here? Why can't the CPU which
added the OPP should be removed last.

Can you give a real example where you see a problem ?

> If OPP table is
> shared by several CPUs, the CPU device that creates OPP table can be
> removed earlier than other CPU devices.

I don't think that's a problem, though I can be wrong for sure.

-- 
viresh
