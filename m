From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] PM / OPP: Initialize regulator pointer to an error value
Date: Mon, 15 Feb 2016 22:14:10 +0530
Message-ID: <20160215164410.GE6334@vireshk-i7>
References: <1455544758-7718-1-git-send-email-jonathanh@nvidia.com>
 <743509d913cbc0e725bea52281be03b009e02bb5.1455553501.git.viresh.kumar@linaro.org>
 <56C1FFE6.1010806@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <56C1FFE6.1010806@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 15-02-16, 16:42, Jon Hunter wrote:
> 
> On 15/02/16 16:26, Viresh Kumar wrote:
> > We are currently required to do two checks for regulator pointer:
> > IS_ERR() and IS_NULL().
> > 
> > And multiple instances are reported, about both of these not being used
> > consistently and so resulting in crashes.
> > 
> > Fix that by initializing regulator pointer with an error value and
> > checking it only against an error.
> > 
> > This makes code consistent and efficient.
> > 
> > Reported-by: Jon Hunter <jonathanh@nvidia.com>
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> Tested-by: Jon Hunter <jonathanh@nvidia.com>

Thanks a lot Jon.

-- 
viresh
