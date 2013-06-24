From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 1/1] thermal: MAINTAINERS: Add git tree path for SoC
 specific updates
Date: Mon, 24 Jun 2013 09:05:51 +0800
Message-ID: <1372035951.2097.0.camel@rzhang1-mobl4>
References: <1371848830-5261-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:46146 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751060Ab3FXBFz (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 23 Jun 2013 21:05:55 -0400
In-Reply-To: <1371848830-5261-1-git-send-email-eduardo.valentin@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@ti.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, 2013-06-21 at 17:07 -0400, Eduardo Valentin wrote:
> To reduce thermal maintenance load on Rui, SoC specific patches would be
> applied by me now. Rui Zhang will pull in these changes from time to time (at
> rc's). Additionally I would be sending him pull request for every merge
> window and rc's (for fixes).
> 
> Branch names would be: next and fixes.
> 
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: linux-pm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>

Acked-by: Zhang Rui <rui.zhang@intel.com>

thanks,
rui
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3d7782b..48ff6282 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8032,6 +8032,7 @@ M:      Zhang Rui <rui.zhang@intel.com>
>  M:      Eduardo Valentin <eduardo.valentin@ti.com>
>  L:      linux-pm@vger.kernel.org
>  T:      git git://git.kernel.org/pub/scm/linux/kernel/git/rzhang/linux.git
> +T:      git git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal.git
>  Q:      https://patchwork.kernel.org/project/linux-pm/list/
>  S:      Supported
>  F:      drivers/thermal/


