From: Javi Merino <javi.merino@arm.com>
Subject: Re: [PATCH v4 0/5] Let the power allocator thermal governor run on
 any thermal zone
Date: Mon, 14 Sep 2015 14:32:14 +0100
Message-ID: <20150914133214.GA31370@e104805>
References: <1439833008-26440-1-git-send-email-javi.merino@arm.com>
 <1440595604-27197-1-git-send-email-javi.merino@arm.com>
 <20150914030414.GA5075@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from fw-tnat.cambridge.arm.com ([217.140.96.140]:57692 "EHLO
	cam-smtp0.cambridge.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754109AbbINNcS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 14 Sep 2015 09:32:18 -0400
Content-Disposition: inline
In-Reply-To: <20150914030414.GA5075@localhost.localdomain>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "cywang@chromium.org" <cywang@chromium.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Punit Agrawal <Punit.Agrawal@arm.com>, "djkurtz@chromium.org" <djkurtz@chromium.org>

On Mon, Sep 14, 2015 at 04:04:16AM +0100, Eduardo Valentin wrote:
> Javi,
> 
> On Wed, Aug 26, 2015 at 02:26:39PM +0100, Javi Merino wrote:
> > Relax the thermal governor requirements of sustainable_power and at
> > least two trip points so that it can be bound to any thermal zone.
> > Its behavior won't be optimal, it would be the best it can with the
> > data provided.
> > 
> > Changes since v3:
> >    - Don't hardcode a value for sustainable power and re-estimate
> >      the PID controllers every time if no sustainable power is given
> >      as suggested by Eduardo Valentin.
> >    - power_actor_get_min_power() moved to a patch of its own.
> > 
> > Changes since v2:
> >   - Typos suggested by Daniel Kurtz
> > 
> > Changes since v1:
> >   - Let the power allocator governor operate if the thermal zone
> >     doesn't have tzp as suggested by Chung-yih Wang
> > 
> > Javi Merino (5):
> >   thermal: Add a function to get the minimum power
> >   thermal: power_allocator: relax the requirement of a sustainable_power
> >     in tzp
> >   thermal: power_allocator: relax the requirement of two passive trip   
> >      points
> >   thermal: power_allocator: don't require tzp to be present for the
> >     thermal zone
> >   thermal: power_allocator: exit early if there are no cooling devices
> 
> This patch set does not apply clean. Could you please refresh it?

I've sent a v6 that's rebased on top of v4.3-rc1

Cheers,
Javi
