From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v2 02/10] x86: assembly, FUNC_START for fn, DATA_START
 for data
Date: Wed, 22 Mar 2017 08:46:16 +0100
Message-ID: <20170322074616.GA10809@gmail.com>
References: <9ea5e137-61f9-dccc-bb9d-ac3ff86e5867@suse.cz>
 <20170320123222.15453-1-jslaby@suse.cz>
 <20170320123222.15453-2-jslaby@suse.cz>
 <20170321140840.GA23311@amd>
 <20170322072557.GA13904@gmail.com>
 <ee3242f9-1fab-f3a8-947d-85fc1a660a49@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <ee3242f9-1fab-f3a8-947d-85fc1a660a49@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: Pavel Machek <pavel@ucw.cz>, Josh Poimboeuf <jpoimboe@redhat.com>, mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, x86@kernel.org, linux-kernel@vger.kernel.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


* Jiri Slaby <jslaby@suse.cz> wrote:

> On 03/22/2017, 08:25 AM, Ingo Molnar wrote:
> > 
> > * Pavel Machek <pavel@ucw.cz> wrote:
> > 
> >> Hi!
> >>
> >>> -ENTRY(saved_rbp)	.quad	0
> >>> -ENTRY(saved_rsi)	.quad	0
> >>> -ENTRY(saved_rdi)	.quad	0
> >>> -ENTRY(saved_rbx)	.quad	0
> >>> +SYM_DATA_START(saved_rbp)		.quad	0
> >>> +SYM_DATA_START(saved_rsi)		.quad	0
> >>> +SYM_DATA_START(saved_rdi)		.quad	0
> >>> +SYM_DATA_START(saved_rbx)		.quad	0
> >>
> >> Does it make sense to call it SYM_DATA_*START* when there's no
> >> corresponding end?
> > 
> > That looks like a bug - I think we should strive for them to always be in pairs.
> > 
> > Jiri, Josh, could objtool help here perhaps, to detect 'non-terminated' 
> > SYM_*_START() uses? This could be done by emitting debug data into a special 
> > section and then analyzing that section for unpaired entries. The section can be 
> > discarded in the final link, it won't show up in the kernel image.
> 
> It should be easier than that. No introduction of other info needed --
> every global symbol without a ".type" or ".size" (i.e. SYM_*_END) should
> be a bug now.

I'm all for that!

Can we detect double ends as well - i.e. do a build check of the full syntax of 
these symbol definition primitives?

Thanks,

	Ingo
