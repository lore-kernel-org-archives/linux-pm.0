From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 1/1] x86: replace cpu_up hard-coded mdelay with variable
Date: Fri, 1 May 2015 14:02:41 -0700
Message-ID: <CAJvTdKnv8ibbu3NyQ4j62HbR7Sc92xF-DUQfsMuxGFf3-4Geiw@mail.gmail.com>
References: <1429404795-23260-1-git-send-email-lenb@kernel.org>
	<87d69aab88c14d65ae1e7be55050d1b689b59b4b.1429402494.git.len.brown@intel.com>
	<CAP=VYLqofSyGmApHWF4wvidAZ+C0GCV7ScCYnSU2REaCPGywkg@mail.gmail.com>
	<20150422060734.GA25230@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f171.google.com ([209.85.217.171]:33419 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750763AbbEAVCn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 1 May 2015 17:02:43 -0400
In-Reply-To: <20150422060734.GA25230@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, X86 ML <x86@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>

On Tue, Apr 21, 2015 at 11:07 PM, Ingo Molnar <mingo@kernel.org> wrote:
>
> * Paul Gortmaker <paul.gortmaker@windriver.com> wrote:

>> Happened to notice a 2x "The the..." when I came across this in
>> linux-next today and was reading the help out of curiousity...
>
> Len, this commit isn't in a permanent Git tree yet, right? We want to
> do this through the x86 tree, and along the suggestions I made.

It was in my -next tree -- no not permanent, yes, since removed (today).
Yes, I plan to send you a v2 and TIP is the right place for it to live.

Paul, thanks for noticing the typo.

Len Brown, Intel Open Source Technology Center
