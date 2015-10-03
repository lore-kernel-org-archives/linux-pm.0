From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH] tools/thermal: tmon: use pkg-config also for CFLAGS
Date: Sat, 3 Oct 2015 06:03:38 -0700
Message-ID: <20151003060338.7a37611e@yairi>
References: <1443779445-19821-1-git-send-email-olaf@aepfle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:9656 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752143AbbJCNDj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sat, 3 Oct 2015 09:03:39 -0400
In-Reply-To: <1443779445-19821-1-git-send-email-olaf@aepfle.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Olaf Hering <olaf@aepfle.de>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On Fri,  2 Oct 2015 09:50:45 +0000
Olaf Hering <olaf@aepfle.de> wrote:

> The header <panel.h> might be in /usr/include/ncursesw, which is not
> part of the standard include path. This fixes compile on openSUSE.
> 
Acked:by: Jacob Pan <jacob.jun.pan@linux.intel.com>

thanks

> Signed-off-by: Olaf Hering <olaf@aepfle.de>
> ---
>  tools/thermal/tmon/Makefile | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tools/thermal/tmon/Makefile b/tools/thermal/tmon/Makefile
> index 2e83dd3..3a961e9 100644
> --- a/tools/thermal/tmon/Makefile
> +++ b/tools/thermal/tmon/Makefile
> @@ -22,6 +22,9 @@ TMON_LIBS += $(shell pkg-config --libs $(STATIC)
> panelw ncursesw 2> /dev/null || pkg-config --libs $(STATIC) panel
> ncurses 2> /dev/null || \ echo -lpanel -lncurses)
>  
> +CFLAGS    += $(shell pkg-config --cflags $(STATIC) panelw ncursesw
> 2> /dev/null || \
> +		     pkg-config --cflags $(STATIC) panel ncurses
> 2> /dev/null) +
>  OBJS = tmon.o tui.o sysfs.o pid.o
>  OBJS +=
>  

[Jacob Pan]
