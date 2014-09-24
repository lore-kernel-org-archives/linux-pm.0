From: Joerg Roedel <jroedel@suse.de>
Subject: Re: NULL pointer dereference in swsusp_free with 3.17-rc5
Date: Wed, 24 Sep 2014 11:46:36 +0200
Message-ID: <20140924094636.GB10438@suse.de>
References: <87zjdq8k7i.fsf@nemi.mork.no>
 <2218322.ridXK8jFtJ@vostro.rjw.lan>
 <878ulaxn6d.fsf@nemi.mork.no>
 <1590285.IEab1jMVzk@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:59989 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751601AbaIXJqk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 24 Sep 2014 05:46:40 -0400
Content-Disposition: inline
In-Reply-To: <1590285.IEab1jMVzk@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: =?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>, linux-pm@vger.kernel.org

On Tue, Sep 23, 2014 at 10:28:00PM +0200, Rafael J. Wysocki wrote:
> On Tuesday, September 23, 2014 07:27:06 PM Bj=F8rn Mork wrote:
> >=20
> > --=3D-=3D-=3D
> > Content-Type: text/plain; charset=3Dutf-8
> > Content-Transfer-Encoding: quoted-printable
> >=20
> > "Rafael J. Wysocki" <rjw@rjwysocki.net> writes:
> >=20
> >=20
> > > I would suspect one of these commits:
> > >
> > > 84c91b7ae07c PM / hibernate: avoid unsafe pages in e820 reserved =
regions
> > > 0f7d83e85dbd PM / Hibernate: Touch Soft Lockup Watchdog in rtree_=
next_node
> > > 9047eb629e5c PM / Hibernate: Remove the old memory-bitmap impleme=
ntation
> > > 6efde38f0769 PM / Hibernate: Iterate over set bits instead of PFN=
s in sws=3D
> > usp_free()
> > > 3a20cb177961 PM / Hibernate: Implement position keeping in radix =
tree
> > > 07a338236fdc PM / Hibernate: Add memory_rtree_find_bit function
> > > f469f02dc6fa PM / Hibernate: Create a Radix-Tree to store memory =
bitmap
> > >
> > > so I guess you can start from checking them (the topmpost one is =
the late=3D
> > st).
> >=20
> > Thanks.  Yes, you were correct. The bad commit is
> >=20
> >  6efde38f0769 PM / Hibernate: Iterate over set bits instead of PFNs=
 in swsu=3D
> > sp_free()
> >=20
> > I have confirmed that reverting only this commit on top of a clean
> > v3.17-rc6 fixes the problem.  I am attaching the context-modified r=
evert
> > patch I used.
>=20
> OK, thanks!
>=20
> Joerg, can you please have a look at this?

Yes, I have a look.


	Joerg


