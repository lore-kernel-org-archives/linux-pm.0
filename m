From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] drivers: base: power: Fix GFP_KERNEL in spinlock context
Date: Tue, 12 Dec 2017 17:55:00 +0100
Message-ID: <CAJZ5v0jH-hqMGLckGkqOycVML-HTLmXxDLjw0D4qbC1fET2Q_g@mail.gmail.com>
References: <1513086342-3581-1-git-send-email-shrikant.maurya@techveda.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1513086342-3581-1-git-send-email-shrikant.maurya@techveda.org>
Sender: linux-kernel-owner@vger.kernel.org
To: shrikant.maurya@techveda.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, sunil.m@techveda.org, karthik@techveda.org, raghu@techveda.org
List-Id: linux-pm@vger.kernel.org

On Tue, Dec 12, 2017 at 2:45 PM,  <shrikant.maurya@techveda.org> wrote:
> From: Shrikant Maurya <shrikant.maurya@techveda.org>
>
> As reported by Jia-Ju Bai (https://lkml.org/lkml/2017/12/11/872):
> API's are using GFP_KERNEL to allocate memory which may sleep.
>
> To ensure atomicity such allocations must be avoided in critical
> sections under spinlock.

That's right.

Which is why wakeup_source_create() should never be called under a spinlock.

Are you aware of any place that happens in the mainline kernel?

Thanks,
Rafael
