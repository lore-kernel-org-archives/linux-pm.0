From: Jan-Simon =?ISO-8859-1?Q?M=F6ller?= <dl9pf@gmx.de>
Subject: [RFC]: [PATCH] Export cpuidle_(un)register_governor
Date: Wed, 04 Jan 2012 18:48:57 +0100
Message-ID: <7458223.HLZRiFjcWF@frodo.auenland.lan>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="nextPart2216296.rIusqo1e7B"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
Cc: Arjan van de Ven <arjan@linux.intel.com>
List-Id: linux-pm@vger.kernel.org


--nextPart2216296.rIusqo1e7B
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi all! 

This patch exports cpuidle_register_governor and cpuidle_unregister_governor 
with EXPORT_SYMBOL_GPL (as the other cpuidle_(un)register_* ). 

Reasoning: allow runtime loading of a cpuidle governor (mainly for 
development for now). 

Usually we don't need this as we're using built-ins for the governors - but 
during development it is really handy to load and unload a cpuidle governor 
(together with the cpuidle_sysfs_switch). 

Comments ? 

Best, 
Jan-Simon

--nextPart2216296.rIusqo1e7B
Content-Disposition: attachment; filename="0001-Export-cpuidle_register_governor-and-cpuidle_unregis.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="utf-8"; name="0001-Export-cpuidle_register_governor-and-cpuidle_unregis.patch"

>From a21a054fa64f898576ee62fced30508e0affe243 Mon Sep 17 00:00:00 2001

From: =?UTF-8?q?Jan-Simon=20M=C3=B6ller?= <jansimon.moeller@gmx.de>

Date: Mon, 12 Dec 2011 14:40:56 +0100

Subject: [PATCH] Export cpuidle_register_governor and

 cpuidle_unregister_governor with EXPORT_SYMBOL_GPL (as the

 other cpuidle_(un)register_* ).



Reasoning: allow runtime loading of a cpuidle governor (mainly for

development for now).

---

 drivers/cpuidle/governor.c |    3 +++

 1 files changed, 3 insertions(+), 0 deletions(-)



diff --git a/drivers/cpuidle/governor.c b/drivers/cpuidle/governor.c

index ea2f8e7..552f5a4 100644

--- a/drivers/cpuidle/governor.c

+++ b/drivers/cpuidle/governor.c

@@ -97,6 +97,8 @@ int cpuidle_register_governor(struct cpuidle_governor *gov)

 	return ret;

 }

 

+EXPORT_SYMBOL_GPL(cpuidle_register_governor);

+

 /**

  * cpuidle_replace_governor - find a replacement governor

  * @exclude_rating: the rating that will be skipped while looking for

@@ -139,3 +141,4 @@ void cpuidle_unregister_governor(struct cpuidle_governor *gov)

 	mutex_unlock(&cpuidle_lock);

 }

 

+EXPORT_SYMBOL_GPL(cpuidle_unregister_governor);

-- 

1.7.7


--nextPart2216296.rIusqo1e7B
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--nextPart2216296.rIusqo1e7B--
