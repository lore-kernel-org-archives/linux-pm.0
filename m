From: "Konstantin Ryabitsev via RT" <rt@kernel.org>
Subject: [k.org requests #104] Please add 2 categories
Date: Tue, 30 Oct 2012 15:24:00 +0000
Message-ID: <rt-3.8.13-793-1351610640-1281.104-7-0@kernel.org>
References: <RT-Ticket-104@kernel.org> <508F40D5.2010109@kernel.org>
Reply-To: rt@kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:51984 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932170Ab2J3PYG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 30 Oct 2012 11:24:06 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 7FC072035F
	for <linux-pm@vger.kernel.org>; Tue, 30 Oct 2012 15:24:01 +0000 (UTC)
Received: from support.int.kernel.org (unknown [172.20.0.35])
	by mail.kernel.org (Postfix) with ESMTP id 977F82035A
	for <linux-pm@vger.kernel.org>; Tue, 30 Oct 2012 15:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost [127.0.0.1])
	by support.int.kernel.org (Postfix) with ESMTP id 8A44713F29F
	for <linux-pm@vger.kernel.org>; Tue, 30 Oct 2012 15:24:00 +0000 (UTC)
In-Reply-To: <508F40D5.2010109@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
Cc: linux-pm@vger.kernel.org

On Tue Oct 30 15:10:36 2012, lenb@kernel.org wrote:
> Dear Bugzilla Admins,
>=20
> Please add 2 additional Categories under Product "Power Management":
>=20
> Run-Time-PM - Issues related to Linux Device Run Time Power
> Management.
>=20
> Thermal - Issues related to OS-visible Thermal Management, such as
> throttling.

Sure, but I'll need "default assignee" for both of these.

Speaking of default assignees, kernel-bugs.osdl.org doesn't appear to
exist any more either, so the following will need to be adjusted as wel=
l:

cpuidle             power-management_cpuidle@kernel-bugs.osdl.org=20
Hibernation/Suspend power-management_other@kernel-bugs.osdl.org =09
intel_idle          power-management_intel_idle@kernel-bugs.osdl.org =09
Other               power-management_other@kernel-bugs.osdl.org

Best,
--=20
Konstantin Ryabitsev
Systems Administrator
Linux Foundation, kernel.org
Montr=C3=A9al, Qu=C3=A9bec
