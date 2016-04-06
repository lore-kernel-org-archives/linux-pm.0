From: Paul Bolle <pebolle@tiscali.nl>
Subject: Re: [PATCH] Prefer kASLR over Hibernation
Date: Thu, 07 Apr 2016 00:41:46 +0200
Message-ID: <1459982506.30545.13.camel@tiscali.nl>
References: <20160406194404.GA11150@www.outflux.net>
	 <CAJZ5v0ieAd3WSiytzcdtD=eueLPk_SM1KgrqZXHBa6+bwK=KnQ@mail.gmail.com>
	 <20160406215638.GA25539@gmail.com>
	 <CAJZ5v0ir8PwyC2b1R0DaE+O5dH0cZUtrzTHxM4OAPxMY9hmNXA@mail.gmail.com>
	 <CAGXu5jJQBEivvcGnK4jB+5sbUpx9Sn+RieChXEgU-4ch9=1chA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from lb1-smtp-cloud3.xs4all.net ([194.109.24.22]:50351 "EHLO
	lb1-smtp-cloud3.xs4all.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754473AbcDFWl6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 6 Apr 2016 18:41:58 -0400
In-Reply-To: <CAGXu5jJQBEivvcGnK4jB+5sbUpx9Sn+RieChXEgU-4ch9=1chA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kees Cook <keescook@chromium.org>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Matt Redfearn <matt.redfearn@imgtec.com>, Yves-Alexis Perez <corsac@debian.org>, Emrah Demir <ed@abdsec.com>, Jonathan Corbet <corbet@lwn.net>, "x86@kernel.org" <x86@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Borislav Petkov <bp@suse.de>, Andy Lutomirski <luto@kernel.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>

On wo, 2016-04-06 at 15:16 -0700, Kees Cook wrote:
> And it seems like Fedora either doesn't either, or has a lot of people
> for whom it doesn't work:
> https://bugzilla.redhat.com/show_bug.cgi?id=1206936
> https://bugzilla.redhat.com/show_bug.cgi?id=1224151
> http://blog.kriptonium.com/2015/12/fedora-23-hibernate.html

Which are all variations on a theme: add "resume=$SWAP" to your kernel
commandline, aren't they?

(No idea why that's needed since Fedora 22, but it cost me quite a bit
of head scratching to find out.)

Once that parameter was set hibernate functioned again on the few
laptops I, well, manage that run Fedora 22.

Thanks,


Paul Bolle 
