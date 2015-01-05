From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V2 02/14] cpufreq: stats: return -EEXIST when stats are already allocated
Date: Tue, 06 Jan 2015 00:52:53 +0100
Message-ID: <1822529.41loKWJpmB@vostro.rjw.lan>
References: <cover.1420177186.git.viresh.kumar@linaro.org> <1494840.aVYkdgdxZS@vostro.rjw.lan> <CAKohponEXJUbxUSJJJ_=2rwA28keSQ8L+NzhY7c_67ZCo+1aRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:59099 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753813AbbAEXah (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 5 Jan 2015 18:30:37 -0500
In-Reply-To: <CAKohponEXJUbxUSJJJ_=2rwA28keSQ8L+NzhY7c_67ZCo+1aRg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Prarit Bhargava <prarit@redhat.com>, Saravana Kannan <skannan@codeaurora.org>

On Sunday, January 04, 2015 08:48:21 AM Viresh Kumar wrote:
> On 4 January 2015 at 03:28, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > On Friday, January 02, 2015 11:16:39 AM Viresh Kumar wrote:
> >> __cpufreq_stats_create_table() is called from:
> >> - policy create notifier: stats will always be NULL here
> >> - cpufreq_stats_init() calls it for all CPUs as cpufreq-stats can be initialized
> >>   after cpufreq driver. Because CPUs share clock lines, 'stats' will be NULL
> >>   here for the first cpu only and will return back for others.
> >>
> >> While we return for other CPUs, we don't return the right error value. We must
> >> return -EEXIST, as that is the case here.
> >
> > What exactly is wrong with -EBUSY, then?
> 
> Its not that could would fail with EBUSY but this is what I thought.
> Generally:
> - Returning EBUSY means: we are busy right not try again. And that might be
> immediate.
> - Returning EEXIST means: We already have what you are trying to create and
> there is no need to create it again, and so no more tries are required.

Now note how much useful the above is than the stuff in your original changelog.

I'd say all depends on whether or not the callers deal with the error code
appropriately.  If it is propagated all the way to user space, it really should
*not* be -EBUSY, but otherwise this is a matter of how the callers handle the
given error code.


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
