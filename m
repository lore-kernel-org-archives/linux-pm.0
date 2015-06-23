From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCH 8/8] dt: cpufreq: st: Provide bindings for ST's CPUFreq implementation
Date: Tue, 23 Jun 2015 10:52:53 +0200
Message-ID: <CABxcv=nRiPkC8wXt02LhFF+0CGjAMKusNWGQLbL+RrvsFS1iMw@mail.gmail.com>
References: <1434987837-24212-1-git-send-email-lee.jones@linaro.org>
	<1434987837-24212-9-git-send-email-lee.jones@linaro.org>
	<20150623023458.GC16776@linux>
	<20150623070651.GA3245@x1>
	<20150623075509.GF16776@linux>
	<20150623083856.GH3245@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yk0-f182.google.com ([209.85.160.182]:36436 "EHLO
	mail-yk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753546AbbFWIwy (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 23 Jun 2015 04:52:54 -0400
Received: by ykdr198 with SMTP id r198so1645493ykd.3
        for <linux-pm@vger.kernel.org>; Tue, 23 Jun 2015 01:52:53 -0700 (PDT)
In-Reply-To: <20150623083856.GH3245@x1>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh@kernel.org>, kernel@stlinux.com, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux Kernel <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, ajitpal.singh@st.com, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hello Lee and Viresh,

On Tue, Jun 23, 2015 at 10:38 AM, Lee Jones <lee.jones@linaro.org> wrote:
> On Tue, 23 Jun 2015, Viresh Kumar wrote:
>> On 23-06-15, 08:06, Lee Jones wrote:
>> >
>> > > Over that, this patch should have been present before any other
>> > > patches using these bindings.
>> >
>> > I've never heard that one before, but it's easy to re-order the set.
>>
>> I don't know, but it seems obvious to me: Bindings first and then the
>> code.
>
> Do you always write your documentation before implementing a
> feature?
>
> Surely it goes;
>   Requirements Gathering
>   Plan and Prepare
>   Implement
>   Test
>   Document
>   Deliver
>
> ;)
>
> ... but as I say, I can re-order if required.  It's really not a problem.
>

This is actually documented in
Documentation/devicetree/bindings/submitting-patches.txt:
...

  3) The Documentation/ portion of the patch should come in the series before
     the code implementing the binding.

....

The rationale AFAIU is that it is easier to review the implementation
of a binding after reading the DT binding doc since then you can see
if the code matches what the DT binding describes.

Best regards,
Javier
