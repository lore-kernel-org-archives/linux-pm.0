From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH] fix documentation comment in include/linux/pm.h
Date: Fri, 6 Jan 2006 02:19:44 +0100
Message-ID: <20060106011944.GA12165@dominikbrodowski.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5957261481071261=="
Return-path: <linux-pm-bounces@lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Patrick Mochel <mochel@digitalimplant.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============5957261481071261==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This comment mentioned four states a driver [sic] can be in, but then the
list only mentions three states: ON, FREEZE and SUSPEND. Add the one state
a driver(!) is in most of the time: BROKEN.

Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>

diff --git a/include/linux/pm.h b/include/linux/pm.h
index 5be87ba..d4b4f61 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -144,6 +144,7 @@ typedef struct pm_message {
 
 /*
  * There are 4 important states driver can be in:
+ * BROKEN -- typically like ON or FREEZE, depending on the phase of the moon
  * ON     -- driver is working
  * FREEZE -- stop operations and apply whatever policy is applicable to a
  *           suspended driver of that class, freeze queues for block like IDE

--===============5957261481071261==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============5957261481071261==--
