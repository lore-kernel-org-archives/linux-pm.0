From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm/khugepaged: Allow to interrupt allocation sleep
 again
Date: Mon, 24 Aug 2015 13:30:43 -0700
Message-ID: <20150824133043.23b66633b5c9c91bd6aae190@linux-foundation.org>
References: <1440429203-4039-1-git-send-email-pmladek@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:37696 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751235AbbHXUao (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 24 Aug 2015 16:30:44 -0400
In-Reply-To: <1440429203-4039-1-git-send-email-pmladek@suse.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Petr Mladek <pmladek@suse.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>, Vlastimil Babka <vbabka@suse.cz>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, David Rientjes <rientjes@google.com>, Ebru Akagunduz <ebru.akagunduz@gmail.com>, Mel Gorman <mgorman@suse.de>, linux-mm@kvack.org, linux-pm@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>

On Mon, 24 Aug 2015 17:13:23 +0200 Petr Mladek <pmladek@suse.com> wrote:

> The commit 1dfb059b9438633b0546 ("thp: reduce khugepaged freezing
> latency") fixed khugepaged to do not block a system suspend. But
> the result is that it could not get interrupted before the given
> timeout because the condition for the wait event is "false".

What are the userspace-visible effects of this bug?

> This patch puts back the original approach but it uses
> freezable_schedule_timeout_interruptible() instead of
> schedule_timeout_interruptible(). It does the right thing.
> I am pretty sure that the freezable variant was not used in
> the original fix only because it was not available at that time.
> 
> The regression has been there for ages. It was not critical. It just
> did the allocation throttling a little bit more aggressively.
> 
> I found this problem when converting the kthread to kthread worker API
> and trying to understand the code.
> 
> ...
