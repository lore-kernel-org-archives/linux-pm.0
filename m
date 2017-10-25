From: Jiri Slaby <jslaby@suse.cz>
Subject: Re: [PATCH v4 01/27] linkage: new macros for assembler symbols
Date: Wed, 25 Oct 2017 16:20:31 +0200
Message-ID: <67a86986-8868-82e5-6e54-cdf03c1e4d2b@suse.cz>
References: <20171002091246.28432-1-jslaby@suse.cz>
 <20171006152355.73fljxsihnejppx4@treble>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:55882 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751732AbdJYOUe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Oct 2017 10:20:34 -0400
In-Reply-To: <20171006152355.73fljxsihnejppx4@treble>
Content-Language: en-GB
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, x86@kernel.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Ingo Molnar <mingo@kernel.org>, Juergen Gross <jgross@suse.com>, Len Brown <len.brown@intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, linux-pm@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Peter Zijlstra <a.p.zijlstra@chello.nl>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, xen-devel@lists.xenproject.org

On 10/06/2017, 05:23 PM, Josh Poimboeuf wrote:
> On Mon, Oct 02, 2017 at 11:12:20AM +0200, Jiri Slaby wrote:
>>    SYM_CODE_INNER_LABEL -- only for labels in the middle of code
>>    SYM_CODE_INNER_LABEL_NOALIGN -- only for labels in the middle of code
> 
> Why are the inner labels aligned by default?  Seems like unaligned would
> be the most common case.

Correct:
$ git grep -w SYM_CODE_INNER_LABEL_NOALIGN arch/|wc -l
20
$ git grep -w SYM_CODE_INNER_LABEL arch/|wc -l
3

Will switch them.

>> d) For data
>>    SYM_DATA_START -- global data symbol
>>    SYM_DATA_END -- the end of the SYM_DATA_START symbol
>>    SYM_DATA_END_LABEL -- the labeled end of SYM_DATA_START symbol
>>    SYM_DATA_SIMPLE -- start+end wrapper around simple global data
>>    SYM_DATA_SIMPLE_LOCAL -- start+end wrapper around simple local data
> 
> "SIMPLE" seems superfluous, how about s/SYM_DATA_SIMPLE/SYM_DATA/ ?

Yup, makes sense, will do.

thanks,
-- 
js
suse labs
