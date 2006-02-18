From: Patrick Mochel <mochel@digitalimplant.org>
Subject: [PATCH 2/5] [pm] Add state field to pm_message_t (to
 hold actual state device is in)
Date: Fri, 17 Feb 2006 18:03:36 -0800 (PST)
Message-ID: <Pine.LNX.4.50.0602171757360.30811-100000@monsoon.he.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============94923493685183402=="
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
To: greg@kroah.com, torvalds@osdl.org, akpm@osdl.org
Cc: linux-pm@osdl.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

--===============94923493685183402==
Content-Type: TEXT/PLAIN; charset=US-ASCII


Signed-off-by: Patrick Mochel <mochel@linux.intel.com>

---

 include/linux/pm.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

applies-to: 1ac50ba99ca37c65bdf3643c4056c246e401c18a
63b8e7f0896ce93834ac60c15df954b1e6d45e56
diff --git a/include/linux/pm.h b/include/linux/pm.h
index 5be87ba..a7324ea 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -140,6 +140,7 @@ struct device;

 typedef struct pm_message {
 	int event;
+	u32 state;
 } pm_message_t;

 /*
---
0.99.9.GIT

--===============94923493685183402==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============94923493685183402==--
