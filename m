From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v3] PM / OPP: fix debug/error messages in
 dev_pm_opp_of_get_sharing_cpus()
Date: Thu, 20 Oct 2016 12:18:58 -0700
Message-ID: <20161020191858.GC26139@codeaurora.org>
References: <1476947569-23552-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1476947569-23552-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Nishanth Menon <nm@ti.com>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Viresh Kumar <vireshk@kernel.org>
List-Id: linux-pm@vger.kernel.org

On 10/20, Masahiro Yamada wrote:
> These log messages are wrong because _of_get_opp_desc_node() returns
> an operating-points-v2 node.
> 
> Commit a6eed752f5fb ("PM / OPP: passing NULL to PTR_ERR()") fixed
> static checker warnings, and reworded the messages at the same time
> (but the latter was not mentioned in the git-log).
> 
> Restore the correct messages.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
