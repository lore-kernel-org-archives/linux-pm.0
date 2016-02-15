From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH] PM / OPP: Initialize regulator pointer to an error value
Date: Mon, 15 Feb 2016 16:42:14 +0000
Message-ID: <56C1FFE6.1010806@nvidia.com>
References: <1455544758-7718-1-git-send-email-jonathanh@nvidia.com>
 <743509d913cbc0e725bea52281be03b009e02bb5.1455553501.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <743509d913cbc0e725bea52281be03b009e02bb5.1455553501.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


On 15/02/16 16:26, Viresh Kumar wrote:
> We are currently required to do two checks for regulator pointer:
> IS_ERR() and IS_NULL().
> 
> And multiple instances are reported, about both of these not being used
> consistently and so resulting in crashes.
> 
> Fix that by initializing regulator pointer with an error value and
> checking it only against an error.
> 
> This makes code consistent and efficient.
> 
> Reported-by: Jon Hunter <jonathanh@nvidia.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Thanks
Jon
