From: Johan Hovold <johan@kernel.org>
Subject: [PATCH 1/2] PM / Runtime: fix autosuspend documentation
Date: Mon, 10 Apr 2017 13:38:24 +0200
Message-ID: <20170410113825.17399-1-johan@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:36358 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753163AbdDJLiv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Apr 2017 07:38:51 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Alan Stern <stern@rowland.harvard.edu>, Kevin Hilman <khilman@baylibre.com>, Tony Lindgren <tony@atomide.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>

Update the autosuspend documentation which claimed that the autosuspend
delay is not taken into account when using the non-autosuspend helper
functions, something which is no longer true since commit d66e6db28df3
("PM / Runtime: Respect autosuspend when idle triggers suspend").

This specifically means that drivers must now disable autosuspend before
disabling runtime pm in probe error paths and remove callbacks if
pm_runtime_put_sync was being used to suspend the device before
returning. (If an idle callback can prevent suspend,
pm_runtime_put_sync_suspend must be used instead of pm_runtime_put_sync
as before.)

Also remove the claim that the autosuspend helpers behave "just like
the non-autosuspend counterparts", something which have never really
been true as some of the latter use idle notifications.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 Documentation/power/runtime_pm.txt | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/Documentation/power/runtime_pm.txt b/Documentation/power/runtime_pm.txt
index 64546eb9a16a..56a13b865927 100644
--- a/Documentation/power/runtime_pm.txt
+++ b/Documentation/power/runtime_pm.txt
@@ -836,9 +836,8 @@ of the non-autosuspend counterparts:
 	Instead of: pm_runtime_put_sync   use: pm_runtime_put_sync_autosuspend.
 
 Drivers may also continue to use the non-autosuspend helper functions; they
-will behave normally, not taking the autosuspend delay into account.
-Similarly, if the power.use_autosuspend field isn't set then the autosuspend
-helper functions will behave just like the non-autosuspend counterparts.
+will behave normally, which means sometimes taking the autosuspend delay into
+account (see pm_runtime_idle).
 
 Under some circumstances a driver or subsystem may want to prevent a device
 from autosuspending immediately, even though the usage counter is zero and the
-- 
2.12.2
