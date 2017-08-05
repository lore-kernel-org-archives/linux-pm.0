From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 0/7 RESEND] turbostat: Fix AMD output by making turbostat
 aware of nodes
Date: Sat, 5 Aug 2017 03:06:55 -0400
Message-ID: <CAJvTdKm3oMEX7uyRJy3G5BR91SmjJKmj1oZAB9xcpBwC2BdYAA@mail.gmail.com>
References: <1501243581-31491-1-git-send-email-prarit@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qt0-f176.google.com ([209.85.216.176]:36862 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751140AbdHEHG4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 5 Aug 2017 03:06:56 -0400
Received: by mail-qt0-f176.google.com with SMTP id v29so19618752qtv.3
        for <linux-pm@vger.kernel.org>; Sat, 05 Aug 2017 00:06:56 -0700 (PDT)
In-Reply-To: <1501243581-31491-1-git-send-email-prarit@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Prarit Bhargava <prarit@redhat.com>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Len Brown <len.brown@intel.com>

Hi Prarit,
Thanks for re-sending to linux-pm -- much easier to track patches there:-)

three suggestions.

the package,core,cpu columns in turbostat are helpful for
understanding topology.
Now that you've taught turbostat about nodes, I think it would make sense
to expose that knowledge in an additional "Node" column.

In testing this patch series, I found that it now visits HT siblings
in reverse order.
I would prefer if the patch series did not change the displayed CPU
order on existing systems,
since there are existing data-sets and it would be good to be able to
still be able to compare them...
(also, I think it reads better to continue visit the lower numbered HT
sibling before the higher numbered, rather than the reverse)

please re-send after the patch series is checkpatch.pl clean

thanks,
Len Brown, Intel Open Source Technology Center
