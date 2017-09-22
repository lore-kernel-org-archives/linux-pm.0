From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v2] PM / OPP: Use snprintf to avoid kasprintf and kfree
Date: Fri, 22 Sep 2017 00:17:49 -0700
Message-ID: <20170922071749.GC457@codeaurora.org>
References: <6cdcf0c59a9a045941188356a2c4973c876c9fc6.1505972576.git.arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6cdcf0c59a9a045941188356a2c4973c876c9fc6.1505972576.git.arvind.yadav.cs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: vireshk@kernel.org, nm@ti.com, rjw@rjwysocki.net, pavel@ucw.cz, len.brown@intel.com, gregkh@linuxfoundation.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 09/21, Arvind Yadav wrote:
> Use snprintf to avoid unnecessary initializations, avoid calling kfree.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
