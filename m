From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 1/4] thermal: of: add __init attribute
Date: Tue, 19 Apr 2016 14:33:32 +0200
Message-ID: <1461069215-22795-2-git-send-email-Julia.Lawall@lip6.fr>
References: <1461069215-22795-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <1461069215-22795-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: kernel-janitors-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: kernel-janitors@vger.kernel.org, Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "Luis R . Rodriguez" <mcgrof@kernel.org>, Josh Triplett <josh@joshtriplett.org>
List-Id: linux-pm@vger.kernel.org

Add __init attribute on a function that is only called from other __init
functions and that is not inlined, at least with gcc version 4.8.4 on an
x86 machine with allyesconfig.  Currently, the function is put in the
.text.unlikely segment.  Declaring it as __init will cause it to be put in
the .init.text and to disappear after initialization.

The result of objdump -x on the function before the change is as follows:

0000000000000086 l     F .text.unlikely 0000000000000739 thermal_of_build_thermal_zone

And after the change it is as follows:

0000000000000000 l     F .init.text	0000000000000734 thermal_of_build_thermal_zone

Done with the help of Coccinelle.  The semantic patch checks for local
static non-init functions that are called from an __init function and are
not called from any other function.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/thermal/of-thermal.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
index 8528802..b8e509c 100644
--- a/drivers/thermal/of-thermal.c
+++ b/drivers/thermal/of-thermal.c
@@ -811,8 +811,8 @@ static int thermal_of_populate_trip(struct device_node *np,
  * otherwise, it returns a corresponding ERR_PTR(). Caller must
  * check the return value with help of IS_ERR() helper.
  */
-static struct __thermal_zone *
-thermal_of_build_thermal_zone(struct device_node *np)
+static struct __thermal_zone
+__init *thermal_of_build_thermal_zone(struct device_node *np)
 {
 	struct device_node *child = NULL, *gchild;
 	struct __thermal_zone *tz;

