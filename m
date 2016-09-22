From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 1/2] PM / OPP: compatible is an optional property
Date: Thu, 22 Sep 2016 12:24:30 -0700
Message-ID: <483bea3c-a1b4-ce5d-e720-d69fc943ab50@codeaurora.org>
References: <be2c4fb0bb58f5b29facbc6f5aaf3dca13cf209e.1474450324.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <be2c4fb0bb58f5b29facbc6f5aaf3dca13cf209e.1474450324.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 09/21/2016 02:32 AM, Viresh Kumar wrote:
> It was never compulsory to have a compatible string in the OPP table.
> Fix the documentation to mark it optional.
>
> Also update its description a bit.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

Why? I'd prefer the compatible string to be required so we know what
sort of node it is.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
