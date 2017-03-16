From: Jiri Slaby <jslaby@suse.cz>
Subject: Re: [RFC] linkage: new macros for functions and data
Date: Thu, 16 Mar 2017 09:13:18 +0100
Message-ID: <9ea5e137-61f9-dccc-bb9d-ac3ff86e5867@suse.cz>
References: <20170307082750.GA1695@gmail.com>
 <20170307172404.27374-1-jslaby@suse.cz> <20170316080257.GA7815@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34717 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751182AbdCPINW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Mar 2017 04:13:22 -0400
In-Reply-To: <20170316080257.GA7815@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, hpa@zytor.com, jpoimboe@redhat.com, Juergen Gross <jgross@suse.com>, Len Brown <len.brown@intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, linux-pm@vger.kernel.org, mingo@redhat.com, Pavel Machek <pavel@ucw.cz>, Peter Zijlstra <a.p.zijlstra@chello.nl>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Thomas Gleixner <tglx@linutronix.de>, xen-devel@lists.xenproject.org, x86@kernel.org

On 03/16/2017, 09:02 AM, Ingo Molnar wrote:
> 
> * Jiri Slaby <jslaby@suse.cz> wrote:
> 
>> SYM_LOCAL_ALIAS_START -- use where there are two local names for one code
>> SYM_ALIAS_START -- use where there are two global names for one code
>> SYM_LOCAL_FUNC_START -- use for local functions
>> SYM_FUNCTION_START -- use for global functions
>> SYM_WEAK_FUNC_START -- use for weak functions
>> SYM_ALIAS_END -- the end of LOCALALIASed or ALIASed code
>> SYM_FUNCTION_END -- the end of SYM_LOCAL_FUNC_START, SYM_FUNCTION_START, SYM_WEAK_FUNC_START, ...
>> SYM_DATA_START -- global data symbol
>> SYM_DATA_END -- the end of SYM_DATA_START symbol
> 
> This looks mostly good to me, with minor details:
> 
> - The mixed 'FUNC' and 'FUNCTION' naming looks a bit confusing - I'd pick one and
>   use that consistently.

Of course, I did it later after sending the RFC. I stuck to FUNC.

...
> Does this look good to everyone?

Fine by me. I will send patches for that, so that you can comment on
that on real uses.

thanks,
-- 
js
suse labs
