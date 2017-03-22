From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v2 02/10] x86: assembly, FUNC_START for fn, DATA_START
 for data
Date: Wed, 22 Mar 2017 08:25:57 +0100
Message-ID: <20170322072557.GA13904@gmail.com>
References: <9ea5e137-61f9-dccc-bb9d-ac3ff86e5867@suse.cz>
 <20170320123222.15453-1-jslaby@suse.cz>
 <20170320123222.15453-2-jslaby@suse.cz>
 <20170321140840.GA23311@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:35371 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757351AbdCVH0X (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 22 Mar 2017 03:26:23 -0400
Content-Disposition: inline
In-Reply-To: <20170321140840.GA23311@amd>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Jiri Slaby <jslaby@suse.cz>, mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, x86@kernel.org, jpoimboe@redhat.com, linux-kernel@vger.kernel.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org


* Pavel Machek <pavel@ucw.cz> wrote:

> Hi!
> 
> > -ENTRY(saved_rbp)	.quad	0
> > -ENTRY(saved_rsi)	.quad	0
> > -ENTRY(saved_rdi)	.quad	0
> > -ENTRY(saved_rbx)	.quad	0
> > +SYM_DATA_START(saved_rbp)		.quad	0
> > +SYM_DATA_START(saved_rsi)		.quad	0
> > +SYM_DATA_START(saved_rdi)		.quad	0
> > +SYM_DATA_START(saved_rbx)		.quad	0
> 
> Does it make sense to call it SYM_DATA_*START* when there's no
> corresponding end?

That looks like a bug - I think we should strive for them to always be in pairs.

Jiri, Josh, could objtool help here perhaps, to detect 'non-terminated' 
SYM_*_START() uses? This could be done by emitting debug data into a special 
section and then analyzing that section for unpaired entries. The section can be 
discarded in the final link, it won't show up in the kernel image.

We don't ever nest symbols, right?

> Plus... it looks like saved_rsi (and friends) are only used inside
> wakeup_64.S. Could we just delete the "ENTRY" annotations?

That appears to make sense as well.

Thanks,

	Ingo
