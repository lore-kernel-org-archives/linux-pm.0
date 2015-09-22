From: "Pallala, Ramakrishna" <ramakrishna.pallala@intel.com>
Subject: RE: [PATCH] power: bq24261_charger: Add support for TI BQ24261
 charger
Date: Tue, 22 Sep 2015 15:43:13 +0000
Message-ID: <D854C92F57B1B347B57E531E78D05EAD5790FE2E@BGSMSX104.gar.corp.intel.com>
References: <1441560187-23611-1-git-send-email-ramakrishna.pallala@intel.com>
 <CAJKOXPfDu+LxoiQrV+CsqUbEVwYb1Zmk-m9y-L_1JxrB6ouS0g@mail.gmail.com>
 <D854C92F57B1B347B57E531E78D05EAD57904B8D@BGSMSX104.gar.corp.intel.com>
 <55F0C522.6070705@samsung.com> <55F1B2FD.4020608@ti.com>
 <55F22740.4080003@samsung.com> <20150922153725.GA4235@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:28105 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757975AbbIVPp3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 22 Sep 2015 11:45:29 -0400
In-Reply-To: <20150922153725.GA4235@earth>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: "Andrew F. Davis" <afd@ti.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "Tc, Jenny" <jenny.tc@intel.com>, Andreas Dannenberg <dannenberg@ti.com>

> Hi,
> 
> On Fri, Sep 11, 2015 at 09:58:40AM +0900, Krzysztof Kozlowski wrote:
> > On 11.09.2015 01:42, Andrew F. Davis wrote:
> > > On 09/09/2015 06:47 PM, Krzysztof Kozlowski wrote:
> > >>>>> +- ti,enable-user-write: boolean, if present driver will allow
> > >>>>> +the
> > >>>>> user space
> > >>>>> +    to control the charging current and voltage through sysfs;
> > >>>>
> > >>>> This is not DT property. It does not describe hardware.
> > >>> We needed a mechanism to enable the sysfs writes on certain properties.
> > >>> If DT is not the place where should it go?
> > >>
> > >> DT is not the place. As I discussed later with Andreas, if you
> > >> really need this and if mainline is a place for that then probably
> > >> this should be compile option (a Kconfig symbol).
> > >>
> > >
> > > I think this would actually be a good use for module parameters,
> > > this way it could still be set at boot without re-compiling.
> > >
> > > I think compile-time disabling sysfs properties because they are
> > > "dangerous" is a little bit too artificially restricting and
> > > controlling, you can set permissions so only root can change them
> > > already. The kernel should not be restricting root, I understand the
> > > fear of someone rooting a machine and remotely over charging a
> > > LiPo[1], but these physical limits are hardware descriptions and can
> > > and should be set by DT, beyond this root should have full control
> > > over their machine.
> >
> >
> > Indeed module parameters could be used for enabling/disabling debug
> > options... but as fair as I understand these are for purely
> > development purposes. That is why they got into DT initially, right?
> > To allow the developer to play with it on the development board?
> >
> > This is why I am really not convinced that this should go to mainline.
> >
> > Anyway if it goes, then maybe compiling it out is the safest choice?
> > What's the purpose of having it in kernel all the time? If this was a
> > debug option, than some experienced user could turn it on and report
> > to LKML with extended debug data. But it's not a debug but development
> option?
> 
> Changing the current limit is useful for "expert" users with custom usb power
> supplies, that are not correctly detected by extcon. I also think a module
> parameter would be the best option here.

Ok. I will resubmit the patches along with fixing the other comments.

Thanks,
Ram
