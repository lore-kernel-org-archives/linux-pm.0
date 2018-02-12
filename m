From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] PM: cpuidle: Fix cpuidle_poll_state_init() prototype
Date: Mon, 12 Feb 2018 10:21:35 +0100
Message-ID: <4262687.hNuoLAlOtc@aspire.rjw.lan>
References: <20180122162747.19103-1-ville.syrjala@linux.intel.com> <20180206163134.GO5453@intel.com> <1862424.1bTBpgPzTf@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1862424.1bTBpgPzTf@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, x86 <x86@kernel.org>, Jiri Koshina <jikos@kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Commit f85942207516 (x86: PM: Make APM idle driver initialize polling
state) made apm_init() call cpuidle_poll_state_init(), but that only
is defined for CONFIG_CPU_IDLE set, so make the empty stub of it
available for CONFIG_CPU_IDLE unset too to fix the resulting build
issue.

Fixes: f85942207516 (x86: PM: Make APM idle driver initialize polling state)
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/linux/cpuidle.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-pm/include/linux/cpuidle.h
===================================================================
--- linux-pm.orig/include/linux/cpuidle.h
+++ linux-pm/include/linux/cpuidle.h
@@ -225,7 +225,7 @@ static inline void cpuidle_coupled_paral
 }
 #endif
 
-#ifdef CONFIG_ARCH_HAS_CPU_RELAX
+#if defined(CONFIG_CPU_IDLE) && defined(CONFIG_ARCH_HAS_CPU_RELAX)
 void cpuidle_poll_state_init(struct cpuidle_driver *drv);
 #else
 static inline void cpuidle_poll_state_init(struct cpuidle_driver *drv) {}
