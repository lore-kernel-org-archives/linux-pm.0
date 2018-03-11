From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: 4.16-rc3 fails to resume on MacBookPro10,1 -
Date: Sun, 11 Mar 2018 11:25:33 +0100
Message-ID: <1796290.BApLEM9bFY@aspire.rjw.lan>
References: <CA+Y=x3=U_zheHBxeNSzL9nSdXOZB7rs-JDNr36323uJ9Uhx0Hg@mail.gmail.com> <20180310131605.GA28296@amd> <CA+Y=x3mwNDNJTt=n-K__wbCb8P+VhgMafRiofc0tnXqdgRk43w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CA+Y=x3mwNDNJTt=n-K__wbCb8P+VhgMafRiofc0tnXqdgRk43w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Worsley <amworsley@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rafael@kernel.org>, kernel list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@vger.kernel.org>, Len Brown <len.brown@intel.com>, 844788@bugs.debian.org
List-Id: linux-pm@vger.kernel.org

On Sunday, March 11, 2018 5:52:47 AM CET Andrew Worsley wrote:
> 
> --94eb2c04c64405d3da05671bccce
> Content-Type: text/plain; charset="UTF-8"
> 
> On 11 March 2018 at 00:16, Pavel Machek <pavel@ucw.cz> wrote:
> > Hi!
> >
> >> > Ok, I've just tested linux-next, and it works ok for me on thinkpad
> >> > x60. (But that's probably rather different configuration from the
> >> > macbook).
> >> >
> >> > Unfortunately, I could not deduce anything useful from the
> >> > backtraces. Andrew, could you try v4.15 with KPTI disabled ?
> >> >
> >> > Thanks,
> >> >                                                                         Pavel
> >>
> >> This is 4.15 kernel with KPTI disabled:
> >> % grep PAGE_TABLE .config
> >> # CONFIG_PAGE_TABLE_ISOLATION is not set
> >>
> >> As I expected it appears no more infomative to me.
> >>
> >> What I really need is some clue as to what is supposed to be happening
> >> at this point.
> >
> > You may want to add some printks to see where it hangs.
> >
> > But maybe before that, you may want to test CPU hotplug, and make sure
> > s2ram works, etc...
> >
> > Perhaps basic-pm-debugging.txt is good place to start?
> >
> > Best regards,
> >                                                                         Pavel
> > --
> 
> Ok - all the test modes work but a full s2ram hangs (never comes back)
> and obviously the resume full save to disk fails.

So there probably is a common cause to these failures and it most likely
is low-level.

It also seems to be specific to your system as S2RAM works for me w/
4.16-rc4 on a few machines and hibernation appears to work here too.

> I attach the following files:
> 
> echo reboot > /sys/power/disk
> echo disk > /sys/power/state
> Then saved dmesg to file  dmesg-reboot-disk-ok.txt

It is better to file a bug at bugzilla.kernel.org for these things,
as they don't always go through email in a good shape.

Thanks,
Rafael
