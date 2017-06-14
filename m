From: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 0/3] powerpc (powernv and pseries) cpuidle driver improvmeents
Date: Wed, 14 Jun 2017 23:02:38 +1000
Message-ID: <20170614130241.19865-1-npiggin@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33913 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752476AbdFNNDB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 14 Jun 2017 09:03:01 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>, "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

These are a few small improvements that came from doing an
optimisation pass over powerpc cpu idle paths.

Michael reminded me to cc the cpuidle maintainers. I think he
will take the patches through the powerpc tree, but any suggestion
or ack or nack would be welcome.

Thanks,
Nick

Nicholas Piggin (3):
  cpuidle: powerpc: cpuidle set polling before enabling irqs
  cpuidle: powerpc: read mostly for common globals
  cpuidle: powerpc: no memory barrier after break from idle

 drivers/cpuidle/cpuidle-powernv.c | 25 +++++++++++++++++--------
 drivers/cpuidle/cpuidle-pseries.c | 22 +++++++++++++++-------
 2 files changed, 32 insertions(+), 15 deletions(-)

-- 
2.11.0
