From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH 0/8] tools/thermal: tmon: UI and build system
 improvements
Date: Tue, 17 Feb 2015 22:02:01 -0800
Message-ID: <20150217220201.6624ccaa@ultegra>
References: <1424225916-13488-1-git-send-email-computersforpeace@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:22742 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750845AbbBRGCG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 18 Feb 2015 01:02:06 -0500
In-Reply-To: <1424225916-13488-1-git-send-email-computersforpeace@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Brian Norris <computersforpeace@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Neil Horman <nhorman@tuxdriver.com>, Javi Merino <javi.merino@arm.com>, Florian Fainelli <f.fainelli@gmail.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On Tue, 17 Feb 2015 18:18:28 -0800
Brian Norris <computersforpeace@gmail.com> wrote:

> Hi,
> 
> This patch set includes a few build system improvements and a few UI
> fixes.
> 
> The last patch is ugly, and personally, I don't care if it's
> included. But it's an attempt to kill a warning. Better suggestions
> are welcome.
> 
Good improvements.
Acked-by: Jacob Pan <jacob.jun.pan@linux.intel.com>

> Thanks,
> Brian
> 
> Brian Norris (8):
>   tools/thermal: tmon: add --target-temp parameter
>   tools/thermal: tmon: add min/max macros
>   tools/thermal: tmon: tui: don't hard-code dialog window size
>     assumptions
>   tools/thermal: tmon: fixup tui windowing calculations
>   tools/thermal: tmon: add .gitignore
>   tools/thermal: tmon: support cross-compiling
>   tools/thermal: tmon: use pkg-config to determine library
> dependencies tools/thermal: tmon: silence 'set but not used' warnings
> 
>  tools/thermal/tmon/.gitignore |  1 +
>  tools/thermal/tmon/Makefile   | 15 ++++++++++++---
>  tools/thermal/tmon/tmon.8     |  2 ++
>  tools/thermal/tmon/tmon.c     | 14 ++++++++++++--
>  tools/thermal/tmon/tui.c      | 45
> ++++++++++++++++++++++++++++++++++--------- 5 files changed, 63
> insertions(+), 14 deletions(-) create mode 100644
> tools/thermal/tmon/.gitignore
> 
> -- 
> 1.9.1
> 




-- 
Jacob Pan
