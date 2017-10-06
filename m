From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH v4 01/27] linkage: new macros for assembler symbols
Date: Fri, 6 Oct 2017 10:23:55 -0500
Message-ID: <20171006152355.73fljxsihnejppx4@treble>
References: <20171002091246.28432-1-jslaby@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59098 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751522AbdJFPX6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 6 Oct 2017 11:23:58 -0400
Content-Disposition: inline
In-Reply-To: <20171002091246.28432-1-jslaby@suse.cz>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, x86@kernel.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Ingo Molnar <mingo@kernel.org>, Juergen Gross <jgross@suse.com>, Len Brown <len.brown@intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, linux-pm@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Peter Zijlstra <a.p.zijlstra@chello.nl>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, xen-devel@lists.xenproject.org

On Mon, Oct 02, 2017 at 11:12:20AM +0200, Jiri Slaby wrote:
>    SYM_CODE_INNER_LABEL -- only for labels in the middle of code
>    SYM_CODE_INNER_LABEL_NOALIGN -- only for labels in the middle of code

Why are the inner labels aligned by default?  Seems like unaligned would
be the most common case.

> 
> d) For data
>    SYM_DATA_START -- global data symbol
>    SYM_DATA_END -- the end of the SYM_DATA_START symbol
>    SYM_DATA_END_LABEL -- the labeled end of SYM_DATA_START symbol
>    SYM_DATA_SIMPLE -- start+end wrapper around simple global data
>    SYM_DATA_SIMPLE_LOCAL -- start+end wrapper around simple local data

"SIMPLE" seems superfluous, how about s/SYM_DATA_SIMPLE/SYM_DATA/ ?

-- 
Josh
