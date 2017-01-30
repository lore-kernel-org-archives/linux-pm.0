From: Fabian Frederick <fabf@skynet.be>
Subject: [PATCH 10/14] PM / Hibernate: use atomic_dec_not_zero()
Date: Mon, 30 Jan 2017 19:48:12 +0100
Message-ID: <20170130184812.18826-1-fabf@skynet.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, Fabian Frederick <fabf@skynet.be>
List-Id: linux-pm@vger.kernel.org

instead of atomic_add_unless(value, -1, 0)

Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 kernel/power/hibernate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index b26dbc4..cfa7930 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -691,7 +691,7 @@ int hibernate(void)
 
 	lock_system_sleep();
 	/* The snapshot device should not be opened while we're running */
-	if (!atomic_add_unless(&snapshot_device_available, -1, 0)) {
+	if (!atomic_dec_not_zero(&snapshot_device_available)) {
 		error = -EBUSY;
 		goto Unlock;
 	}
@@ -866,7 +866,7 @@ static int software_resume(void)
 		goto Unlock;
 
 	/* The snapshot device should not be opened while we're running */
-	if (!atomic_add_unless(&snapshot_device_available, -1, 0)) {
+	if (!atomic_dec_not_zero(&snapshot_device_available)) {
 		error = -EBUSY;
 		swsusp_close(FMODE_READ);
 		goto Unlock;
-- 
2.9.3
