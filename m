From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 3/8] PM / Domains: Add lockdep asserts for domains list mutex
Date: Tue, 13 Jun 2017 10:34:49 +0200
Message-ID: <CAPDyKFpG_o_PEoGUvEgV_s2PovW3VsR9NjzUo9SEKv1GGfO=Ew@mail.gmail.com>
References: <20170612151748.7380-1-krzk@kernel.org> <20170612151748.7380-4-krzk@kernel.org>
 <CAPDyKFr=-Ty9ZQ276nmkAPnJjwc3PmuKSdJrOqeEYcxbgfypYA@mail.gmail.com> <20170613071218.bbml7vsfcdgpirlp@kozik-lap>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qt0-f180.google.com ([209.85.216.180]:34685 "EHLO
        mail-qt0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751891AbdFMIeu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Jun 2017 04:34:50 -0400
Received: by mail-qt0-f180.google.com with SMTP id c10so161176738qtd.1
        for <linux-pm@vger.kernel.org>; Tue, 13 Jun 2017 01:34:50 -0700 (PDT)
In-Reply-To: <20170613071218.bbml7vsfcdgpirlp@kozik-lap>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 13 June 2017 at 09:12, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On Mon, Jun 12, 2017 at 09:09:59PM +0200, Ulf Hansson wrote:
>> On 12 June 2017 at 17:17, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>> > Add lockdep checks for holding mutex protecting the list of domains.
>> > This might expose misuse even though only file-scope functions use it
>> > for now.
>>
>> I think it seems a bit silly to use these lockdep checks as these
>> functions are as you state above, static functions. Moreover there are
>> called from a quite limited amount of places.
>>
>> Do you really think this add some value?
>
> In ideal world, these would not need lockdeps because we do not make
> mistakes. I agree, that mostly the exposed functions to other kernel
> modules should be protected, as lockdep annotation is a more advanced
> way of documenting the need of locking.
>
> Does it mean that file-scope functions should not be annotated? Even in
> such case function can be misused as the code is getting more and more
> complicated.
>
> What is best example, one of these calls (pm_genpd_present()) was
> already used in wrong way, without locking when iterating over the list.
> Having lockdep would point this early.

Well, I think we found a potential bug because of reviewing the code.
Not because of adding lockdep_assert_held().

Perhaps adding protection with lockdep_assert_held() could be
meaningful also for static functions, but only in cases of complicated
code. I don't think that is the case here.

Anyway, if other people thinks $subject patch is good idea, then I
drop my case. :-)

[...]

Kind regards
Uffe
