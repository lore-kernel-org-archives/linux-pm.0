From: Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH v2 5/5] thermal: rockchip: handle set_trips without the
 trip points
Date: Wed, 23 Nov 2016 10:39:53 -0800
Message-ID: <20161123183953.GB12380@google.com>
References: <1479911374-22006-1-git-send-email-wxt@rock-chips.com>
 <1479911374-22006-6-git-send-email-wxt@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1479911374-22006-6-git-send-email-wxt@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Caesar Wang <wxt@rock-chips.com>
Cc: edubezval@gmail.com, rui.zhang@intel.com, linux-rockchip@lists.infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, smbarber@chromium.org
List-Id: linux-pm@vger.kernel.org

On Wed, Nov 23, 2016 at 10:29:34PM +0800, Caesar Wang wrote:
> In some cases, some sensors didn't need the trip points, the
> set_trips will return {-INT_MAX, INT_MAX} to trigger thermal alarm.
> 
> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
> ---
> 
> Changes in v2:
> - Fixes something as Brian comments on
>   https://patchwork.kernel.org/patch/9440989.
> 
> Changes in v1: None

I think this looks better.

Reviewed-by: Brian Norris <briannorris@chromium.org>
