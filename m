From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: Re: [PATCH v4 1/2] Mailbox: Restructure and simplify PCC mailbox code
Date: Fri, 13 Feb 2015 18:31:51 -0500
Message-ID: <CAJ5Y-eYVdTiHAh4QsMo-O12VnumuVGP2hgMaMOKObJEMHEv1fQ@mail.gmail.com>
References: <1422392638-31334-1-git-send-email-ashwin.chaugule@linaro.org>
	<1422392638-31334-2-git-send-email-ashwin.chaugule@linaro.org>
	<CAJ5Y-eYZ1TuX8wvJOH9Os7qQGXnefxeCTqG65QA__0aornNo2w@mail.gmail.com>
	<5721986.NjN2XryXtL@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f48.google.com ([74.125.82.48]:51152 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752758AbbBMXbx (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 13 Feb 2015 18:31:53 -0500
Received: by mail-wg0-f48.google.com with SMTP id l18so16473463wgh.7
        for <linux-pm@vger.kernel.org>; Fri, 13 Feb 2015 15:31:52 -0800 (PST)
In-Reply-To: <5721986.NjN2XryXtL@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "rwells@codeaurora.org" <rwells@codeaurora.org>, Linda Knippers <linda.knippers@hp.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Patch Tracking <patches@linaro.org>, Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Jaswinder Singh <jaswinder.singh@linaro.org>, Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd.bergmann@linaro.org>

Hi Rafael,

On 13 February 2015 at 09:38, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Friday, February 13, 2015 08:07:44 AM Ashwin Chaugule wrote:
>> Hello,
>>
>> On 27 January 2015 at 16:03, Ashwin Chaugule <ashwin.chaugule@linaro.org> wrote:
>> > Previously the PCC driver depended on the client
>> > side to map the communication space base address. This region
>> > was was then used in the PCC driver and the client side.
>> > The client side used this region to read and write its data
>> > and the PCC driver used it to only write the PCC command.
>> > Removing this split simplifies the PCC driver a lot. This patch
>> > moves all communication region read/writes to the client side.
>> > The PCC clients can now drive the PCC mailbox controller via the
>> > mbox_client_txdone() method.
>> >
>> > Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
>> > ---
>> >  drivers/mailbox/pcc.c | 122 +++++++++++++++-----------------------------------
>> >  1 file changed, 37 insertions(+), 85 deletions(-)
>>
>> Gentle reminder for this patch specifically. It can be pulled in by
>> itself separately from the CPPC patch[2/2], which understandably may
>> need more time for review. Apart from the simplification done here,
>> there is one more change based on a comment I got from Rafael tow
>> convert a pr_err() in the init function to pr_debug(). The "PCC Probe
>> failed" message seems to be raising false positives on X86 test
>> reports. Please let me know if there are any other suggestions, before
>> I respin another version for this.
>
> The patch changing the pr_err() to pr_debug() is in the Linus' tree already
> as far as I can say.

Thanks for that.

>
> Besides, this should be To: the maintainer of the mailbox susbsystem (not
> me) or if you want me to pick it up, I need and ACK from that maintainer
> anyway.

Is there a way to do that separately for each patch in a patchset?
Anyway, I'll rebase this patch to tip and send it separately To:
Jassi.

Thanks,
Ashwin.
