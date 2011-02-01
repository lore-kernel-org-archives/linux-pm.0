From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH] Power domains for platform bus type
Date: Tue, 1 Feb 2011 11:58:46 +0100
Message-ID: <201102011158.46312.rjw__1049.36291832036$1296558177$gmane$org@sisk.pl>
References: <201101300107.19389.rjw@sisk.pl> <871v3s3ahe.fsf@ti.com>
	<AANLkTinEsUOZQURXOfAVoTU5=k0mi8PC0_Gte6gACDFj@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTinEsUOZQURXOfAVoTU5=k0mi8PC0_Gte6gACDFj@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday, February 01, 2011, Grant Likely wrote:
> On Mon, Jan 31, 2011 at 4:43 PM, Kevin Hilman <khilman@ti.com> wrote:
> > "Rafael J. Wysocki" <rjw@sisk.pl> writes:
> >
> >>> Also, what is the use case for having 2 sets of power_domain ops?  My
> >>> gut tells me that you'd only want to do post ops on the
> >>> {freeze,suspend,poweroff} path and pre ops on the {resume,thaw,restore}
> >>> path.  It seems overly engineered to me, but I may be missing
> >>> something fundamental.
> >>
> >> Well, that's a part of the RFC, actually. :-)
> >>
> >> For the subsystems I've worked with (PCI, ACPI, PNP to some extent) one set
> >> would be sufficient, but I don't know of every possible use case.
> >
> > For the on-chip SoC devices we're managing with OMAP, we're currently
> > only using one set: post ops on [runtime_]suspend and pre ops on
> > [runtime_]resume.
> >
> > However, I could imagine (at least conceptually) using the pre ops on
> > suspend to do some constraints checking and/or possibly some
> > management/notification of dependent devices.  Another possiblity
> > (although possibly racy) would be using the pre ops on suspend to
> > initiate some high-latency operations.
> >
> > I guess the main problem with two sets is wasted space.  e.g, if I move
> > OMAP to this (already hacking on it) there will be only 2 functions used
> > in post ops: [runtime_]suspend() and 2 used in pre ops [runtime_]_resume().

I agree with Alan that the wasted space is not substantial.

> There's a conceptual load added to the (human) reader too.  Every
> additional hook point is an additional piece other engineers need to
> fit into their mental model.  I'm resistant to having the two sets of
> ops without a definite use case for it when conceptually I can only
> imagine a need for one set.

There are two possibilities I think.  First, we can use one set for now
and possibly add the other one in the future if it proves necessary.  Second,
we can use two sets to start with and then drop one of them if no one finds it
useful.

I guess the first option is a cleaner one, so I'm going to move forward along
this line.

Also, I'm going to move the power domain hook to the struct device level, so
that we have:

struct device {
    ...
    struct power_domain *domain;
    ...
};

struct power_domain {
    struct dev_pm_ops ops;
};

This way, if there's a need to add the second set of operations, it will be
relatively easy to do that without major redesign.

Thanks,
Rafael
