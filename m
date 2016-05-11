From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 0/3] power: Remove the deprecated extcon functions
Date: Wed, 11 May 2016 08:47:06 -0500
Message-ID: <20160511134706.GA8753@rob-hp-laptop>
References: <1461232535-3959-1-git-send-email-cw00.choi@samsung.com>
 <57313162.20208@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:44813 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932215AbcEKNrM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 11 May 2016 09:47:12 -0400
Content-Disposition: inline
In-Reply-To: <57313162.20208@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org

On Tue, May 10, 2016 at 09:54:58AM +0900, Chanwoo Choi wrote:
> Ping.
>=20
> Could you review this patch?

I already did. The first problem is you are breaking compatibility here=
=20
(a kernel with these changes won't work with a dtb without these=20
changes). As I previously said, this binding in general is horribly=20
designed and full on Linux driver specifics. The first clue is your=20
driver changes are resulting in DT changes. If you are going to break=20
compatibility here, it better be redoing this binding. The problems I=20
see with this binding are:

- Linux device name strings
- "charger-manager" is not a chip or circuit. DT describes the h/w.
- Current limits by type of USB connection are pointless. These are par=
t=20
of the spec.
- Properties need standard unit suffixes.
- A mixture of battery and charger properties.

Rob

>=20
> Thanks,
> Chanwoo Choi
>=20
> On 2016=EB=85=84 04=EC=9B=94 21=EC=9D=BC 18:55, Chanwoo Choi wrote:
> > This patch-set removes the deprecated notifier API of extcon framew=
ork and
> > then use the new extcon API[2] with the unique id[1] to indicate th=
e each
> > external connector. Alter deprecated API as following:
> > - extcon_register_interest() -> extcon_register_notifier()
> > - extcon_unregister_interest() -> extcon_unregister_notifier()
> > - extcon_set_cable_state() -> extcon_set_cable_state_()
> > - extcon_get_cable_state() -> extcon_get_cable_state_()
> >=20
> > And, extcon alters the name of USB charger connector in patch[3] as=
 following:
> > - EXTCON_CHG_USB_SDP /* Standard Downstream Port */
> > - EXTCON_CHG_USB_DCP /* Dedicated Charging Port */
> > - EXTCON_CHG_USB_CDP /* Charging Downstream Port */
> > - EXTCON_CHG_USB_ACA /* Accessory Charger Adapter */
> >=20
> > [1] Commit 2a9de9c0f08d61
> > - ("extcon: Use the unique id for external connector instead of str=
ing)
> > [2] Commit 046050f6e623e4
> > - ("extcon: Update the prototype of extcon_register_notifier() with=
 enum extcon
> > [3] Commit 11eecf910bd81d
> > - ("extcon: Modify the id and name of external connector")
> >=20
> > Changes from v1:
> > - Fix the typo (EXTCON_CHG_USB_SDP -> EXTCON_CHG_USB_CDP) on axp288=
_charger.c
> >=20
> > Chanwoo Choi (3):
> >   power: charger-manager: Replace deprecatd API of extcon
> >   power: axp288_charger: Replace deprecatd API of extcon
> >   extcon: Remove the deprecated extcon functions
> >=20
> >  .../bindings/power_supply/charger-manager.txt      |   4 +-
> >  drivers/extcon/extcon.c                            | 201 +++------=
------------
> >  drivers/power/axp288_charger.c                     |  77 +++++---
> >  drivers/power/charger-manager.c                    |  31 ++--
> >  include/linux/extcon.h                             |  59 ------
> >  include/linux/power/charger-manager.h              |   4 +-
> >  6 files changed, 101 insertions(+), 275 deletions(-)
> >=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
