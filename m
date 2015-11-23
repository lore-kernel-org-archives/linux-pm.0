From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V2 1/3] PM / OPP: Add missing doc comments
Date: Tue, 24 Nov 2015 00:14:27 +0100
Message-ID: <1615822.r71ZUR2UFj@vostro.rjw.lan>
References: <cover.1447904566.git.viresh.kumar@linaro.org> <b8d9a0c3e23246f44d853d41463f229d5257cbf4.1447904566.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:42954 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753890AbbKWWot (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 23 Nov 2015 17:44:49 -0500
In-Reply-To: <b8d9a0c3e23246f44d853d41463f229d5257cbf4.1447904566.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>, nm@ti.com, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>

On Thursday, November 19, 2015 09:13:56 AM Viresh Kumar wrote:
> Few doc-style comments were missing, add them. Rearrange another one to
> match the sequence within the structure.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> Acked-by: Pavel Machek <pavel@ucw.cz>
> Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
>  drivers/base/power/opp/opp.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/power/opp/opp.h b/drivers/base/power/opp/opp.h
> index a6bd8d2c2b47..b8880c7f8be1 100644
> --- a/drivers/base/power/opp/opp.h
> +++ b/drivers/base/power/opp/opp.h
> @@ -51,8 +51,8 @@ extern struct mutex dev_opp_list_lock;
>   *		are protected by the dev_opp_list_lock for integrity.
>   *		IMPORTANT: the opp nodes should be maintained in increasing
>   *		order.
> - * @dynamic:	not-created from static DT entries.
>   * @available:	true/false - marks if this OPP as available or not
> + * @dynamic:	not-created from static DT entries.
>   * @turbo:	true if turbo (boost) OPP
>   * @suspend:	true if suspend OPP
>   * @rate:	Frequency in hertz
> @@ -126,7 +126,9 @@ struct device_list_opp {
>   * @dev_list:	list of devices that share these OPPs
>   * @opp_list:	list of opps
>   * @np:		struct device_node pointer for opp's DT node.
> + * @clock_latency_ns_max: Max clock latency in nanoseconds.
>   * @shared_opp: OPP is shared between multiple devices.
> + * @suspend_opp: Pointer to OPP to be used during device suspend.
>   * @dentry:	debugfs dentry pointer of the real device directory (not links).
>   * @dentry_name: Name of the real dentry.
>   *

Queued up for 4.5, thanks!

ACKs are needed for the other two.

Thanks,
Rafael

