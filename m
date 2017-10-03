From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] cpuidle: fix broadcast control when broadcast can not be entered
Date: Tue, 3 Oct 2017 02:31:40 +0200
Message-ID: <CAJZ5v0hE-H_RfJcb=AWyitQOzkRxf=XXC_+q1+k0b35CZFceyg@mail.gmail.com>
References: <20170901042956.29594-1-npiggin@gmail.com> <alpine.DEB.2.20.1709010944490.1857@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:56974 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750869AbdJCAbl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 2 Oct 2017 20:31:41 -0400
In-Reply-To: <alpine.DEB.2.20.1709010944490.1857@nanos>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, Nicholas Piggin <npiggin@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Daniel Lezcano <daniel.lezcano@linaro.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Fri, Sep 1, 2017 at 9:44 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Fri, 1 Sep 2017, Nicholas Piggin wrote:
>
>> When failing to enter broadcast timer mode for an idle state that
>> requires it, a new state is selected that does not require broadcast,
>> but the broadcast variable remains set. This causes
>> tick_broadcast_exit to be called despite not having entered broadcast
>> mode.
>>
>> This causes the WARN_ON_ONCE(!irqs_disabled()) to trigger in some
>> cases. It does not appear to cause problems for code today, but seems
>> to violate the interface so should be fixed.
>>
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>
> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

Applied, thanks!
