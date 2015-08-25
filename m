From: Len Brown <lenb@kernel.org>
Subject: Re: turbostat: change to default output
Date: Tue, 25 Aug 2015 18:32:34 -0400
Message-ID: <CAJvTdK=g55Tp7tvG8oyzguYjjq5Q+0jiZvEtux=2WBRUVLYpDg@mail.gmail.com>
References: <CABxNGQaAA_sbqp_DfbjFxMFUDwnRVPXqKFOUcxUa18bGSpuicQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-la0-f44.google.com ([209.85.215.44]:33886 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751865AbbHYWcg (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 25 Aug 2015 18:32:36 -0400
Received: by laba3 with SMTP id a3so108190306lab.1
        for <linux-pm@vger.kernel.org>; Tue, 25 Aug 2015 15:32:34 -0700 (PDT)
In-Reply-To: <CABxNGQaAA_sbqp_DfbjFxMFUDwnRVPXqKFOUcxUa18bGSpuicQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jeremy Eder <jeder@redhat.com>
Cc: Linux PM list <linux-pm@vger.kernel.org>, lenb@intel.com

Hello Jeremy,
I prefer your suggestion over the current default.
I always want everything.

The problem is that the 'everything' option will not come even close
to fitting within the columns available on most screens.


On Thu, Jul 30, 2015 at 2:04 PM, Jeremy Eder <jeder@redhat.com> wrote:
> Len, commit 1cc21f7b6b747220c29b42cfd1c84b5648d12407
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/tools/power/x86/turbostat/turbostat.c?id=1cc21f7b6b747220c29b42cfd1c84b5648d12407
>
> The commit message mentions "Casual turbostat users generally just
> want to know MHz."
>
> Disagree; we don't think there are any casual users of turbostat that
> _don't_ care about c-states.
>
> Any chance you can revert this ?  If someone needs a more concise
> output, you might offer a --compact flag or so.
>
> Thoughts ?
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Len Brown, Intel Open Source Technology Center
