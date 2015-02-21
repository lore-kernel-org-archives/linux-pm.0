From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] PM / sleep: add configurable delay for pm_test
Date: Sun, 22 Feb 2015 00:24:29 +0100
Message-ID: <20150221232429.GA3519@amd>
References: <1409788535-28264-1-git-send-email-computersforpeace@gmail.com>
 <20141213025530.GO21347@ld-irv-0074>
 <20141213083123.GA26129@amd>
 <20141216235813.GI9759@ld-irv-0074>
 <20141217080947.GB2027@amd>
 <20141217091057.GH7112@brian-ubuntu>
 <20141217092255.GA4588@amd>
 <CAGVrzcZgwQqfBkupWkChYg8NmpKsFzWNa0jB18wN6YUuOzgvsw@mail.gmail.com>
 <20150221203256.GA15228@amd>
 <CAGVrzcYSHem65m6ChSF83qu5AF_fQVZj=qdV+vNNtSKZM1YLXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAGVrzcYSHem65m6ChSF83qu5AF_fQVZj=qdV+vNNtSKZM1YLXg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Brian Norris <computersforpeace@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux Kernel <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Len Brown <len.brown@intel.com>, Chirantan Ekbote <chirantan@chromium.org>
List-Id: linux-pm@vger.kernel.org

On Sat 2015-02-21 14:56:01, Florian Fainelli wrote:
> 2015-02-21 12:32 GMT-08:00 Pavel Machek <pavel@ucw.cz>:
> >
> >
> >
> >> Considering that Brian's change are enclosed within a CONFIG_PM_DEBUG
> >> ifdef, can we really use the code bloat as a technical argument here?
> >
> > Yes.
> 
> Help me understand a few things here:

What you are missing is that we try to keep _sources_ small and
readable, too.

> - if we need to turn on PM_DEBUG all the time, including mainline
> distributions, does that mean that:
>            - portions of code existing only in PM_DEBUG should be
> moved out of it because it is actually useful outside of debug option?
>            - CONFIG_PM itself is not self sufficient and there are
> still problems that require PM_DEBUG to be turned on?
>            - should there be a second level debug option (e.g:
> CONFIG_PM_DEBUG_ADV) which gates specific control knobs like PM delay?
> 
> The current 5 seconds delay is completely arbitrary and goes against
> the principle of not enforcing a policy, having this configurable
> brings this back in the mechanism principle.

5 second delay is arbitrary, and slightly ugly debugging hack, that is
acceptable because it is useful, small and unobtrusive. The second you
add 40 lines of sysfs glue.. it is no longer small and unobtrusive,
and no longer acceptable.

And yes, distros probably ship with PM_DEBUG on, and no, adding
another config option would not make the big & ugly hack more
acceptable.

OTOH if you added a hook to kprobes that alowed easy binary patching
of the value "5" while not adding 40 lines of overhead, that might be
neccessary.

Actually, you can probably pull the address from System.map and then
just write to it using /dev/mem, no? Just arrange for "5" to be in
variable that is in System.map.

And you also want to check the kernel parameters, they are modifiable
in runtime in at least same cases.

But we are not adding 40 lines of uglyness. Clear?
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
