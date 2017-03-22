From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH v2 02/10] x86: assembly, FUNC_START for fn, DATA_START
 for data
Date: Wed, 22 Mar 2017 10:33:36 -0500
Message-ID: <20170322153336.srnce5vwq2727vuy@treble>
References: <9ea5e137-61f9-dccc-bb9d-ac3ff86e5867@suse.cz>
 <20170320123222.15453-1-jslaby@suse.cz>
 <20170320123222.15453-2-jslaby@suse.cz>
 <20170321140840.GA23311@amd>
 <20170322072557.GA13904@gmail.com>
 <ee3242f9-1fab-f3a8-947d-85fc1a660a49@suse.cz>
 <20170322074616.GA10809@gmail.com>
 <20170322141123.opss3u4gpupqgl2q@treble>
 <049e6c03-8d7d-e869-96bd-0a98e6471227@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54548 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751321AbdCVPdn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 22 Mar 2017 11:33:43 -0400
Content-Disposition: inline
In-Reply-To: <049e6c03-8d7d-e869-96bd-0a98e6471227@suse.cz>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: Ingo Molnar <mingo@kernel.org>, Pavel Machek <pavel@ucw.cz>, mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, x86@kernel.org, linux-kernel@vger.kernel.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org

On Wed, Mar 22, 2017 at 04:01:08PM +0100, Jiri Slaby wrote:
> On 03/22/2017, 03:11 PM, Josh Poimboeuf wrote:
> > Or, here's a much easier way to do it, without involving objtool:
> > 
> > --- a/include/linux/linkage.h
> > +++ b/include/linux/linkage.h
> > @@ -138,9 +138,17 @@
> >  	name:
> >  #endif
> >  
> > +#ifndef CHECK_DUP_SYM_END
> > +#define CHECK_DUP_SYM_END(name)				\
> > +	.pushsection .discard.sym_func_end ASM_NL	\
> > +	SYM_END_##name: .byte 0 ASM_NL			\
> > +	.popsection
> > +#endif
> > +
> >  /* SYM_END -- use only if you have to */
> >  #ifndef SYM_END
> >  #define SYM_END(name, sym_type)				\
> > +	CHECK_DUP_SYM_END(name) ASM_NL			\
> >  	.type name sym_type ASM_NL			\
> >  	.size name, .-name
> >  #endif
> 
> I tried this approach and it didn't work for me inside .macros. Oh,
> well, the name cannot be first, so now, we can have a check for both
> correct pairing _and_ duplicate ends in one:
> 
> #define SYM_CHECK_START(name)                           \
>         .pushsection .rodata.bubak ASM_NL               \
>         .long has_no_SYM_END_##name - . ASM_NL          \
>         .popsection
> 
> #define SYM_CHECK_END(name)                             \
>         has_no_SYM_END_##name:
> 
> /* SYM_START -- use only if you have to */
> #ifndef SYM_START
> #define SYM_START(name, align, visibility, entry)       \
>         SYM_CHECK_START(name) ASM_NL                    \
>         visibility(name) ASM_NL                         \
>         align ASM_NL                                    \
>         name: ASM_NL                                    \
>         entry
> #endif
> 
> /* SYM_END -- use only if you have to */
> #ifndef SYM_END
> #define SYM_END(name, sym_type, exit)                   \
>         exit ASM_NL                                     \
>         SYM_CHECK_END(name) ASM_NL                      \
>         .type name sym_type ASM_NL                      \
>         .size name, .-name
> #endif
> 
> 
> So for the ftrace mistake I did:
> 
>   AS      arch/x86/kernel/mcount_64.o
> /home/latest/linux/arch/x86/kernel/mcount_64.S: Assembler messages:
> /home/latest/linux/arch/x86/kernel/mcount_64.S:192: Error: symbol
> `has_no_SYM_END_ftrace_caller' is already defined
> 
> 
> or if I remove SYM_END_FUNC completely:
>   LD      vmlinux.o
>   MODPOST vmlinux.o
> arch/x86/built-in.o:(.rodata.bubak+0x130): undefined reference to
> `has_no_SYM_END_ftrace_stub'
> 
> 
> Sad is that this occurs only during linking, so I cannot put it in the
> .discard section -- ideas?

Ah, interesting idea but I can't think of a way to do the missing end
check before link time.

But it would be easy for objtool to check for a missing end because the
symbol would have a zero size.

-- 
Josh
