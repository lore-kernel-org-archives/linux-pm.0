From: Morten Rasmussen <morten.rasmussen@arm.com>
Subject: [0/11][REPOST] Energy-aware scheduling use-cases and scheduler issues
Date: Tue,  7 Jan 2014 16:19:36 +0000
Message-ID: <1389111587-5923-1-git-send-email-morten.rasmussen@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:45252 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752033AbaAGQTv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 7 Jan 2014 11:19:51 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: peterz@infradead.org, mingo@kernel.org
Cc: rjw@rjwysocki.net, markgross@thegnar.org, vincent.guittot@linaro.org, catalin.marinas@arm.com, morten.rasmussen@arm.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Reposting the series with LKML on cc as well.

Original thread (with a few replies) can be found here:
http://article.gmane.org/gmane.linux.power-management.general/41501

Sorry for double-posting.

Morten

------------------------------------------------------------------------

Hi,

One of the requests from the scheduler maintainers at the Energy-aware
Scheduling workshop at Kernel Summit this year was to provide plain text
descriptions of use-cases (workloads) and system topologies. To get that
moving I have written some short texts about some use-cases. In addition
I described a list of issues that today prevent mainly the scheduler
from achieving a good energy/performance balance in common use-cases.
The follow-up emails are structured as follows:

1-6:=09Current issues related to energy/performance balance.
7-10:=09Use-cases (overall behaviour and energy/performance goals)
11:=09DVFS example (for reference)

I'm hoping that this provides some of the background for why I'm
interested in improving energy-awareness in the scheduler. I'm aware
that the use-cases and issues/wishlist don't cover everyone's area of
interest. Input is needed to fix that.

Comments and input are appreciated.

Morten

