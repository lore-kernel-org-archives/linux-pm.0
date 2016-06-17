From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] intel_idle: correct/improve BXT support
Date: Thu, 16 Jun 2016 22:50:43 -0400
Message-ID: <CAJvTdKmcCMY9XAjGz2EpsrDQ+ZKGAb+QiM6guiLH7KR0PLiVRg@mail.gmail.com>
References: <574C4D9002000078000EFAAC@prv-mh.provo.novell.com>
 <CAJvTdK=wLx0Te2fPG_hVPDDDKuhmamsZqjo-zinnzQbxgXBpfQ@mail.gmail.com> <5762789902000078000F58EF@prv-mh.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f179.google.com ([209.85.220.179]:34535 "EHLO
	mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754466AbcFQCuo (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 16 Jun 2016 22:50:44 -0400
Received: by mail-qk0-f179.google.com with SMTP id s186so73062916qkc.1
        for <linux-pm@vger.kernel.org>; Thu, 16 Jun 2016 19:50:44 -0700 (PDT)
In-Reply-To: <5762789902000078000F58EF@prv-mh.provo.novell.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jan Beulich <JBeulich@suse.com>
Cc: Linux PM list <linux-pm@vger.kernel.org>

Jan,
I'm fine with consolidated clean-up, as long as clean-up is not mixed
with bug-fix or functional changes.

Also, it is ideal for bug fixes and functional changes to precede
clean-ups in a series, since clean-ups tend to more frequently suffer
merge conflicts, create false dependencies,  and sometimes get delayed
or dropped.


thanks!
Len Brown, Intel Open Source Technology Center
