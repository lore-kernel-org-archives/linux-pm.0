From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/1] cpufreq: pcc-cpufreq: Re-introduce deadband effect
 to reduce number of frequency changes
Date: Wed, 5 Oct 2016 10:51:37 +0530
Message-ID: <20161005052137.GL4664@vireshk-i7>
References: <20160819122101.GB17296@suselix.suse.de>
 <20160829060153.GA5094@vireshk-i7>
 <20160901132140.GA10183@suselix.suse.de>
 <20160907050201.GK27345@vireshk-i7>
 <20160916094727.GA4026@suselix>
 <fecb55b0-63ed-1d11-d85b-16cc73f2010b@semaphore.gr>
 <CADmjqpNE9f7fzQjWsHKB4wEjLq-4ZvQpaC314OcLdQ-i_TAABg@mail.gmail.com>
 <20160919161611.GB17693@suselix.suse.de>
 <CADmjqpOuXnri2MdJyvGVgkJ0tsbDMb7Q1O=x65-7OHGWwViOJA@mail.gmail.com>
 <20160922175448.GA25183@suselix.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:34754 "EHLO
        mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751308AbcJEFVl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 5 Oct 2016 01:21:41 -0400
Received: by mail-pa0-f44.google.com with SMTP id rz1so25471704pab.1
        for <linux-pm@vger.kernel.org>; Tue, 04 Oct 2016 22:21:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160922175448.GA25183@suselix.suse.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andreas Herrmann <aherrmann@suse.com>
Cc: Stratos Karafotis <skarafotis@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Stratos Karafotis <stratosk@semaphore.gr>, Thomas Renninger <trenn@suse.com>

On 22-09-16, 19:54, Andreas Herrmann wrote:
> On Mon, Sep 19, 2016 at 10:39:18PM +0300, Stratos Karafotis wrote:
> > Just an idea. I would split the frequency range (max_freq - min_freq)
> > into ~10 steps. But I'm not familiar with the affected systems and
> > of course I can't prove this is an ideal approach.
> 
> I've modified the pcc-cpufreq specific map_load_to_freq function to do
> just that (map load values to 10 discrete frequency values) instead of
> falling back to the deadband (pre-commit-6393d6-version).

And in that you can remove the deadband frequencies from the table to
get almost the same results, as I already stated in an earlier email.

-- 
viresh
