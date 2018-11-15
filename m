From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [RFC/RFT][PATCH v3] cpuidle: New timer events oriented governor
 for tickless systems
Date: Thu, 15 Nov 2018 03:29:58 +0100
Message-ID: <CAJZ5v0h_+VnTEUDsc+7ToG7cPeUvLoRy5sdZbrUnd5A3XZ3h7w@mail.gmail.com>
References: <000001d476bb$ec964520$c5c2cf60$@net> <004901d47be2$fa1d0c20$ee572460$@net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <004901d47be2$fa1d0c20$ee572460$@net>
Sender: linux-kernel-owner@vger.kernel.org
To: Doug Smythies <dsmythies@telus.net>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Giovanni Gherdovich <ggherdovich@suse.cz>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Frederic Weisbecker <frederic@kernel.org>, Mel Gorman <mgorman@suse.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, Linux PM <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Nov 14, 2018 at 7:26 AM Doug Smythies <dsmythies@telus.net> wrote:
>
> On 2018.11.08 00:00 Rafael J. Wysocki wrote:
> > On Wednesday, November 7, 2018 6:04:12 PM CET Doug Smythies wrote:
> >> On 2018.11.04 08:31 Rafael J. Wysocki wrote:
>
> ...[snip]...
> >> The results are:
> >> http://fast.smythies.com/linux-pm/k420/k420-dbench-teo3.htm
> >> http://fast.smythies.com/linux-pm/k420/histo_compare.htm
>
> ...[snip]...
>
> >> There are some odd long idle durations with TEOv3 for idle
> >> states 1, 2, and 3 that I'll watch for with v4 testing.
> >
> > That unfortunately is a result of bugs in the v4 (and v2 - v3 too).
> >
> > Namely, it doesn't take the cases when the tick has been stopped already
> > into account correctly.  IOW, all of the data points beyond the tick boundary
> > should go into the "final" peak.
> >
> > I'll send a v5.
>
> With v5 there were no long idle durations for idle states 1, 2, and 3 for
> this same Phoronix dbench test.

That's good news, thank you!
