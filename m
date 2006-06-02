From: "Yu, Luming" <luming.yu@intel.com>
Subject: RE: [linux-pm] ACPI problem with ACER Aspire 3003LC laptop.
Date: Fri, 2 Jun 2006 20:10:58 +0800
Message-ID: <554C5F4C5BA7384EB2B412FD46A3BAD11206EE@pdsmsx411.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
To: rasmit.ranjan@wipro.com, linux-pm@osdl.org
Cc: linux-acpi@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Does latest base kernel work?
If NOT, please file a bug on bugzilla.kernel.org


Thanks
Luming=20

________________________________

	From: linux-pm-bounces@lists.osdl.org [mailto:linux-pm-bounces@lists.o=
sdl.org] On Behalf Of rasmit.ranjan@wipro.com
	Sent: 2006=C4=EA6=D4=C22=C8=D5 12:27
	To: linux-pm@osdl.org
	Subject: [linux-pm] ACPI problem with ACER Aspire 3003LC laptop.
=09
=09
	Hi all,
	    I am using ACER Aspire 3003LC laptop for developing a Host control=
ler driver for kernel version 2.6.15.4.
	If i enable Power management support then my ethernet interface doesno=
t work. Also i get the message: " Disabling IRQ#3"
	This message comes from the kernel. And also i get following messages =
from ACPI:
	=20
	    ACPI-0508: *** Error: Method execution failed[\_SB_.BAT1._BST] (No=
de cbd80560), AE_NOT_FOUND
	    ACPI-0339: *** Error: Looking uo[Z007] in namespace, AE_NOT_FOUND
	=20
	I recompiled my kernel without power management support. Now my ethern=
et is working properly and obviously i don`t get any message from ACPI.=
 This is the problem with the laptop. But I need Power management suppo=
rt. so is there any patch available for this ? Please suggest.
	=20
	Thanks and regards,
	Rasmit.
	=20
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
