From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v1 1/7] devicetree: power: battery: Add properties for
 pre-charge and end-charge current
Date: Tue, 28 Mar 2017 19:43:02 -0500
Message-ID: <20170329004302.6eyka3mqxs6zfvpn@rob-hp-laptop>
References: <20170321220921.5834-1-liam@networkimprov.net>
 <20170321220921.5834-2-liam@networkimprov.net>
 <20170324090158.tl55neisjws66naf@earth>
 <CAKvHMgQt=C1tmfPz3pp_vwhc3b9DHKau2t=jwp3Rv2b2U6hsaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ot0-f195.google.com ([74.125.82.195]:34629 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932619AbdC2AnF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 28 Mar 2017 20:43:05 -0400
Content-Disposition: inline
In-Reply-To: <CAKvHMgQt=C1tmfPz3pp_vwhc3b9DHKau2t=jwp3Rv2b2U6hsaQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, linux-pm@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, devicetree@vger.kernel.org, Liam Breck <kernel@networkimprov.net>

On Fri, Mar 24, 2017 at 05:34:26PM -0700, Liam Breck wrote:
> On Fri, Mar 24, 2017 at 2:01 AM, Sebastian Reichel <sre@kernel.org> wrote:
> > Hi,
> >
> > On Tue, Mar 21, 2017 at 03:09:15PM -0700, Liam Breck wrote:
> >> From: Liam Breck <kernel@networkimprov.net>
> >>
> >> precharge-current-microamp and endcharge-current-microamp are used
> >> by battery chargers at the beginning and end of a charging cycle.
> >>
> >> Depends-on: https://patchwork.kernel.org/patch/9633605/
> >> Cc: Rob Herring <robh@kernel.org>
> >> Cc: devicetree@vger.kernel.org
> >> Signed-off-by: Liam Breck <kernel@networkimprov.net>
> >
> > Acked-by: Sebastian Reichel <sre@kernel.org>
> >
> > I think it makes sense to merge this into the patch adding
> > simple-battery.

Agreed.

> 
> It would make sense, but it means a new _prop_precharge/endcharge
> patch in that patchset, and I am trying to constrain it at this stage.

Please make bindings complete as possible. You don't have to have the 
driver side.

Rob
