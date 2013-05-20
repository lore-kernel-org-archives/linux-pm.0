From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Revert "x86-64, init: Do not set NX bits on non-NX
 capable hardware"
Date: Mon, 20 May 2013 11:18:16 -0700
Message-ID: <CA+55aFx1teO9rnO8z6wVpo28JaUsqS2eDQJupUzBiGbEiHgLVg@mail.gmail.com>
References: <20130514160108.GA5055@dhcp22.suse.cz>
	<1369062192-7066-1-git-send-email-mhocko@suse.cz>
	<519A483F.7070400@zytor.com>
	<20130520164335.GA9441@dhcp22.suse.cz>
	<CA+55aFzxdGOW=7-x+41U4SZB5par7jKU9vuuhFdsQfZOuLiLtw@mail.gmail.com>
	<519A67C9.6000709@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ve0-f174.google.com ([209.85.128.174]:52901 "EHLO
	mail-ve0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754856Ab3ETSSR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 20 May 2013 14:18:17 -0400
In-Reply-To: <519A67C9.6000709@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "H. Peter Anvin" <hpa@linux.intel.com>
Cc: Michal Hocko <mhocko@suse.cz>, "H. Peter Anvin" <hpa@zytor.com>, =?UTF-8?Q?Fernando_Luis_V=C3=A1zquez_Cao?= <fernando@oss.ntt.co.jp>, "Rafael J. Wysocki" <rjw@sisk.pl>, the arch/x86 maintainers <x86@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Mon, May 20, 2013 at 11:13 AM, H. Peter Anvin <hpa@linux.intel.com> wrote:
>
> Indeed.  Looks like we corrupt a random bit in memory on resume.

Well, in this case, it's probably the DEBUG_PAGEALLOC that Michal has
enabled, which causes a page fault - and then a triple fault - at
secondary CPU startup. And the triple fault then results in a reboot.
Which explains the symptoms he gets.

Without DEBUG_PAGEALLOC it ends up being "just" a single-bit corruption, yes.

             Linus
