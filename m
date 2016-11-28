From: Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH v3 3/5] thermal: rockchip: fixes invalid temperature case
Date: Mon, 28 Nov 2016 10:47:50 -0800
Message-ID: <20161128184749.GA70364@google.com>
References: <1480331524-18741-1-git-send-email-wxt@rock-chips.com>
 <1480331524-18741-4-git-send-email-wxt@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f46.google.com ([74.125.83.46]:33816 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751824AbcK1Sry (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Nov 2016 13:47:54 -0500
Received: by mail-pg0-f46.google.com with SMTP id x23so59702346pgx.1
        for <linux-pm@vger.kernel.org>; Mon, 28 Nov 2016 10:47:53 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1480331524-18741-4-git-send-email-wxt@rock-chips.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Caesar Wang <wxt@rock-chips.com>
Cc: rui.zhang@intel.com, edubezval@gmail.com, heiko@sntech.de, smbarber@chromium.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org

On Mon, Nov 28, 2016 at 07:12:02PM +0800, Caesar Wang wrote:
> The temp_to_code function will return 0 when we set the temperature to a
> invalid value (e.g. 61C, 62C, 63C....), that's unpractical. This patch
> will prevent this case happening. That will return the max analog value to
> indicate the temperature is invalid or over table temperature range.
> 
> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
> ---
> 
> Changes in v3:
> - fix trivial thing for error message nd return value.
> 
> Changes in v2:
> - As Brian commnets that restructure this to pass error codes back to the
>   upper layers.
> - Improve the commit message.
> 
> Changes in v1: None
> 
>  drivers/thermal/rockchip_thermal.c | 48 ++++++++++++++++++++++----------------
>  1 file changed, 28 insertions(+), 20 deletions(-)

Looks better now.

Reviewed-by: Brian Norris <briannorris@chromium.org>
