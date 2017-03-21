From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH v2 03/10] x86: assembly, use SYM_FUNC_END for functions
Date: Tue, 21 Mar 2017 09:48:41 -0500
Message-ID: <20170321144841.oeaqqarhgzyhehth@treble>
References: <9ea5e137-61f9-dccc-bb9d-ac3ff86e5867@suse.cz>
 <20170320123222.15453-1-jslaby@suse.cz>
 <20170320123222.15453-3-jslaby@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170320123222.15453-3-jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, x86@kernel.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org
List-Id: linux-pm@vger.kernel.org

On Mon, Mar 20, 2017 at 01:32:15PM +0100, Jiri Slaby wrote:
>  ENTRY(ftrace_caller)
>  	/* save_mcount_regs fills in first two parameters */
> @@ -184,11 +184,12 @@ GLOBAL(ftrace_epilogue)
>  GLOBAL(ftrace_graph_call)
>  	jmp ftrace_stub
>  #endif
> +SYM_FUNC_END(ftrace_caller)
>  
>  /* This is weak to keep gas from relaxing the jumps */
>  WEAK(ftrace_stub)
>  	retq
> -END(ftrace_caller)
> +SYM_FUNC_END(ftrace_caller)

This gives ftrace_caller() two ends.

-- 
Josh
