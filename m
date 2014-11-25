From: Dennis Wassenberg <dennis.wassenberg@secunet.com>
Subject: S0iX Ultra Low Power States
Date: Tue, 25 Nov 2014 13:51:37 +0100
Message-ID: <54747B59.2080503@secunet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from a.mx.secunet.com ([195.81.216.161]:54562 "EHLO a.mx.secunet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750963AbaKYMwD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 25 Nov 2014 07:52:03 -0500
Received: from localhost (alg1 [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id DB9F81A0096
	for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2014 13:51:53 +0100 (CET)
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 5l0R95RguYI2 for <linux-pm@vger.kernel.org>;
	Tue, 25 Nov 2014 13:51:45 +0100 (CET)
Received: from mail-essen-01.secunet.de (unknown [10.53.40.204])
	by a.mx.secunet.com (Postfix) with ESMTP id 588821A0092
	for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2014 13:51:45 +0100 (CET)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

Hi,

I would like to know more about the Linux power management in
correlation to the Intel S0iX Ultra Low Power States.

Systems which have a Windows 8 Logo must support Connected Standby (or
InstantGo, however it is called). One of the requirements getting this
logo is that the ACPI firmware must not provide an S3 object in the root
of the namespace. This means that Linux can not use the S3 mode.

To archive a very low power consumption Microsoft uses the Ultra Low
Power States S0i1 and S0i3. Is there a way to use these low power states
in linux for Haswell/LynxPoint or Broadwell/Skylake platforms?

I read something about these states. Such that they can be activated
automatically but there are some preconditions (e.g. certain IO devices
have to put into a low power state, graphics off, only one CPU online,
...). If I enter the S1 Low Power State (with additional
disable_nonboot_cpus) all of these preconditions should be fulfilled?!
But I can not observe that the there is a power consumption less than 1
Watt.

Thank you & Best regards,

Dennis
