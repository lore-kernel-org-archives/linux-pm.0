From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH] idle/i7300: Add CONFIG_PCI dependency
Date: Sun, 30 Oct 2016 17:32:47 +0100
Message-ID: <20161030163247.l5nj4b52un3nef6z@pd.tnic>
References: <20161030114228.24114-1-bp@alien8.de>
 <1e525299-ffb2-4031-a215-c9407c22a312@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:56004 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756704AbcJ3Qcv (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 30 Oct 2016 12:32:51 -0400
Content-Disposition: inline
In-Reply-To: <1e525299-ffb2-4031-a215-c9407c22a312@infradead.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Randy Dunlap <rdunlap@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Andy Henroid <andrew.d.henroid@intel.com>, linux-pm@vger.kernel.org

On Sun, Oct 30, 2016 at 07:54:44AM -0700, Randy Dunlap wrote:
> 	depends on PCI
> (no CONFIG_ prefix)

Whoops!

Thanks. FWIW, it didn't fire even with "depends on CONFIG_PCI" anymore.
Didn't investigate why though...

---
From: Borislav Petkov <bp@suse.de>
Date: Sun, 30 Oct 2016 14:39:28 +0100
Subject: [PATCH] idle/i7300: Add CONFIG_PCI dependency
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

... in order to fix this randconfig build warning:

  drivers/idle/i7300_idle.c: In function ‘i7300_idle_stop’:
  ./include/asm-generic/bug.h:117:24: warning: ‘got_ctl’ is used uninitialized in this function [-Wuninitialized]
    int __ret_warn_once = !!(condition);   \
                          ^
  drivers/idle/i7300_idle.c:415:5: note: ‘got_ctl’ was declared here
    u8 got_ctl;
       ^

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Andy Henroid <andrew.d.henroid@intel.com>
Cc: linux-pm@vger.kernel.org
---
 drivers/idle/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/idle/Kconfig b/drivers/idle/Kconfig
index 4732dfc15447..a066fca3688f 100644
--- a/drivers/idle/Kconfig
+++ b/drivers/idle/Kconfig
@@ -18,6 +18,7 @@ config I7300_IDLE_IOAT_CHANNEL
 config I7300_IDLE
 	tristate "Intel chipset idle memory power saving driver"
 	select I7300_IDLE_IOAT_CHANNEL
+	depends on PCI
 	help
 	  Enable memory power savings when idle with certain Intel server
 	  chipsets. The chipset must have I/O AT support, such as the
-- 
2.10.0

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
