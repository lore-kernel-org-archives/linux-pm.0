From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: i686 suspend broken in 4.15.2
Date: Mon, 12 Feb 2018 13:58:04 +0100
Message-ID: <22af3344-99c2-56a2-1465-638d5a07ae35@intel.com>
References: <cd7033eb-1272-f8bc-f13f-afe09fd4864e@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga18.intel.com ([134.134.136.126]:39533 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935054AbeBLM6I (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 12 Feb 2018 07:58:08 -0500
In-Reply-To: <cd7033eb-1272-f8bc-f13f-afe09fd4864e@gmail.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Woody Suwalski <terraluna977@gmail.com>
Cc: william.grant@canonical.com, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, x86@kernel.org

On 2/12/2018 2:52 AM, Woody Suwalski wrote:
> Howdy,
> I have just tested 4.15.2 kernel on a 32-bit Thinkpad x60.
> While hibernation works OK, suspend2ram fails on wakeup - system goes 
> to sleep OK, however upon wake it simply reboots.
>
> I have bisected the problem to:
>
> commit 62c00e6122a6b5aa7b1350023967a2d7a12b54c9
> Author: William Grant <william.grant@canonical.com>
> Date:   Tue Jan 30 22:22:55 2018 +1100
>
>     x86/mm: Fix overlap of i386 CPU_ENTRY_AREA with FIX_BTMAP
>

That would be commit 55f49fcb879fbeeb in the mainline.

> Removing that patch makes the suspend work again (testing is painful 
> because this small patch triggers rebuild of virtually all kernel 
> files :-( )
>
> Could there be something triggering it in my config file?
>

Yes, in theory.

Thanks,
Rafael
