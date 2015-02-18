From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH 0/8] tools/thermal: tmon: UI and build system improvements
Date: Wed, 18 Feb 2015 09:49:00 -0800
Message-ID: <54E4D08C.4020909@gmail.com>
References: <1424225916-13488-1-git-send-email-computersforpeace@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424225916-13488-1-git-send-email-computersforpeace@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Brian Norris <computersforpeace@gmail.com>, Zhang Rui <rui.zhang@intel.com>, jacob.jun.pan@linux.intel.com
Cc: Neil Horman <nhorman@tuxdriver.com>, Javi Merino <javi.merino@arm.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 17/02/15 18:18, Brian Norris wrote:
> Hi,
> 
> This patch set includes a few build system improvements and a few UI fixes.
> 
> The last patch is ugly, and personally, I don't care if it's included. But it's
> an attempt to kill a warning. Better suggestions are welcome.

FWIW:

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>

> 
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
>   tools/thermal: tmon: use pkg-config to determine library dependencies
>   tools/thermal: tmon: silence 'set but not used' warnings
> 
>  tools/thermal/tmon/.gitignore |  1 +
>  tools/thermal/tmon/Makefile   | 15 ++++++++++++---
>  tools/thermal/tmon/tmon.8     |  2 ++
>  tools/thermal/tmon/tmon.c     | 14 ++++++++++++--
>  tools/thermal/tmon/tui.c      | 45 ++++++++++++++++++++++++++++++++++---------
>  5 files changed, 63 insertions(+), 14 deletions(-)
>  create mode 100644 tools/thermal/tmon/.gitignore
> 


-- 
Florian
