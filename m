From: Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 1/2] Support PCU power metrics in turbostat
Date: Tue, 24 Mar 2015 20:19:46 -0700
Message-ID: <20150325031946.GC15335@tassilo.jf.intel.com>
References: <1415920790-23163-1-git-send-email-andi@firstfloor.org>
 <CAJvTdK=qKzLSKYNjZ+0Ay7F5CzxKov3db3p2KNk59O1iNK+bLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJvTdK=qKzLSKYNjZ+0Ay7F5CzxKov3db3p2KNk59O1iNK+bLw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Andi Kleen <andi@firstfloor.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Mar 24, 2015 at 05:20:13PM -0400, Len Brown wrote:
> <cc: linux-pm list>
> 
> On Thu, Nov 13, 2014 at 6:19 PM, Andi Kleen <andi@firstfloor.org> wrote:
> > From: Andi Kleen <ak@linux.intel.com>
> >
> > Add support for reading PCU power metrics on Sandy Bridge / Ivy Bridge EP
> > and Haswell Server in turbostat. This is done using the perf ABI,
> > using the perf uncore driver. This requires the kernel to
> > have uncore perf driver support.
> 
> What happens if kernel doesn't include that support?

The data is not displayed.

> > The user has to specify the event group using a new -x option. All
> > more sensible option characters were already taken. When -x is
> > not specified no behavior changes.
> 
> I'm concerned that turbostat cmdline is getting too complicated,
> and this makes that more the case.

Modern computers are complicated. No way around it.

> > However this currently runs into a problem with the uncore
> > driver that only makes us able to monitor a single band.
> > Disabled until this is fixed.

BTW this is fixed. Will update.
> > Custom user metrics would be also possible.
> >
> > The event resolution code is derived from the jevents library
> > (parts of pmu-tools, http://github.com/andikleen/pmu-tools)
> > and is BSD licensed.
> 
> can we put BSD licensed code into utilities that are in the linux
> kernel git tree?

I think so.  There are already some.

-Andi
