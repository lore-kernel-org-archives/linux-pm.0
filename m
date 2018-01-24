From: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] x86/centaur: Mark TSC invariant
Date: Wed, 24 Jan 2018 18:26:42 +0000
Message-ID: <20180124182642.0669c9bd@alans-desktop>
References: <1515980145-3693-1-git-send-email-timguo@zhaoxin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from www.llwyncelyn.cymru ([82.70.14.225]:36428 "EHLO fuzix.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964850AbeAXS06 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 24 Jan 2018 13:26:58 -0500
In-Reply-To: <1515980145-3693-1-git-send-email-timguo@zhaoxin.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: TimGuo <timguo@zhaoxin.com>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, mingo@kernel.org, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, brucechang@via-alliance.com, cooperyan@zhaoxin.com, qiyuanwang@zhaoxin.com, benjaminpan@viatech.com

On Mon, 15 Jan 2018 09:35:45 +0800
TimGuo <timguo@zhaoxin.com> wrote:

> Centaur CPU has a constant frequency TSC and that TSC does not stop in C-States.
> But because the flags are not set for that CPU, the TSC is treated as non constant
> frequency and assumed to stop in C-States, which makes it an unreliable and unusable
> clock source. Setting those flags tells the kernel that the TSC is usable, so it
> will select it over HPET. The effect of this is that reading time stamps (from kernel
> or userspace) will be faster and more efficient.

And this is true for all processors back to  IDT WinChip ?

Alan
