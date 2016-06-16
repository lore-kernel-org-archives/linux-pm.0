From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] intel_idle: correct/improve BXT support
Date: Thu, 16 Jun 2016 00:46:20 -0400
Message-ID: <CAJvTdK=wLx0Te2fPG_hVPDDDKuhmamsZqjo-zinnzQbxgXBpfQ@mail.gmail.com>
References: <574C4D9002000078000EFAAC@prv-mh.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f170.google.com ([209.85.220.170]:33670 "EHLO
	mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750902AbcFPEqW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 16 Jun 2016 00:46:22 -0400
Received: by mail-qk0-f170.google.com with SMTP id a186so42490629qkf.0
        for <linux-pm@vger.kernel.org>; Wed, 15 Jun 2016 21:46:22 -0700 (PDT)
In-Reply-To: <574C4D9002000078000EFAAC@prv-mh.provo.novell.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jan Beulich <JBeulich@suse.com>
Cc: Linux PM list <linux-pm@vger.kernel.org>

On Mon, May 30, 2016 at 8:26 AM, Jan Beulich <JBeulich@suse.com> wrote:
> Commit 5dcef69486 ("intel_idle: add BXT support") added an 8-element
> lookup array with just a 2-bit value used for lookups. As per the SDM
> that bit field is really 3 bits wide. Since the top two array entries
> are zero, deal with the resulting invalid (zero) values by moving the
> zero-MSR-value check into irtl_2_usec() and having that function's
> caller check the function result instead.

Thanks, Jan, for reviewing this code!

There are 3 logical changes here,
which should be 3 different patches.

#1:

> -       ns = irtl_ns_units[(irtl >> 10) & 0x3];
> +       ns = irtl_ns_units[(irtl >> 10) & 0x7];

This is a latent bug.  It is latent because this code is currently used
only on BXT, and BXT doesn't use high index.  However, this could be
a functional bug if this code is re-used elsewhere, so we should fix it.

#2

> +       unsigned int usec;

> -               unsigned int usec = irtl_2_usec(msr);
> +       usec = irtl_2_usec(msr);

> -               unsigned int usec = irtl_2_usec(msr);
> +       usec = irtl_2_usec(msr);

> -               unsigned int usec = irtl_2_usec(msr);
> +       usec = irtl_2_usec(msr);

> -               unsigned int usec = irtl_2_usec(msr);
> +       usec = irtl_2_usec(msr);

> -               unsigned int usec = irtl_2_usec(msr);
> +       usec = irtl_2_usec(msr);

I'm okay with this cleanup, if you want to send as a 2nd patch.

(I'm also okay leaving it how it is, since the value of of usec
 has no meaning across these blocks, and so a local is actually
 more logical, at least to me.)

#3

Checking for 0

There are two cases:
1. MSR returns 0
This actually happens, when a state is not supported.
Though when a state is not supported, this is actually
dead code, as the value we calculate will not be used.
So technically we don't really need to check
and could, indeed, keep it simple and write 0.

This code was written when the ucode was in flux,
so it is already more paranoid than it has to be....

2. MSR returns index 0 - 5.
It will never return 6 or 7 -- the 0 padding on the array
is just my own coding style.  Could just as well specify
the size of the array as 8, or truncate it to 6 and check the
max index.  But all of this is just paranoia, because
the index will never be above 5.  This value is written
by ucode, not by the BIOS -- think of it has hardware.

So I'm neutral on this change, but if you like how it reads
enough to send me a patch #3, I'll apply it.

thanks,
Len Brown, Intel Open Source Technology Center
