From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/4] ARM: shmobile: Ignore callbacks for subsys generic_pm_domain_data
Date: Fri, 02 May 2014 13:57:59 +0200
Message-ID: <8001410.m2PQVQUM5h@vostro.rjw.lan>
References: <1397230004-22306-1-git-send-email-ulf.hansson@linaro.org> <1639184.jtW6HVkuRH@vostro.rjw.lan> <CAPDyKFpce1v8Ec4kJzAHxp8QtvXF=PqXi0FbzJbMgs9TCousSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:50179 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751823AbaEBLl0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 2 May 2014 07:41:26 -0400
In-Reply-To: <CAPDyKFpce1v8Ec4kJzAHxp8QtvXF=PqXi0FbzJbMgs9TCousSQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Simon Horman <horms@verge.net.au>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Kevin Hilman <khilman@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomasz Figa <t.figa@samsung.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, Alan Stern <stern@rowland.harvard.edu>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Friday, May 02, 2014 11:13:23 AM Ulf Hansson wrote:
> On 30 April 2014 22:21, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > On Wednesday, April 30, 2014 07:23:08 PM Simon Horman wrote:
> >> On Wed, Apr 30, 2014 at 10:53:58AM +0200, Ulf Hansson wrote:
> >> > On 30 April 2014 00:45, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >> > > On Friday, April 25, 2014 10:06:51 AM Simon Horman wrote:
> >> > >> On Thu, Apr 24, 2014 at 01:25:14PM +0200, Ulf Hansson wrote:
> >> > >> > On 14 April 2014 11:22, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >> > >> > > On 14 April 2014 03:20, Simon Horman <horms@verge.net.au> wrote:
> >> > >> > >> On Fri, Apr 11, 2014 at 05:26:41PM +0200, Ulf Hansson wrote:
> >> > >> > >>> There are no active users of these callbacks, thus there are no benefit
> >> > >> > >>> of trying to invoke them.
> >> > >> > >>>
> >> > >> > >>> Cc: Simon Horman <horms@verge.net.au>
> >> > >> > >>> Cc: Magnus Damm <magnus.damm@gmail.com>
> >> > >> > >>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> >> > >> > >>> ---
> >> > >> > >>>
> >> > >> > >>> I am seeking ack from the SOC maintainers since this needs to go with the other
> >> > >> > >>> patches in this patchset on the PM core.
> >> > >> > >>
> >> > >> > >> In order to reduce the possibility of conflicts I would prefer
> >> > >> > >> to take this patch through my tree.
> >> > >> > >
> >> > >> > > Okay, go ahead!
> >> > >> > >
> >> > >> >
> >> > >> > Hi Simon,
> >> > >> >
> >> > >> > Just wanted to know, if you decided to queue this patch in your tree.
> >> > >> > Or were there anything else you needed me to fix here?
> >> > >>
> >> > >> Sorry for dropping the ball. I will queue-up this patch.
> >> > >
> >> > > OK
> >> > >
> >> > > Ulf, since the rest of the series depends on this one (or at least that's
> >> > > how it looks to me), would you mind resending it when this one gets into the
> >> > > Linus' tree?
> >> >
> >> > Well, I would prefer if we could go ahead with the rest of the patches
> >> > somehow for 3.16, but I guess it will be hard if Simon picks up this
> >> > patch!?
> >> >
> >> > Simon,
> >> > I guess the reason for your concern were about conflicts, but the file
> >> > this patch touch has actually not been modified since Sep 2012. So,
> >> > maybe we could go through Rafaels tree anyway?
> >>
> >> Yes, my primary concern was conflicts.
> >> But as you point out that seems unlikely.
> >>
> >> I have already picked up the patch but the pull request I sent to
> >> the ARM SoC maintainers has not been pulled. And regardless it
> >> won't appear in Linus's tree via that route until v3.16-rc1.
> >>
> >> Perhaps a good way forwards would be for Rafael to also apply the patch
> >> with my Ack.
> >
> > Not really.  No duplicate patches with different changelogs coming from
> > different trees.  Please!
> >
> >> I could also revert the version applied to my tree
> >> if that is of any help.
> >>
> >> Acked-by: Simon Horman <horms+renesas@verge.net.au>
> >
> > Ulf, can you please do as I said?
> 
> Okay! It seems like I have no choice. :-)
> 
> Does that mean you were happy with the rest from this patchset?

Yes, those changes are fine by me.

> Additionally, I intend to post some more patches for the PM domain
> soon. Thus I will need to fold in these patches to any other upcoming
> patchset. Thought it could be good to know.

OK, thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
