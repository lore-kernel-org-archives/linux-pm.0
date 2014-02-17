From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: [PATCH 0/2] remove newly introduced calls to cpuidle_idle_call()
Date: Mon, 17 Feb 2014 10:59:28 -0500
Message-ID: <1392652770-19397-1-git-send-email-nicolas.pitre@linaro.org>
Content-Transfer-Encoding: 7BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:50032 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751445AbaBQQAQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 17 Feb 2014 11:00:16 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Cc: Paul Burton <paul.burton@imgtec.com>, Deepthi Dharwar <deepthi@linux.vnet.ibm.com>, Preeti U Murthy <preeti@linux.vnet.ibm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org

Peter/Ingo: Those should probably go into tip as soon as possible
to follow what I already sent earlier.  These are new references to
cpuidle_idle_call that were introduced since -rc1.
 

