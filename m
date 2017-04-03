From: Liam Breck <liam@networkimprov.net>
Subject: Re: [PATCH v3 2/4] power: bq24190_charger: Clean up extcon code
Date: Mon, 3 Apr 2017 14:40:02 -0700
Message-ID: <CAKvHMgRPYiBTwM_RsDSYGr0RoAKuKv-hs0ArkDMVAhP_fMUfjA@mail.gmail.com>
References: <20170401202519.16280-1-liam@networkimprov.net>
 <20170401202519.16280-3-liam@networkimprov.net> <6dbb405d-a840-7216-395f-7e4fa327cd70@redhat.com>
 <CAKvHMgQ6gJ822W_hXO8jGAq_vr4L8NaFJpNHA5sKYJ+kTRtQgg@mail.gmail.com> <857a9dd7-8ed3-0afe-d1e2-2420928263aa@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:36530 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751441AbdDCVkE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 3 Apr 2017 17:40:04 -0400
Received: by mail-it0-f68.google.com with SMTP id a140so3339711ita.3
        for <linux-pm@vger.kernel.org>; Mon, 03 Apr 2017 14:40:04 -0700 (PDT)
In-Reply-To: <857a9dd7-8ed3-0afe-d1e2-2420928263aa@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Liam Breck <kernel@networkimprov.net>

G'day Hans,

On Sun, Apr 2, 2017 at 11:53 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> Hi,
>
> On 03-04-17 00:03, Liam Breck wrote:
>
> <snip>
>
>> Could you adjust your tone to be more collaborative and less cutting?
>
>
> I'm sorry if I sounded a bit cutting.
>
> I've tried nothing but to be collaborative and work with you
> until now, but this patch introduces several changes I already
> mentioned were not a good idea in your review of my original
> patch and IMHO do nothing to improve the code.
>
>> You only have this code for the Atom device because I designed and
>> built hardware with this part and hired Mark to write the driver from
>> scratch. I'd like a little goodwill in exchange!
>
>
> And here we get to the root of the problem, that you keep claiming
> ownership of the driver because you paid Mark to write it,
> this is not how the Linux kernel works. Yes you paid Mark to write
> a driver and in return you get an entire kernel. You no less own
> the bq24190_charger driver then other people own other parts of
> the kernel.

The root of the problem is that I sent far too much critique on v1 of
your patchset, and too quickly. That was misconstrued as a wish to
fence off the codebase. My intent was really to help you produce a
better patchset asap. For myself, I prefer a lot of feedback up front,
as I know what it's like to get squirts of feedback over weeks. I wish
you had not read malevolence into my response!

I clarified my intent in a msg on March 19:
"I realize you put a ton of work into this patchset. Pls know that I
want you to end up with a solution that both works for you, and makes
the charger driver more generally useful. All of my critique is
offered in good faith, and not meant as rejection. I genuinely regret
it if you feel otherwise."

To which you responded with an attack that was startling. I hate
drama, so I let that go.

In the threads I pointed to re Tony's patches, I asked for numerous
technical and stylistic changes, which resulted in some 10 revisions.
He pushed back once, when what I suggested was technically unsound. A
series I've submitted to another driver has reached 17 revisions, and
virtually all of the feedback has been stylistic, vs technical. I have
debated some of these changes, but successfully refuted only a couple.
It's not the way I would style the code, but it's not my precinct. I
don't know why you would expect a different experience than these
examples.

I asked for changes to the extcon patch; you declined to provide any,
telling me to fix some of them. It's not my job to fix your code, but
I did. I then reversed 2 changes which you complained about, and
justified 4 others. Two of those bother you stylistically, but you
suggested no alternatives. Two stylistic differences is barely cause
for complaint, much less a fight.


> Your remarks against Sebastian that he MUST wait for your ack
> before merging anything are quite frankly completely out of line
> and I have been on the verge of saying something about this
> several times already but I decided to stay quiet (until now).

This statement is incorrect. Since I was forced to fix your code in
two cases, I asked that he wait for my ack in future. And I didn't see
the logic of committing your patches on the same day you posted them.
Everyone will be more productive if you solicit my comments, and work
to accommodate them.

> So yes I apologize for my tone getting a bit cutting as I never
> want that, but TBH I've found the way you're claiming to be
> THE authority on the bq24190_charger driver and have been behaving
> if everyone needs to do exactly as you say when it comes to that
> driver quite off-putting / abrasive.

This statement is also incorrect. I called myself the "de facto
maintainer" because Mark is no longer involved, Tony is busy as OMAP
maintainer, and I have spent a lot of time with the code as our
hardware relies on it, so I care about it. (Said hardware will become
commercially available.)

For your v1 and v2 series, I filed several legitimate technical
issues. Of those, only register_reset remains a matter of debate.

> As for me "only having this code for the Atom devices", it would
> have likely taken me way less time to knock out a new driver
> (like I've done for the fuel-gauge) then all the coordination with
> you is costing me...

Hyperbole. You seem to enjoy writing English as much as C :-) Do you
blog? I imagine it'd be a good read.

>> And also gratitude
>> for taking time to fix two of your patches.
>
>
> I reviewed and acked the first fix, which is my way of saying
> thank you. As for this set of fixes, I never asked for those
> and I think they are a bad idea.
>
>> I expect discussion of charger patches with an experienced kernel
>> contributor to look like these threads:
>>
>>
>> https://patchwork.kernel.org/project/linux-pm/list/?submitter=109&state=*&q=bq24190_charger%3A+Use+PM+runtime+autosuspend&archive=both
>
>
> So do I and usually conversations I take place in look like that

Glad to hear it, and I'd love to see it. Above, and previously, I
perceive defamation, which cannot foster collaboration.

Thanks.
