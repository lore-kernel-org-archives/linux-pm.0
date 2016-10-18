From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: how to enable suspend to ram for arm-64 bits
Date: Tue, 18 Oct 2016 11:28:18 +0100
Message-ID: <20161018102818.GA1212@red-moon>
References: <CADUS3onCMDThNK2ZwSSjGZhPE0M6cybjgCHJR2wVVeK09GC6ng@mail.gmail.com>
 <06a4f0d7-9022-578d-99e0-ddcde31ed895@arm.com>
 <CADUS3onUDk_=UpRoZy1m0hV1VGZYSf22ea8D10MpDbqJCfTkqw@mail.gmail.com>
 <82ddd0e1-9ecc-5e54-e8ee-86f947fc0ecd@arm.com>
 <20161018100002.GA4347@xo-6d-61-c0.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:56250 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753548AbcJRK1g (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 18 Oct 2016 06:27:36 -0400
Content-Disposition: inline
In-Reply-To: <20161018100002.GA4347@xo-6d-61-c0.localdomain>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Sudeep Holla <sudeep.holla@arm.com>, yoma sophian <sophian.yoma@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org

On Tue, Oct 18, 2016 at 12:00:02PM +0200, Pavel Machek wrote:
> Hi!
> 
> > >b. in arm64, if some platform has its own suspend flow,  couldn't it
> > >adopts arm/match-xxx to register its own global suspend method?
> > >
> > 
> > No, PSCI is highly recommended.
> 
> Relying on firmware for suspend on x86 was a great disaster, lets not
> repeat that mistake. arm32 has better powermanagement than x86 ever
> will (see Nokia N900 for example) -- feel free to copy that code from
> arm32.

Yes sure, feel free to copy my:

NACKed-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

to all the resulting patches then. On ARM64 if he wants to implement
suspend-to-RAM his PSCI firmware will have to implement PSCI system
suspend method, end of this discussion.

By the way, why are you advising people on this subject ?

What do you know about the PSCI firmware interface to state what
you are saying above ?

Lorenzo
