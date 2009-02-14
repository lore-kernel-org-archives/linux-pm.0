From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 8/9] PM: Wait for console in resume
Date: Sat, 14 Feb 2009 02:06:17 +0100
Message-ID: <200902140206.18505.rjw__1462.97203978083$1234576049$gmane$org@sisk.pl>
References: <200902140157.40869.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200902140157.40869.rjw@sisk.pl>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Len Brown <lenb@kernel.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>, pm list <linux-pm@lists.linux-foundation.org>, Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Arve@smtp1.linux-foundation.org, Alan Jenkins <alan-jenkins@tuffmail.co.uk>, KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>, Johannes Weiner <hannes@cmpxchg.org>, Andrew Morton <akpm@linux-foundation.org>, Andrey Borzenkov <arvidjaar@mail.ru>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Masami Hiramatsu <mhiramat@redhat.com>
List-Id: linux-pm@vger.kernel.org

From: Arve Hj=F8nnev=E5g <arve@android.com>

Avoids later waking up to a blinking cursor if the device woke up and
returned to sleep before the console switch happened.

Signed-off-by: Brian Swetland <swetland@google.com>
Signed-off-by: Arve Hj=F8nnev=E5g <arve@android.com>
Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---

 kernel/power/console.c |    6 ++++++
 1 file changed, 6 insertions(+)

Index: linux-2.6/kernel/power/console.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.orig/kernel/power/console.c
+++ linux-2.6/kernel/power/console.c
@@ -78,6 +78,12 @@ void pm_restore_console(void)
 	}
 	set_console(orig_fgconsole);
 	release_console_sem();
+
+	if (vt_waitactive(orig_fgconsole)) {
+		pr_debug("Resume: Can't switch VCs.");
+		return;
+	}
+
 	kmsg_redirect =3D orig_kmsg;
 }
 #endif
