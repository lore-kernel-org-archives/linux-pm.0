From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v2 02/10] x86: assembly, FUNC_START for fn, DATA_START
 for data
Date: Thu, 23 Mar 2017 08:38:20 +0100
Message-ID: <20170323073819.GA14258@gmail.com>
References: <9ea5e137-61f9-dccc-bb9d-ac3ff86e5867@suse.cz>
 <20170320123222.15453-1-jslaby@suse.cz>
 <20170320123222.15453-2-jslaby@suse.cz>
 <20170321140840.GA23311@amd>
 <20170322072557.GA13904@gmail.com>
 <ee3242f9-1fab-f3a8-947d-85fc1a660a49@suse.cz>
 <20170322074616.GA10809@gmail.com>
 <20170322141123.opss3u4gpupqgl2q@treble>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35770 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932447AbdCWHib (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 23 Mar 2017 03:38:31 -0400
Content-Disposition: inline
In-Reply-To: <20170322141123.opss3u4gpupqgl2q@treble>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Jiri Slaby <jslaby@suse.cz>, Pavel Machek <pavel@ucw.cz>, mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, x86@kernel.org, linux-kernel@vger.kernel.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org


* Josh Poimboeuf <jpoimboe@redhat.com> wrote:

> On Wed, Mar 22, 2017 at 08:46:16AM +0100, Ingo Molnar wrote:
> > 
> > * Jiri Slaby <jslaby@suse.cz> wrote:
> > 
> > > On 03/22/2017, 08:25 AM, Ingo Molnar wrote:
> > > > 
> > > > * Pavel Machek <pavel@ucw.cz> wrote:
> > > > 
> > > >> Hi!
> > > >>
> > > >>> -ENTRY(saved_rbp)	.quad	0
> > > >>> -ENTRY(saved_rsi)	.quad	0
> > > >>> -ENTRY(saved_rdi)	.quad	0
> > > >>> -ENTRY(saved_rbx)	.quad	0
> > > >>> +SYM_DATA_START(saved_rbp)		.quad	0
> > > >>> +SYM_DATA_START(saved_rsi)		.quad	0
> > > >>> +SYM_DATA_START(saved_rdi)		.quad	0
> > > >>> +SYM_DATA_START(saved_rbx)		.quad	0
> > > >>
> > > >> Does it make sense to call it SYM_DATA_*START* when there's no
> > > >> corresponding end?
> > > > 
> > > > That looks like a bug - I think we should strive for them to always be in pairs.
> > > > 
> > > > Jiri, Josh, could objtool help here perhaps, to detect 'non-terminated' 
> > > > SYM_*_START() uses? This could be done by emitting debug data into a special 
> > > > section and then analyzing that section for unpaired entries. The section can be 
> > > > discarded in the final link, it won't show up in the kernel image.
> > > 
> > > It should be easier than that. No introduction of other info needed --
> > > every global symbol without a ".type" or ".size" (i.e. SYM_*_END) should
> > > be a bug now.
> > 
> > I'm all for that!
> 
> It would be easy to add this checking to objtool since it already reads
> the symbol table.  The hard part is figuring out the logistics. :-)
> 
> - Should the warnings be on by default?

Yes, if objtool is running. Keep it simple.

> - Part of the "objtool check" command or something else?

Yes - I think it's still within the 'object file check' functionality.

> - Separate config option or just include it with
>   CONFIG_STACK_VALIDATION?

Yeah, but I'd rename CONFIG_STACK_VALIDATION to CONFIG_OBJ_VALIDATION or such. As 
I predicted early on, objtool will go beyond stack checking! ;-)

> - Should all asm files be checked, including those currently skipped by
>   objtool with OBJECT_FILES_NON_STANDARD?

The symbol syntax check should definitely be for all files, yes.

Could we perhaps emit 'non-standard stack frames' information into the .o itself 
(via a flag or a special section?), so that objtool can decide on its own whether 
to complain about any weirdnesses there?

> > Can we detect double ends as well - i.e. do a build check of the full syntax of 
> > these symbol definition primitives?
> 
> Detecting double ends would be a little trickier.  The second SYM_*_END
> supersedes the first, so that information isn't in the ELF symbol table.

Indeed.

> We could use a special section to annotate all the macro uses and have
> objtool do the checking, similar to what you suggested earlier.

That might be useful for other purposes as well - such as the non-standard stack 
frame annotations?

But it's your call really: I'm principally fine with any of the solutions, as long 
as the checking is done.

Thanks,

	Ingo
