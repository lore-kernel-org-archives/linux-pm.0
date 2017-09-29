From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH RFC hack dont apply] intel_idle: support running within a VM
Date: Sat, 30 Sep 2017 01:21:43 +0200
Message-ID: <CAJZ5v0hz+KDGVdz+X=98p51fOpk6AAa3CmL-asWw3uZg12X-Lw@mail.gmail.com>
References: <20170930005046-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:37418 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752543AbdI2XVo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 29 Sep 2017 19:21:44 -0400
In-Reply-To: <20170930005046-mutt-send-email-mst@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Yang Zhang <yang.zhang.wz@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, kvm@vger.kernel.org, Wanpeng Li <wanpeng.li@hotmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, rkrcmar@redhat.com, dmatlack@google.com, agraf@suse.de, Peter Zijlstra <peterz@infradead.org>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Len Brown <lenb@kernel.org>, Linux PM <linux-pm@vger.kernel.org>

On Sat, Sep 30, 2017 at 12:01 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
> intel idle driver does not DTRT when running within a VM:
> when going into a deep power state, the right thing to
> do is to exit to hypervisor rather than to keep polling
> within guest using mwait.
>
> Currently the solution is just to exit to hypervisor each time we go
> idle - this is why kvm does not expose the mwait leaf to guests even
> when it allows guests to do mwait.
>
> But that's not ideal - it seems better to use the idle driver to guess
> when will the next interrupt arrive.

The idle driver alone is not sufficient for that, though.

Thanks,
Rafael
