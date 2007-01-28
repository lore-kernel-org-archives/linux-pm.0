From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [PATCH 1/2] PM: fast power off - core
Date: Sun, 28 Jan 2007 10:09:42 -0800
Message-ID: <20070128100942.edb5f7e1.randy.dunlap@oracle.com>
References: <45BBB097.1090207@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <45BBB097.1090207@mvista.com>
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
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sat, 27 Jan 2007 10:05:43 -1000 akuster wrote:

> My apologies, I cc'd the wrong list the first time around.

{argh, attachments}

--- linux-2.6_dev.orig/kernel/power/Kconfig
+++ linux-2.6_dev/kernel/power/Kconfig
@@ -131,3 +131,5 @@ config SUSPEND_SMP
 	bool
 	depends on HOTPLUG_CPU && X86 && PM
 	default y
+
+source "kernel/power/fastoff/Kconfig"
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Why a separate, new Kconfig file?
We shouldn't add a new Kconfig file for every new 1-2 kconfig symbols.


---
~Randy
