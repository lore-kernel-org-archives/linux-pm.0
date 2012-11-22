From: Rickard Andersson <rickard.andersson@stericsson.com>
Subject: How to use generic power domains (pm_genpd)
Date: Thu, 22 Nov 2012 15:38:13 +0100
Message-ID: <50AE38D5.3010806@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from eu1sys200aog117.obsmtp.com ([207.126.144.143]:46671 "EHLO
	eu1sys200aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752678Ab2KVTX3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 22 Nov 2012 14:23:29 -0500
Received: from zeta.dmz-ap.st.com (ns6.st.com [138.198.234.13])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 83287CD
	for <linux-pm@vger.kernel.org>; Thu, 22 Nov 2012 14:30:03 +0000 (GMT)
Received: from relay2.stm.gmessaging.net (unknown [10.230.100.18])
	by zeta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 9A12C141E
	for <linux-pm@vger.kernel.org>; Thu, 22 Nov 2012 14:38:15 +0000 (GMT)
Received: from exdcvycastm003.EQ1STM.local (alteon-source-exch [10.230.100.61])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client CN "exdcvycastm003", Issuer "exdcvycastm003" (not verified))
	by relay2.stm.gmessaging.net (Postfix) with ESMTPS id 4A1E5A807B
	for <linux-pm@vger.kernel.org>; Thu, 22 Nov 2012 15:38:09 +0100 (CET)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

Hi,

I am currently looking at genpd to see if it can be used in my case
(U8500) and I have some questions.

I want to model a powerdomain that is tied to the CPU (the CPU can not
be turned on without this power domain being on) so I would like to use
pm_genpd_attach_cpuidle(..). One problem with using this function is
that my powerdomain can be attached to several cpuidle sleep states and
genpd does not seem to handle that case? (genpd does only seem to handle
being connected to one cpuidle state.)

Another thing that I am trying to find out is if genpd works ok if a
driver in the power domain does pm_runtime_get_sync(..) in interrupt
context? When looking at pm_genpd_runtime_resume(..) it looks like the
function will never call __pm_genpd_poweron(..) in the interrupt context
case. If I understand it correctly this means that the cpuidle
connection code "genpd->cpu_data->idle_state->disabled = true" is never
executed?
Also in __pm_genpd_poweron(..) it seems non otimal from power
consumption point of view to call cpuidle_pause_and_lock(..) as soon as
the cpuidle connected power domain is turned on because
cpuidle_pause_and_lock(..) calls kick_all_cpus_sync(). This means that
all CPU's in sleep will be woken up just because another CPU enables
this power domain.

Thanks in advance
Rickard

