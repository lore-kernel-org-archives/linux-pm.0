From: Kees Cook <keescook@chromium.org>
Subject: [PATCH v3 0/2] make kASLR vs hibernation boot-time selectable
Date: Fri, 13 Jun 2014 13:30:34 -0700
Message-ID: <1402691436-20138-1-git-send-email-keescook@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>, Pavel Machek <pavel@ucw.cz>, Josh Boyer <jwboyer@fedoraproject.org>, "H. Peter Anvin" <hpa@zytor.com>, Randy Dunlap <rdunlap@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, x86@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Wei Yongjun <yongjun_wei@trendmicro.com.cn>, linux-doc@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Distros want to be able to offer CONFIG_RANDOMIZE_BASE as well as
CONFIG_HIBERNATION in a single kernel. Instead of making kASLR depend on
!HIBERNATION at compile time, allow kaslr to be selectable at boot time
(via "kaslr" kernel command line), which will disable hibernation in the
kernel. In this way the end user can choose which feature they want more
with hibernation continuing to stay enabled by default (no surprises).

This also has the benefit of being able to entirely disable hibernation
from the kernel command line, regardless of kASLR, which is a separately
desired feature as well.

v3:
- switch from EINVAL to EPERM (pavel, jwboyer)
v2:
- rework using kernel command line instead of hibernation_mode (rjw)
