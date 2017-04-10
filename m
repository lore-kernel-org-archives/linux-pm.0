From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH v2 03/10] x86: assembly, use SYM_FUNC_END for functions
Date: Mon, 10 Apr 2017 14:35:12 -0500
Message-ID: <20170410193512.d67vefxedoockybg@treble>
References: <9ea5e137-61f9-dccc-bb9d-ac3ff86e5867@suse.cz>
 <20170320123222.15453-1-jslaby@suse.cz>
 <20170320123222.15453-3-jslaby@suse.cz>
 <20170322142610.bo5c6wzlbqnxrgt3@treble>
 <e4f7197c-559e-0dc2-c4e4-e369bf503cbb@suse.cz>
 <b7800998-2a60-b967-10fc-482ebd6fadf0@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53874 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751656AbdDJTfQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 10 Apr 2017 15:35:16 -0400
Content-Disposition: inline
In-Reply-To: <b7800998-2a60-b967-10fc-482ebd6fadf0@suse.cz>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, x86@kernel.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org

On Mon, Apr 10, 2017 at 01:23:46PM +0200, Jiri Slaby wrote:
> On 03/22/2017, 04:44 PM, Jiri Slaby wrote:
> > On 03/22/2017, 03:26 PM, Josh Poimboeuf wrote:
> >> On Mon, Mar 20, 2017 at 01:32:15PM +0100, Jiri Slaby wrote:
> >>> Somewhere END was used to end a function, elsewhere, nothing was used.
> >>> So unify it and mark them all by SYM_FUNC_END.
> >>>
> >>> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> >>
> >> For me these patches would be easier to review if the SYM_FUNC_START and
> >> SYM_FUNC_END pairs for a given function are done in the same patch.
> > 
> > This patchset was intended to make everything paired with minimum
> > changes. I certainly can change also counter-elements of each
> > added/changed one if you prefer.
> 
> So do really you want me to use the new macros while I am
> adding/changing the counter-macro? Is there anything else blocking the
> merge of the patches?

The code should be in a mergeable state after each patch.  If only
patches 1-3 were merged, the code would be in an inconsistent state,
with some functions having confusing ENTRY/SYM_FUNC_END pairs.  That
complicates git history and also makes it harder to review each patch.

It would be cleaner to separate things out.  First, convert ENTRY/END
functions to use ENDPROC, which is a minor bug fix.  Then they can be
converted to the new SYM_FUNC_START/END macros in a separate patch.

-- 
Josh
