From: Morten Rasmussen <morten.rasmussen@arm.com>
Subject: [3/11] issue 3: No understanding of potential cpu capacity
Date: Fri, 20 Dec 2013 16:45:43 +0000
Message-ID: <1387557951-21750-4-git-send-email-morten.rasmussen@arm.com>
References: <1387557951-21750-1-git-send-email-morten.rasmussen@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:59264 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754573Ab3LTQph (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 20 Dec 2013 11:45:37 -0500
In-Reply-To: <1387557951-21750-1-git-send-email-morten.rasmussen@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: peterz@infradead.org, mingo@kernel.org
Cc: rjw@rjwysocki.net, markgross@thegnar.org, vincent.guittot@linaro.org, catalin.marinas@arm.com, morten.rasmussen@arm.com, linux-pm@vger.kernel.org

To minimize energy it may sometimes be better to put waking tasks on
partially loaded cpus instead of powering up more cpus (particularly if
it implies powering up a new cluster/group of cpus with associated
caches). To make that call, information about the potential spare cycles
on the busy cpus is required.

Currently, the CFS scheduler has no knowledge about frequency scaling.
Frequency scaling governors generally try to match the frequency to
the load, which means that the idle time has no absolute meaning. The
potential spare cpu capacity may be much higher than indicated by the
idle time if the cpu is running at a low P-state.

The energy trade-off may justify putting another task on a loaded cpu
even if it causes a change to a higher P-state to handle the extra load.
Related issues are frequency (and cpu micro architecture) invariant task
load and power topology information, which are both needed to enable the
scheduler for energy-aware task placement. This is covered in more
detail in issue 5.

The potential cpu capacity cannot be assumed to be constant as thermal
management may restrict the usage of high performance P-states
dynamically.


