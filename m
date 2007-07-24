From: Igor Stoppa <igor.stoppa@nokia.com>
Subject: Re: Power Management framework proposal
Date: Tue, 24 Jul 2007 17:18:16 +0300
Message-ID: <1185286696.12325.6.camel__40938.6398540393$1185286986$gmane$org@localhost.localdomain>
References: <Pine.LNX.4.64.0707212339550.6350@asgard.lang.hm>
	<1185091022.19678.28.camel@localhost.localdomain>
	<Pine.LNX.4.64.0707220057210.6350@asgard.lang.hm>
	<1185105911.29238.43.camel@localhost.localdomain>
	<Pine.LNX.4.64.0707221156210.6350@asgard.lang.hm>
	<1185187720.26628.23.camel@localhost.localdomain>
	<Pine.LNX.4.64.0707231033430.3828@asgard.lang.hm>
	<4240b9160707240143u6cdaba64rae93528661f4475c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4240b9160707240143u6cdaba64rae93528661f4475c@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: ext Jerome Glisse <j.glisse@gmail.com>
Cc: "david@lang.hm" <david@lang.hm>, "ext linux-pm-bounces@lists.linux-foundation.org" <linux-pm-bounces@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 2007-07-24 at 10:43 +0200, ext Jerome Glisse wrote:

> I believe a central place where user can set/change hw state to save
> power or to increase computational power is definitely a goal to pursue.
> But i truly think that the OHM approach is the best one ie using plugins
> so that one can make a plugin specific for each device. The point is that
> i believe there is no way to do an abstract interface for this and trying to
> do so will endup doing ugly code and any interface would fail to encompass
> all possible tweak that might exist for all devices.
> 
> For instance on graphics card you could do the following (maybe more):
> -change GPU clock
> -change memory clock
> -disable part of engine
> -disable unit
> i truly don't think you can make a common interface for all this, more
> over there might be constraint on how you can change things (GPU &
> memory clock might need to follow a given ratio). So you definitely
> need knowledge in the user space program to handle this.

Even simpler case: LCD backlight can come in many flavors, both in terms
of brightness levels and fixed amount of current required to keep it ON.

Trying to abstract such details from the decision-making makes little
sense.
Isolating that into a separate module, instead, brings the best of both
worlds:
-containment of the HW-specific code
-leveraging every possible, no matter how exotic, power saving mode
available.


-- 
Cheers, Igor

Igor Stoppa <igor.stoppa@nokia.com>
(Nokia Multimedia - CP - OSSO / Helsinki, Finland)
