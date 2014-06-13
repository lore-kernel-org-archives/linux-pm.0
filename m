From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3 0/2] make kASLR vs hibernation boot-time selectable
Date: Sat, 14 Jun 2014 01:25:11 +0200
Message-ID: <2113876.sBNaASbVKF@vostro.rjw.lan>
References: <1402691436-20138-1-git-send-email-keescook@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:51181 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753502AbaFMXHo (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 13 Jun 2014 19:07:44 -0400
In-Reply-To: <1402691436-20138-1-git-send-email-keescook@chromium.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kees Cook <keescook@chromium.org>
Cc: linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Josh Boyer <jwboyer@fedoraproject.org>, "H. Peter Anvin" <hpa@zytor.com>, Randy Dunlap <rdunlap@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, x86@kernel.org, Len Brown <len.brown@intel.com>, Wei Yongjun <yongjun_wei@trendmicro.com.cn>, linux-doc@vger.kernel.org, linux-pm@vger.kernel.org

On Friday, June 13, 2014 01:30:34 PM Kees Cook wrote:
> Distros want to be able to offer CONFIG_RANDOMIZE_BASE as well as
> CONFIG_HIBERNATION in a single kernel. Instead of making kASLR depend on
> !HIBERNATION at compile time, allow kaslr to be selectable at boot time
> (via "kaslr" kernel command line), which will disable hibernation in the
> kernel. In this way the end user can choose which feature they want more
> with hibernation continuing to stay enabled by default (no surprises).
> 
> This also has the benefit of being able to entirely disable hibernation
> from the kernel command line, regardless of kASLR, which is a separately
> desired feature as well.
> 
> v3:
> - switch from EINVAL to EPERM (pavel, jwboyer)
> v2:
> - rework using kernel command line instead of hibernation_mode (rjw)

That looks kind of OK.

Do you want me to push this through my tree?

Rafael

