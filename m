From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH V2 1/7] PM / OPP: -ENOSYS is applicable only to syscalls
Date: Mon, 2 May 2016 17:42:47 -0700
Message-ID: <20160503004247.GJ3492@codeaurora.org>
References: <cover.1461727086.git.viresh.kumar@linaro.org>
 <ef830e7b9737612f6594b3580c6a3731172a4c76.1461727086.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <ef830e7b9737612f6594b3580c6a3731172a4c76.1461727086.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, arnd.bergmann@linaro.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 04/27, Viresh Kumar wrote:
> Some of the routines have used -ENOSYS for the cases where the
> functionality isn't implemented in the kernel. But ENOSYS is supposed to
> be used only for syscalls.
> 
> Replace that with -ENOTSUPP, which specifically means that the operation
> isn't supported.
> 
> While at it, replace exiting -EINVAL errors for similar cases to
> -ENOTSUPP.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
