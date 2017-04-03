From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v3 2/4] power: bq24190_charger: Clean up extcon code
Date: Mon, 3 Apr 2017 10:17:48 +0200
Message-ID: <3f8cf5e0-bd49-f492-f1ec-9dd0336bb3cb@redhat.com>
References: <20170401202519.16280-1-liam@networkimprov.net>
 <20170401202519.16280-3-liam@networkimprov.net>
 <6dbb405d-a840-7216-395f-7e4fa327cd70@redhat.com>
 <CAKvHMgQ6gJ822W_hXO8jGAq_vr4L8NaFJpNHA5sKYJ+kTRtQgg@mail.gmail.com>
 <857a9dd7-8ed3-0afe-d1e2-2420928263aa@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37364 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751500AbdDCISE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 3 Apr 2017 04:18:04 -0400
In-Reply-To: <857a9dd7-8ed3-0afe-d1e2-2420928263aa@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Liam Breck <kernel@networkimprov.net>

Hi,

On 03-04-17 08:53, Hans de Goede wrote:

<snip>

>> You only have this code for the Atom device because I designed and
>> built hardware with this part and hired Mark to write the driver from
>> scratch. I'd like a little goodwill in exchange!
>
> And here we get to the root of the problem, that you keep claiming
> ownership of the driver because you paid Mark to write it,
> this is not how the Linux kernel works. Yes you paid Mark to write
> a driver and in return you get an entire kernel. You no less own
> the bq24190_charger driver then other people own other parts of
> the kernel.
>
> Your remarks against Sebastian that he MUST wait for your ack
> before merging anything are quite frankly completely out of line
> and I have been on the verge of saying something about this
> several times already but I decided to stay quiet (until now).
>
> So yes I apologize for my tone getting a bit cutting as I never
> want that, but TBH I've found the way you're claiming to be
> THE authority on the bq24190_charger driver and have been behaving
> if everyone needs to do exactly as you say when it comes to that
> driver quite off-putting / abrasive.

So thinking some more about this, let me try to explain better why
I feel some friction when discussing things with you.

Lets take for example the discussion about whether to remove the
resetting of the charger from the driver or to keep it, as
seen in 2 different threads through my admittedly colored glasses:

1) I reply to your "power: bq24190_charger: Clean up extcon code"
in what is admittedly a bit cutting tone.

2) We've some discussion about the reset stuff in the
"power: bq24190_charger: Delay before polling reset flag"
part of the thread. I notice that I've yet to hear "a good
technical argument for keeping it".

3) You rightfully point out my cutting tone in 1. is not
appreciated, which is good, please keep pointing out if
you find my tone to be not to your liking.

4) But in the same mail you also re-iterate the point where
you claim some sort of special authority over the driver
because you paid Mark for writing it.

4. Is where the friction in our discussions come from on
my side. The Linux kernel is a meritocracy if you disagree
with something I'm proposing please convince me with
technical arguments not some claimed authority over the
driver.

Or if I'm trying to fix a specific issue suggest a good
alternative. As for example Sebastian did with my
function-pointer to add extra properties and he suggested
to just make the fuel-gauge driver register a battery
interface and remove the battery interface from the
bq24190 driver. Something which I instantly recognized as
a nice and clean solution.

Regards,

Hans
