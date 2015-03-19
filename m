From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Disabling power management firmware decisions
Date: Thu, 19 Mar 2015 14:33:34 +0100
Message-ID: <550AD02E.2080507@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f53.google.com ([74.125.82.53]:35699 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751530AbbCSNdi (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 19 Mar 2015 09:33:38 -0400
Received: by wgdm6 with SMTP id m6so62566249wgd.2
        for <linux-pm@vger.kernel.org>; Thu, 19 Mar 2015 06:33:37 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Linux PM mailing list <linux-pm@vger.kernel.org>


Hi,

I would like to do some experiments with the x86 platform but I am=20
facing one big issue.

When I use the rapl register to measure the energy consumption with=20
turbostat and another tool written by me. I see no differences between=20
my kernel changes while using the idlestat tool, I see big differences=20
in the idle state durations with the traces.

I remember on x86 the firmware overrides all kernel decisions to do the=
=20
power management. So I assume, it is possible my changes are not=20
measurable because of that.

Is there a way to tell the firmware to stop overriding the kernel=20
decisions in order to let the kernel handle idle/dvfs on its own ?

Thanks

   -- Daniel


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

