From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Update][PATCH 7/9] PM / Runtime: Add generic clock
	manipulation rountines for runtime PM
Date: Tue, 19 Apr 2011 23:42:26 +0200
Message-ID: <201104192342.26670.rjw__47997.3022047945$1303249398$gmane$org@sisk.pl>
References: <201104130205.26988.rjw@sisk.pl> <201104182159.54316.rjw@sisk.pl>
	<BANLkTimZpXAH7uGTDmYJSJJWgX=H5md0JQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <BANLkTimZpXAH7uGTDmYJSJJWgX=H5md0JQ@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-sh@vger.kernel.org, Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Grant Likely <grant.likely@secretlab.ca>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday, April 19, 2011, Magnus Damm wrote:
> Hi Rafael,
> 
> On Tue, Apr 19, 2011 at 4:59 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> >
> > Many different platforms and subsystems may want to disable device
> > clocks during suspend and enable them during resume which is going to
> > be done in a very similar way in all those cases.  For this reason,
> > provide generic routines for the manipulation of device clocks during
> > suspend and resume.
> >
> > Convert the ARM shmobile platform to using the new routines.
> >
> > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> > ---
> >
> > Hi,
> >
> > The previous version of the patch had a build problem for CONFIG_HAVE_CLK
> > unset and a the name of pm_runtime_clock_add_notifier() misspelled (a
> > couple of times).
> 
> Thanks for your work on this. I like that we get closer to a shared code base.
> 
> Do you have any plans to add support for multiple clocks per struct
> device? I had some plans to play around with that myself, but if we're
> moving the code to a common place then this obviously becomes a bit
> more complicated.
> 
> It's rather common that each hardware block in an SoC is connected to
> more than a single clock. This needs to be managed by software
> somehow.
> 
> So if the plan is to make to the code generic, how about allowing the
> architecture to associate clocks with each struct device somehow?

Hmm.  For now, my patchset generally reorganizes the existing code without
adding new functionality.  Of course, it is possible to add new functionality
on top of it, but I'd prefer to focus on the "real" power domains support
first (which I think should be done in a generic way too).

The plan is to share as much code as it makes sense between platforms and
architectures.

Thanks,
Rafael
