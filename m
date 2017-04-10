From: Jiri Slaby <jslaby@suse.cz>
Subject: Re: [PATCH v2 03/10] x86: assembly, use SYM_FUNC_END for functions
Date: Mon, 10 Apr 2017 13:23:46 +0200
Message-ID: <b7800998-2a60-b967-10fc-482ebd6fadf0@suse.cz>
References: <9ea5e137-61f9-dccc-bb9d-ac3ff86e5867@suse.cz>
 <20170320123222.15453-1-jslaby@suse.cz>
 <20170320123222.15453-3-jslaby@suse.cz>
 <20170322142610.bo5c6wzlbqnxrgt3@treble>
 <e4f7197c-559e-0dc2-c4e4-e369bf503cbb@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <e4f7197c-559e-0dc2-c4e4-e369bf503cbb@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, x86@kernel.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org
List-Id: linux-pm@vger.kernel.org

On 03/22/2017, 04:44 PM, Jiri Slaby wrote:
> On 03/22/2017, 03:26 PM, Josh Poimboeuf wrote:
>> On Mon, Mar 20, 2017 at 01:32:15PM +0100, Jiri Slaby wrote:
>>> Somewhere END was used to end a function, elsewhere, nothing was used.
>>> So unify it and mark them all by SYM_FUNC_END.
>>>
>>> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
>>
>> For me these patches would be easier to review if the SYM_FUNC_START and
>> SYM_FUNC_END pairs for a given function are done in the same patch.
> 
> This patchset was intended to make everything paired with minimum
> changes. I certainly can change also counter-elements of each
> added/changed one if you prefer.

So do really you want me to use the new macros while I am
adding/changing the counter-macro? Is there anything else blocking the
merge of the patches?

>> Also I noticed several cases in entry_64.S where the old ENTRY macro is
>> still used, and paired with SYM_FUNC_END.
>>
>> Maybe there should be an x86 version of the deprecated ENTRY/ENDPROC/etc
>> macros which throw a warning or an error?
> 
> Yes, my plan is to throw ENTRY/ENDPROC on the floor from x86 completely.
> And I will do it after this patchset settles down by sed or something in
> one shot (per directory or something).
> 
> thanks,
-- 
js
suse labs
