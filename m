From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/2] hibernate: create one-way disable mode
Date: Thu, 12 Jun 2014 22:12:19 +0200
Message-ID: <2990889.du3yZFtply@vostro.rjw.lan>
References: <1402602419-27934-1-git-send-email-keescook@chromium.org> <1402602419-27934-2-git-send-email-keescook@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:57665 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751836AbaFLTyw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 12 Jun 2014 15:54:52 -0400
In-Reply-To: <1402602419-27934-2-git-send-email-keescook@chromium.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kees Cook <keescook@chromium.org>
Cc: linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Wei Yongjun <yongjun_wei@trendmicro.com.cn>, linux-doc@vger.kernel.org, linux-pm@vger.kernel.org

On Thursday, June 12, 2014 12:46:58 PM Kees Cook wrote:
> To support using kernel features that are not compatible with hibernation,
> this creates a "disabled" hibernation state so that hibernation selection
> can be a boot-time choice instead of only a compile-time choice.

Well, hibernation_mode is only to determine how to turn the system off
after saving the image.  It doesn't say how the whole hibernation is
supposed to work (or not).

Please just extend the hibernate= command line argument to cover this.

Rafael

