From: Len Brown <lenb@kernel.org>
Subject: Re: [RESEND PATCH 2/8] turbostat: Fix node and siblings lookup data
Date: Fri, 8 Dec 2017 17:47:39 -0500
Message-ID: <CAJvTdK=-pH_XTS5dNsgz+MEhqN-mYOwQaHOs_Qc+58+KpEp4Zw@mail.gmail.com>
References: <20171103122550.13341-1-prarit@redhat.com> <20171103122550.13341-3-prarit@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f176.google.com ([209.85.220.176]:36547 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752730AbdLHWrk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 8 Dec 2017 17:47:40 -0500
Received: by mail-qk0-f176.google.com with SMTP id t187so751196qkh.3
        for <linux-pm@vger.kernel.org>; Fri, 08 Dec 2017 14:47:40 -0800 (PST)
In-Reply-To: <20171103122550.13341-3-prarit@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Prarit Bhargava <prarit@redhat.com>
Cc: Linux PM list <linux-pm@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>, charles.rose@dell.com, "Rafael J. Wysocki" <rafael@kernel.org>, suravee.suthikulpanit@amd.com

This patch causes a core dump:

turbostat: malloc.c:2394: sysmalloc: Assertion `(old_top ==
initial_top (av) && old_size == 0) || ((unsigned long) (old_size) >=
MINSIZE && prev_inuse (old_top) && ((unsigned long) old_end &
(pagesize - 1)) == 0)' failed.

Aborted (core dumped)
