From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v3] PM / OPP: fix debug/error messages in
 dev_pm_opp_of_get_sharing_cpus()
Date: Thu, 20 Oct 2016 12:42:38 +0530
Message-ID: <20161020071238.GN11766@vireshk-i7>
References: <1476947569-23552-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1476947569-23552-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-pm@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>, linux-kernel@vger.kernel.org, Nishanth Menon <nm@ti.com>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Viresh Kumar <vireshk@kernel.org>
List-Id: linux-pm@vger.kernel.org

On 20-10-16, 16:12, Masahiro Yamada wrote:
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
> 
> Changes in v3:
>   - Revive __func__
> 
> Changes in v2:
>   - Reword git-log slightly
>      comments -> log messages

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
