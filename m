From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH v2 03/10] x86: assembly, use SYM_FUNC_END for functions
Date: Wed, 22 Mar 2017 09:26:10 -0500
Message-ID: <20170322142610.bo5c6wzlbqnxrgt3@treble>
References: <9ea5e137-61f9-dccc-bb9d-ac3ff86e5867@suse.cz>
 <20170320123222.15453-1-jslaby@suse.cz>
 <20170320123222.15453-3-jslaby@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45432 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751539AbdCVO0y (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 22 Mar 2017 10:26:54 -0400
Content-Disposition: inline
In-Reply-To: <20170320123222.15453-3-jslaby@suse.cz>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, x86@kernel.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org

On Mon, Mar 20, 2017 at 01:32:15PM +0100, Jiri Slaby wrote:
> Somewhere END was used to end a function, elsewhere, nothing was used.
> So unify it and mark them all by SYM_FUNC_END.
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>

For me these patches would be easier to review if the SYM_FUNC_START and
SYM_FUNC_END pairs for a given function are done in the same patch.

Also I noticed several cases in entry_64.S where the old ENTRY macro is
still used, and paired with SYM_FUNC_END.

Maybe there should be an x86 version of the deprecated ENTRY/ENDPROC/etc
macros which throw a warning or an error?

-- 
Josh
