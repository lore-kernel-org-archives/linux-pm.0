From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] turbostat: Running on virtual machine is not supported
Date: Sat, 5 Aug 2017 02:50:12 -0400
Message-ID: <CAJvTdKm-ypQxfoagy46A5uobt+QJAvcimg8hsfBxJs+3dN1bGA@mail.gmail.com>
References: <1500987324-507-1-git-send-email-prarit@redhat.com>
 <20170725155911.ihtjkz5cuwdpwoxp@khazad-dum.debian.net> <CAJvTdKmZqPkvUrgEJitYrBv7EJzpemLjN-nfYUnT3b127LNSQA@mail.gmail.com>
 <8aa1f7ec-1d21-f027-f4c4-7c3d8e88b8d2@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qt0-f176.google.com ([209.85.216.176]:35825 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751140AbdHEGuN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 5 Aug 2017 02:50:13 -0400
Received: by mail-qt0-f176.google.com with SMTP id p3so19631854qtg.2
        for <linux-pm@vger.kernel.org>; Fri, 04 Aug 2017 23:50:13 -0700 (PDT)
In-Reply-To: <8aa1f7ec-1d21-f027-f4c4-7c3d8e88b8d2@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Prarit Bhargava <prarit@redhat.com>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <len.brown@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

>  perf does work (mostly) under virt.

Let's hold off on this patch for a bit till the port to perf is ready,
since this logic is going to change slightly.

I think something like this:

1. make the debug info (the stuff hidden with --quiet) optional
    don't bail out if it fails.  (but continue to bail out of anything
    that is needed to provide a column fails)

2. attempt the faster of /dev/msr or perf first, and try the 2nd
    only when the 1st doesn't work.

   (currently /dev/msr is faster, but I'm not done w/ the perf work)

3. When neither /dev/msr or perf work, then check for virt
    to see if it may be the cause.

   Print the error message about permissions for perf and /dev/msr and
virt, as appropriate.

thanks,
Len Brown, Intel Open Source Technology Center
