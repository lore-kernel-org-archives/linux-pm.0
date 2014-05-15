From: Mikulas Patocka <mpatocka@redhat.com>
Subject: Re: Format of patches (was: [PATCH 1/2] speedstep-smi: enable
 interrupts when waiting)
Date: Thu, 15 May 2014 08:45:53 -0400 (EDT)
Message-ID: <alpine.LRH.2.02.1405150843180.8791@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.1405141012040.11670@file01.intranet.prod.int.rdu2.redhat.com> <CAKohpo=h8cNbb2VbWzpDUPQDMK8QAs_sV=-SQyOaJWWFw4qKvA@mail.gmail.com> <alpine.LRH.2.02.1405150614100.19101@file01.intranet.prod.int.rdu2.redhat.com>
 <CAKohponwxi96buPx=vYgY1jZhSUanOZ2G7g2CjoapE=stzJcXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAKohponwxi96buPx=vYgY1jZhSUanOZ2G7g2CjoapE=stzJcXw@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org



On Thu, 15 May 2014, Viresh Kumar wrote:

> On 15 May 2014 16:07, Mikulas Patocka <mpatocka@redhat.com> wrote:
> > On Thu, 15 May 2014, Viresh Kumar wrote:
> >> On 14 May 2014 19:54, Mikulas Patocka <mpatocka@redhat.com> wrote:
> >> > Hi Viresh
> >> >
> >> > Some times ago, I sent these two cpufreq patches to fix frequency
> >> > transition problem on speedstep-smi, but you didn't put them to the
> >> > upstream kernel. I am resending the patches. If you would like a different
> >> > solution to this problem, please explain it.
> >>
> >> Probably these are just missed by Rafael. The patches are fine but the
> >> above paragraph you wrote would get into kernel logs and must have
> >> been placed below the three dash lines: "---"
> >
> > I used "---" in the past, but some people complained that their script
> > picks the text above "---" and ignores the text below "---" - thus, it
> > does exactly the opposite of what it should do.
> 
> Have you added an extra line with --- ? Probably yes.
> I haven't asked you to add another line, but move the part you don't want
> to be commited below --- already present in patch..
> 
> Like:
> 
> > ---
> 
> Blurb here :)

Sure - but if I want you to read "Blurb here :)" before reading the git 
message, I need to place it at the top of the email, before the git 
message.

> >  drivers/cpufreq/speedstep-lib.c |    3 +++
> >  drivers/cpufreq/speedstep-smi.c |   12 ++++++++++++
> >  2 files changed, 15 insertions(+)
> >
> 
> 
> > I don't know what kind of delimiter should I use. Suppose that I want to
> > send something like this:
> 
> Will go through below mail of yours once we are clear on above..

Mikulas
