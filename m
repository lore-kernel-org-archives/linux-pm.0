From: Li Yang <leoli@freescale.com>
Subject: System suspend states and device driver suspend() callback
Date: Fri, 16 Aug 2013 16:06:26 +0800
Message-ID: <CADRPPNSD+uj_t5+qbNW29y7SuJkB_vMck-DGFJFV4A0AmPC6pQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:50955 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751011Ab3HPIG3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 16 Aug 2013 04:06:29 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>

Hi Guys,

Is there a standard way for the device drivers to know if the system
is going to =E2=80=9Cstandby=E2=80=9D mode or =E2=80=9Cmem=E2=80=9D mod=
e when the suspend() callbacks
are called?

Regards,

Leo
