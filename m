From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] Documentation: cpufreq: Update supported powernv processors
Date: Wed, 4 Jan 2017 23:34:24 +0100
Message-ID: <CAJZ5v0jVbPr-OMFg=u_UFun2q60ga7Q5PdD8t6x8_H-qkVZfyA@mail.gmail.com>
References: <1481887062-25522-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <20170102070815.GB8588@vireshk-i7> <20170104143527.6193ee5f@lwn.net>
 <2779526.rqWzLUd9EW@aspire.rjw.lan> <20170104152051.6bc78d04@lwn.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170104152051.6bc78d04@lwn.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonathan Corbet <corbet@lwn.net>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, Linux PM <linux-pm@vger.kernel.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Jan 4, 2017 at 11:20 PM, Jonathan Corbet <corbet@lwn.net> wrote:
> On Wed, 04 Jan 2017 23:11:30 +0100
> "Rafael J. Wysocki" <rjw@rjwysocki.net> wrote:
>
>> I'm assuming then, that you're going to handle cpufreq docs changes in the
>> future.
>>
>> Some cpufreq patches update the docs too, though, so there may be changes in
>> there coming from two sources.
>
> I saw it wasn't in linux-next yet, so figured I had to. :)

Well, it actually is there in my linux-next branch and I was going to
include it in the next pull request.

Still, I can drop it easily enough. :-)

> If you'd rather I stayed away from there, I'll happily do so, just say
> the word (and preferably send a MAINTAINERS update :).

I can handle cpufreq docs updates, but if you think it's better to
route them via the docs tree, that would be fine by me too.

Thanks,
Rafael
