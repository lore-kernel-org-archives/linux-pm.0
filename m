From: "Ong, Boon Leong" <boon.leong.ong@intel.com>
Subject: RE: [PATCH] thermal: intel Quark SoC X1000 DTS thermal driver
Date: Mon, 23 Feb 2015 08:19:39 +0000
Message-ID: <AF233D1473C1364ABD51D28909A1B1B732757065@PGSMSX105.gar.corp.intel.com>
References: <1423673509-11195-1-git-send-email-boon.leong.ong@intel.com>
 <1423673509-11195-2-git-send-email-boon.leong.ong@intel.com>
 <AF233D1473C1364ABD51D28909A1B1B73274624E@PGSMSX105.gar.corp.intel.com>
 <F54AEECA5E2B9541821D670476DAE19C2B8AB1FC@PGSMSX102.gar.corp.intel.com>
 <AF233D1473C1364ABD51D28909A1B1B732756CCF@PGSMSX105.gar.corp.intel.com>
 <F54AEECA5E2B9541821D670476DAE19C2B8AC650@PGSMSX102.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:42473 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751296AbbBWITo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 23 Feb 2015 03:19:44 -0500
In-Reply-To: <F54AEECA5E2B9541821D670476DAE19C2B8AC650@PGSMSX102.gar.corp.intel.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Kweh, Hock Leong" <hock.leong.kweh@intel.com>, "Zhang, Rui" <rui.zhang@intel.com>, "edubezval@gmail.com" <edubezval@gmail.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Bryan O'Donoghue <pure.logic@nexus-software.ie>



>-----Original Message-----
>From: Kweh, Hock Leong
>Sent: Monday, February 23, 2015 3:39 PM
>To: Ong, Boon Leong; Zhang, Rui; edubezval@gmail.com
>Cc: linux-pm@vger.kernel.org; LKML; Bryan O'Donoghue
>Subject: RE: [PATCH] thermal: intel Quark SoC X1000 DTS thermal driver
>
>> -----Original Message-----
>> From: Ong, Boon Leong
>> Sent: Monday, February 23, 2015 9:39 AM
>> Subject: RE: [PATCH] thermal: intel Quark SoC X1000 DTS thermal driv=
er
>>
>> >Just to bring out for discussion, do you think we should put a "saf=
ety range"
>> >for reporting out the critical trip temperature value (mean the val=
ue from
>> >register minus 1 or 2 degree)?
>> >
>> >Just wondering if this is needed for the software to have the suffi=
cient
>> >shutdown time before the HW make a hard power cut off when the
>> >critical trip point is reached.
>>
>> I assume that the suggestion is meant for the case where thermal reg=
ister is
>> not locked by BIOS. It is not a bad idea to have some protection aga=
inst
>> wrong configuration on critical trip point by user.
>> Looking through the data-sheet in Quark, I could not find an recomme=
nded
>> temperature. So, I propose that we use the same value set by BIOS to=
day
>> - 105C as the maximum.
>
>What I mean here is that even the BIOS locks it and used the maximum v=
alue
>105 =B0C for the critical trip point, should we -1 or -2 (104/103 =B0C=
) in this driver
>to let the system shut down before the actual trip point hit, in case =
the HW
>performs a HW power cut off before the Linux kernel has enough time to
>shut down properly?
>

The shut-down is triggered by thermal management framework by comparing
current DTS temperature against the value set on trip point. I don't th=
ink the=20
framework allows thermal driver to trigger system shutdown proactively =
several
degree Celsius before the set critical trip point.

So, IMO, we just need an upper-bound for critical trip point to prevent=
 user
for setting unreasonably trip point value that is too high and cause th=
e chip
to be fried before thermal management framework can start shutdown.=20
As current BIOS selects 105C as the max, I think that this is a reasona=
ble to use
here.


