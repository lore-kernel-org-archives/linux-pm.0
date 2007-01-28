From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [PATCH 2/2] PM: fast power off - driver
Date: Sun, 28 Jan 2007 10:09:56 -0800
Message-ID: <20070128100956.77509585.randy.dunlap@oracle.com>
References: <45BBB09C.7020509@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <45BBB09C.7020509@mvista.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: akuster <akuster@mvista.com>, linux-pm@lists.osdl.org
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Sat, 27 Jan 2007 10:05:48 -1000 akuster wrote:

> My apologies, I cc'd the wrong list the first time around.


+config FAST_POWER_DOWN
+	tristate "Fast power of profile"
---------------------------> off
	What does that mean?  especially the "profile" part?

+	depends on FAST_POWER_OFF


+	printk(KERN_INFO "PM: Fastpoweroff, %s profile added\n",fpo_default.name);

Space after "," please.


OK, let me see if I understand fsd_default_off().

+static int fsd_default_off(void)
+{
+	/*
+	 * Actions taken:
+	 *
+	 *    1. Freeze all user processes.
+	 *
+	 *    2. Power off
+	 *
+	 *    3. Power off devices
+	 */
+
+	printk(KERN_EMERG "Fast Power Off initiated.\n");
+	fastpoweroff_prepare();
+	fastpoweroff();
+	fastpoweroff_standby();
+	return 1;
+}

Does this say (2) power off the system and then (3) power off devices?
How does it power off devices after calling fastpoweroff()?
Or is fastpoweroff() only setting the stage for something to
happen later?

Thanks,
---
~Randy
