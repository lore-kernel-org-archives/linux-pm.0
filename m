From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 14/21] cpuidle: coupled: don't compare cpu masks unnecessarily
Date: Thu, 26 Sep 2013 12:06:04 +0530
Message-ID: <CAKohpokmdk2xJ6OFz68Oen4YRqC5MptSn7tGmH+nZrn9hoLmbA@mail.gmail.com>
References: <cover.1379779777.git.viresh.kumar@linaro.org>
	<564c8b1f073dc396b54866a2220b09b7869289f4.1379779777.git.viresh.kumar@linaro.org>
	<CAMbhsRQRGGpShFiTBP7OZ8txhKG_i-1_s=AAGPQx+JzTkW=0Lg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qa0-f48.google.com ([209.85.216.48]:58343 "EHLO
	mail-qa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751649Ab3IZGgF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 26 Sep 2013 02:36:05 -0400
Received: by mail-qa0-f48.google.com with SMTP id hu16so571789qab.14
        for <linux-pm@vger.kernel.org>; Wed, 25 Sep 2013 23:36:04 -0700 (PDT)
In-Reply-To: <CAMbhsRQRGGpShFiTBP7OZ8txhKG_i-1_s=AAGPQx+JzTkW=0Lg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Colin Cross <ccross@google.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Daniel Lezcano <daniel.lezcano@linaro.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "patches@linaro.org" <patches@linaro.org>, Linux PM list <linux-pm@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>

On 26 September 2013 05:55, Colin Cross <ccross@google.com> wrote:
> I don't agree with this.  This patch is a tiny optimization in code
> that is rarely called, and it moves a final sanity check somewhere
> that it might get missed if the code were later refactored.

This is what we are doing for the first cpu of coupled-cpus:
if (WARN_ON(!cpumask_equal(&dev->coupled_cpus, &dev->coupled_cpus)))
    coupled->prevent++;

i.e. comparing a variable to itself :)

And I believe my patch puts the sanity check at the right place (where
we are using coupled from existing CPUs.. And that is where it should
have been since the beginning)..

If people miss this during code re-factoring, then it would be even more
stupid on the part of Author and Reviewer.. And if it still gets missed
then this is not the only place where we need to worry about such stuff..

This is present everywhere in our code.. You can't really some part of
code to some place and leave the other as-is.. The change is supposed
to be more logical and so funny mistakes must be caught during reviews.
