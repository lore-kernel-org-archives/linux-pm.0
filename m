From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] power tools for Linux-3.8
Date: Tue, 18 Dec 2012 12:38:52 -0800
Message-ID: <CA+55aFxrqUErKG8n1gSGER50_6mSh3DNpiQV0RT1VVaOFOT_VA@mail.gmail.com>
References: <50CF6FC5.20005@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:65374 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751348Ab2LRUjN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 18 Dec 2012 15:39:13 -0500
In-Reply-To: <50CF6FC5.20005@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>

On Mon, Dec 17, 2012 at 11:17 AM, Len Brown <lenb@kernel.org> wrote:
>
> There will be a logical conflict with the uapi changes
> which breaks the turbostat build.  It can be fixed this way:

I *think* you meant to point me at the 'release' branch, so that's
what I pulled.

What you actually pointed me at was the 'next' branch:

>   git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git next

which had that fixed up as a separate commit (which breaks bisecting
the build, but I guess that doesn't much matter for something small
like turbostat).

            Linus
