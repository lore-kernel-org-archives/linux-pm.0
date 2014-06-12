From: Kees Cook <keescook@chromium.org>
Subject: [PATCH 0/2] make kASLR vs hibernation boot-time selectable
Date: Thu, 12 Jun 2014 12:46:57 -0700
Message-ID: <1402602419-27934-1-git-send-email-keescook@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>, Randy Dunlap <rdunlap@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Wei Yongjun <yongjun_wei@trendmicro.com.cn>, linux-doc@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Distros want to be able to offer CONFIG_RANDOMIZE_BASE as well as
CONFIG_HIBERNATION in a single kernel. Instead of making kASLR depend on
!HIBERNATION at compile time, allow kaslr to be selectable at boot time
(via "kaslr" kernel command line), which will disable hibernation in the
kernel. In this way the end user can choose which feature they want more
with hibernation continuing to stay enabled by default (no surprises).

-Kees
