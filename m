From: Prarit Bhargava <prarit@redhat.com>
Subject: Re: [PATCH 0/7 RESEND] turbostat: Fix AMD output by making turbostat
 aware of nodes
Date: Thu, 17 Aug 2017 09:29:31 -0400
Message-ID: <c3434ee6-bd0b-1860-6293-2061fe238b91@redhat.com>
References: <1501243581-31491-1-git-send-email-prarit@redhat.com>
 <CAJvTdKm3oMEX7uyRJy3G5BR91SmjJKmj1oZAB9xcpBwC2BdYAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55176 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752609AbdHQN3c (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 17 Aug 2017 09:29:32 -0400
In-Reply-To: <CAJvTdKm3oMEX7uyRJy3G5BR91SmjJKmj1oZAB9xcpBwC2BdYAA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Len Brown <len.brown@intel.com>



On 08/05/2017 03:06 AM, Len Brown wrote:
> Hi Prarit,
> Thanks for re-sending to linux-pm -- much easier to track patches there:-)
> 
> three suggestions.
> 
> the package,core,cpu columns in turbostat are helpful for
> understanding topology.
> Now that you've taught turbostat about nodes, I think it would make sense
> to expose that knowledge in an additional "Node" column.

Will do.

> 
> In testing this patch series, I found that it now visits HT siblings
> in reverse order.

Interesting, I had not noticed that.  I'll fix that.

P.
