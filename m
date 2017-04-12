From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v2 03/10] x86: assembly, use SYM_FUNC_END for functions
Date: Wed, 12 Apr 2017 08:52:11 +0200
Message-ID: <20170412065211.GA16544@gmail.com>
References: <9ea5e137-61f9-dccc-bb9d-ac3ff86e5867@suse.cz>
 <20170320123222.15453-1-jslaby@suse.cz>
 <20170320123222.15453-3-jslaby@suse.cz>
 <20170322142610.bo5c6wzlbqnxrgt3@treble>
 <e4f7197c-559e-0dc2-c4e4-e369bf503cbb@suse.cz>
 <b7800998-2a60-b967-10fc-482ebd6fadf0@suse.cz>
 <20170410193512.d67vefxedoockybg@treble>
 <e79c90da-6785-e888-2f77-a5f2083698e0@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:35678 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751079AbdDLGwP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Apr 2017 02:52:15 -0400
Content-Disposition: inline
In-Reply-To: <e79c90da-6785-e888-2f77-a5f2083698e0@suse.cz>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>, mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, x86@kernel.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org


* Jiri Slaby <jslaby@suse.cz> wrote:

> On 04/10/2017, 09:35 PM, Josh Poimboeuf wrote:
> > The code should be in a mergeable state after each patch.  If only
> > patches 1-3 were merged, the code would be in an inconsistent state,
> > with some functions having confusing ENTRY/SYM_FUNC_END pairs.  That
> > complicates git history and also makes it harder to review each patch.
> > 
> > It would be cleaner to separate things out.  First, convert ENTRY/END
> > functions to use ENDPROC, which is a minor bug fix.  Then they can be
> > converted to the new SYM_FUNC_START/END macros in a separate patch.
> 
> OTOH I don't think touching and reviewing the same place twice is what
> actually maintainers would want to see. But as I wrote earlier, I can do
> whatever is preferred -- therefore I am asking before I start reworking
> the patches: maintainers, what do you prefer?

I'd lean towards Josh's suggestion of a more granular series. Having to review 
more is sometimes less, if the patches are more focused.

Thanks,

	Ingo
