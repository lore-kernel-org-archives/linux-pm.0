From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: Regression in 4.8 - CPU speed set very low
Date: Mon, 26 Sep 2016 13:37:04 +0200
Message-ID: <3919370.SGLjGupePs@vostro.rjw.lan>
References: <f89dffb9-cc78-9849-9539-74ce89e773cd@lwfinger.net> <28fa8706-4251-4d07-6a6a-4ee8d9d1267b@lwfinger.net> <2be25c2e-8c10-e62a-3a66-19da8143f2b0@lwfinger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2be25c2e-8c10-e62a-3a66-19da8143f2b0@lwfinger.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Larry Finger <Larry.Finger@lwfinger.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Friday, September 23, 2016 09:45:09 PM Larry Finger wrote:
> On 09/18/2016 09:54 PM, Larry Finger wrote:
> > On 09/14/2016 11:00 AM, Larry Finger wrote:
> >> On 09/09/2016 12:39 PM, Larry Finger wrote:
> >>> I have found a regression in kernel 4.8-rc2 that causes the speed of my laptop
> >>> with an Intel(R) Core(TM) i7-4600M CPU @ 2.90GHz to suddenly have a maximum cpu
> >>> frequency of ~400 MHz. Unfortunately, I do not know how to trigger this problem,
> >>> thus a bisection is not possible. It usually happens under heavy load, such as a
> >>> kernel build or the RPM build of VirtualBox, but it does not always fail with
> >>> these loads. In my most recent failure, 'hwinfo --cpu' reports cpu MHz of
> >>> 396.130 for #3. The bogomips value is 5787.73, and the cpu clock before the
> >>> fault is 3437 MHz. Nothing is logged when this happens.
> >>>
> >>> If I were to get a patch that would show a backtrace when the maximum CPU
> >>> frequency is changed, perhaps it would be possible to track this bug.
> >>
> >> I have not yet found the bad commit, but I have reduced the range of commits a
> >> bit. This bug has been difficult to trigger. So far, it has not taken over 1/2
> >> day to appear in bad kernels, thus I am allowing three days before deciding that
> >> a given trial is good. I never saw the problem with 4.7 kernels, but I did in
> >> 4.8-rc1. I also know that it appeared before commit 581e0cd. Commit 1b05cf6 did
> >> not show the bug.
> >>
> >> Testing continues.
> >
> > And still does. My bisection seemed to be trending toward an improbable set of
> > commits, and I needed to do some other work with the machine, thus I started
> > running 4.8-rc6. It failed nearly 48 hours after the reboot, which indicated
> > that using 3 days to indicate a "good" trial was likely too short. I am
> > currently testing the first of the trial and will run it for at least a week. It
> > is unlikely that these tests will be complete before 4,8 is released, even if
> > -rc8 is needed. I will keep attempting to find the faulty commit.
> 
> My debugging continues. After 7 days of beating on commit f7816ad, I have 
> concluded that it is likely good. Thus I think the bug lies between commit 
> 581e0cd (bad) and f7816ad (good). I will need to do a long test on commit 
> 1b05cf6, which did not fail with a shorter run.

581e0cd is not a valid mainline commit hash AFAICS.

What cpufreq driver do you use?

Thanks,
Rafael
