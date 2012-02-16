From: Eric Sandeen <sandeen@redhat.com>
Subject: Re: Corrupted files after suspend to disk
Date: Thu, 16 Feb 2012 15:27:29 -0800
Message-ID: <4F3D90E1.6010001@redhat.com>
References: <AANLkTinRC1hXvaXDVV5pOA4YyCdXwAjziZsDzm=LuHqK@mail.gmail.com> <AANLkTinewk=mJZifVxEJkCtKfNauOjHnLAqwbGn139C=@mail.gmail.com> <AANLkTikui_HQ5JMcMJUqMr9WLyTRNzF-z4G7wAUNPOFy@mail.gmail.com> <201103242330.14416.rjw@sisk.pl> <CAFLxGvzzHDRma_Y_XEpOD+fY+vonbkoR1mvQp4Vb4c3M6fTsPA@mail.gmail.com> <20120216163030.GA32651@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120216163030.GA32651@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dave Jones <davej@redhat.com>, richard -rw- weinberger <richard.weinberger@gmail.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, LKML <linux-kernel@vger.kernel.org>, linux-pm@lists.linux-foundation.org, esandeen@redhat.com
List-Id: linux-pm@vger.kernel.org

On 2/16/12 8:30 AM, Dave Jones wrote:
> On Thu, Feb 16, 2012 at 11:52:27AM +0100, richard -rw- weinberger wrote:
>  
>  > >> >> Of course, please test the above separately. :-)
>  > >> >
>  > >> > Ok, I'll test this when I'm at home.
>  > >> >
>  > >> > BTW: dropping the caches helps, when some files seem corrupted.
>  > >> > Today /usr/bin/okular was broken.
>  > >> > After setting vm.drop_caches=1 it worked again.
>  > >>
>  > >> On Linux 2.6.38 I'm unable to reproduce the issue.
>  > >> Only 2.6.37 seems to be affected.
>  > >> So, I'm moving over to 2.6.38. :)
>  > >
>  > Bad news:
>  > I saw the issue on 3.x too but thought it's because my IdeaPad s10 is crap.
>  > Now with my shiny new Lenovo x121e I have the same issue! :-(
>  > 
>  > OpenSUSE 12.1, kernel 3.2.7.
>  > After a few suspend2disk iterations random files are corrupted.
>  > But only cached files. A reboot solves the problem.

Just to be clear - you see _data_ corruption in files, but only
until a reboot, and after that they are ok?  Ok, reading above
about using drop_caches that sounds like the case.

That sounds different from what I saw in the bug Dave mentions
below, but possibly related root cause, I suppose.

-Eric

> FWIW, we've been seeing a number of hard to diagnose failures
> with suspend to disk for the last few releases in Fedora.
> Eric Sandeen has been chasing https://bugzilla.redhat.com/show_bug.cgi?id=744275
> for a while, but there's no smoking gun that really explains what's
> getting into these states. Further complicating things, is that it
> doesn't seem to be 100% reproducable.
> 
> 	Dave
> 
