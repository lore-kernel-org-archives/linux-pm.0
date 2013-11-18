From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: stats: Do not populate stats when policy->cur
 has no exact match
Date: Mon, 18 Nov 2013 20:52:02 +0530
Message-ID: <CAKohpokzk2Zr7G+GV9d9Bc73WJHNMg01dfAJcxbwCGKFt9BpOw@mail.gmail.com>
References: <1384561243-30391-1-git-send-email-nm@ti.com>
	<1423628.uM8DtnYzDe@vostro.rjw.lan>
	<5287010F.9000508@linaro.org>
	<528A2D59.3080001@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <528A2D59.3080001@ti.com>
Sender: cpufreq-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Carlos Hernandez <ceh@ti.com>, Tobias Diedrich <ranma+xen@tdiedrich.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Dave Jones <davej@redhat.com>
List-Id: linux-pm@vger.kernel.org

On 18 November 2013 20:38, Nishanth Menon <nm@ti.com> wrote:
> On 11/15/2013 11:22 PM, viresh kumar wrote:

>> I have a untested patch for this. If this looks okay, Nishant can you please try
>> below patch? With some fixups from your side :)
>
> http://pastebin.mozilla.org/3628975
>
> I agree that it does show something

Were you required to update it or fix it? Or you used it as is?

> but would we not rather prefer to
> stick with the entries available in freq_table than have to deal with
> invalid frequencies that may be provided by the driver? for example:
> how do we in stat know that there will only be one invalid frequency
> request?

We don't have to. Actually there is nothing like an invalid freq, as system
is able to run with it. Its only if kernel is allowed to switch to that
frequency or not.

This information will be useful for platform developers to know that kernel
was running on some out of freq-table freq for some time, what that
frequency was their job to find out and kernel doesn't need to print all
out of range frequencies. Keeping a single entry for that is more than
sufficient..

Though I personally didn't like: 4294967295 to be printed there.. Will
see if I can improve that, but its obviously looks better than failing
in cpufreq-stats..

> there are some patch wrapping that thunderbird tends to do - I prefer
> mutt that way, when I need to send inline patches :).

There are steps in Documentation/email-clients.txt to get that fixed.. I
have used thunderbird for several years and never found anything
wrong with sending inline patches..
