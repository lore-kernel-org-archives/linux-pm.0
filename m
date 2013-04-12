From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 1/2] MAINTAINERS: Add Thermal subsystem co-maintainer
Date: Fri, 12 Apr 2013 09:59:02 +0800
Message-ID: <1365731942.2183.41.camel@rzhang1-mobl4>
References: <1365605049-22635-1-git-send-email-eduardo.valentin@ti.com>
	 <1365605049-22635-2-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:19583 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752282Ab3DLB70 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 11 Apr 2013 21:59:26 -0400
In-Reply-To: <1365605049-22635-2-git-send-email-eduardo.valentin@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@ti.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-pm@vger.kernel.org

On Wed, 2013-04-10 at 10:44 -0400, Eduardo Valentin wrote:
> Adding myself as co-maintainer for the thermal subsystem.
> 
> The agreed work split will be so that as a co-maintainer
> I will be taking care of platform thermal drivers, non-ACPI
> thermal drivers and making sure the thermal framework core
> code will continue to suffice the non-ACPI thermal needs.
> 
> Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
Acked-by: Zhang Rui <rui.zhang@intel.com>

thanks,
rui
> ---
>  MAINTAINERS |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 836a618..0850f21 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7899,6 +7899,7 @@ F:	arch/xtensa/
>  
>  THERMAL
>  M:      Zhang Rui <rui.zhang@intel.com>
> +M:      Eduardo Valentin <eduardo.valentin@ti.com>
>  L:      linux-pm@vger.kernel.org
>  T:      git git://git.kernel.org/pub/scm/linux/kernel/git/rzhang/linux.git
>  S:      Supported


