From: ahaslam@baylibre.com
Subject: genpd multiple states v2
Date: Wed,  8 Apr 2015 17:42:03 +0200
Message-ID: <1428507725-12205-1-git-send-email-ahaslam@baylibre.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:37272 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752822AbbDHPmQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 8 Apr 2015 11:42:16 -0400
Received: by wiaa2 with SMTP id a2so63810948wia.0
        for <linux-pm@vger.kernel.org>; Wed, 08 Apr 2015 08:42:14 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: khilman@linaro.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org
Cc: bcousson@baylibre.com

Here is v2 of the multiple states patch for genpd.
The changes from v1 are:

        - split the changes so that the actual logic that
          selects the target state is a separate patch.

        - move the cached logic out of the state function and add
         it back to default_power_down_ok were it belongs.

        - use static arrays instead of dynamic for state declaration
	  since its not expected to have lots of intermediate states.
          That way we don't have to mess with allocations.

        - rename default_power_down_ok_state to power_down_ok_for_state

