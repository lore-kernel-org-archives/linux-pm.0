From: Frank Lee <tiny.windzz@gmail.com>
Subject: Re: [PATCH] cpufreq: nforce2: Remove meaningless return
Date: Wed, 5 Dec 2018 01:03:50 +0800
Message-ID: <CAEExFWsiqr6QXAg0cg4N6b6JqRvvBVxF5=4maJbk5i5+uZOpwg@mail.gmail.com>
References: <20181130142557.2623-1-tiny.windzz@gmail.com> <CAJZ5v0hPPWx6ZbTPRLRMj_0zSF91ApS3BWgYGj31GqzhX45sYw@mail.gmail.com>
 <CAEExFWuZmcTLF+hFahucUuHzp81OXTxm5sJu_AooCz+jZJUnvA@mail.gmail.com> <CAJZ5v0iApdOc+kgpUrJGSvtmTsXfCFksWg2PsNekOKHaZbffrA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0iApdOc+kgpUrJGSvtmTsXfCFksWg2PsNekOKHaZbffrA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rafael@kernel.org
Cc: rjw@rjwysocki.net, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, Dec 4, 2018 at 4:46 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Tue, Dec 4, 2018 at 2:15 AM Frank Lee <tiny.windzz@gmail.com> wrote:
> >
> > On Mon, Dec 3, 2018 at 5:14 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > >
> > > On Fri, Nov 30, 2018 at 3:26 PM Yangtao Li <tiny.windzz@gmail.com> wrote:
> > > >
> > > > In a function whose return type is void, returning on the last line is
> > > > not required.So remove it.Also move the module declaration to the end.
> > >
> > > The last piece is not reflected by the subject.
> > >
> > > Also, why do you move the MODULE_ stuff around at all?
> > When writing a driver, in most cases MODULE_  are put to the end.
> > Why not modify this? it is more in line with the habits of most people.
>
> If you write a new driver, then yes.
>
> But why do you want to modify existing drivers this way?  What value
> do you see in those changes, exactly?
OK.I'll update this.

MBR,
Yangtao
