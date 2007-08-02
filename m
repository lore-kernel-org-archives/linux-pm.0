From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Re: Hibernation considerations
Date: Thu, 2 Aug 2007 10:02:27 -0700
Message-ID: <200708021902.28379.rjw__3903.33502223275$1186120288$gmane$org@sisk.pl>
References: <Pine.LNX.4.64.0707171319140.2467@asgard.lang.hm>
	<200707212120.04645.rjw@sisk.pl> <20070801092227.GB4808@ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C7D52A.600A9F00"
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-class: urn:content-classes:message
In-Reply-To: <20070801092227.GB4808@ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: david@lang.hm, nigel@nigel.suspend2.net, Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org, miltonm@bga.com, "Huang,
	Ying" <ying.huang@intel.com>, linux-pm@lists.linux-foundation.org, jbms@cmu.edu
List-Id: linux-pm@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C7D52A.600A9F00
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Wednesday, 1 August 2007 11:22, Pavel Machek wrote:
> Hi!
>=20
> > > Hmm, wonder why this isn't affecting people with VPNs?  Probably
> > > network mounts over VPN are rare, and ever rarer to have fs =
activity
> > > on them during suspend.
> > >=20
> > > Anyway, I think it's long overdue to stop thinking about how to =
"fix"
> > > fuse, and concentrate on fixing the underlying problem instead ;)
> >=20
> > To conclude this branch of the thread, I have a patch in the works =
that may
> > help a bit with unfreezable FUSE filesystems and it only affects the =
freezer.
> > I'll post it when 2.6.23-rc1 is out, because it's on top of some =
other patches
> > that need to go first.
>=20
> I'm interested... which one is that?

Appended, on top of this:
https://lists.linux-foundation.org/pipermail/linux-pm/2007-July/014521.ht=
ml

Greetings,
Rafael


---
 kernel/power/process.c |   49 =
++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 48 insertions(+), 1 deletion(-)

Index: linux-2.6.23-rc1/kernel/power/process.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.23-rc1.orig/kernel/power/process.c	2007-07-24 =
00:14:07.000000000 +0200
+++ linux-2.6.23-rc1/kernel/power/process.c	2007-07-24 =
00:14:17.000000000 +0200
@@ -30,6 +30,14 @@
  */
 #define MAX_WAITS 5
=20
+/*
+ * If the freezing of tasks fails, we attempt to thaw tasks that have =
already
+ * been frozen to give a chance the other tasks to freeze, in case one =
or more
+ * of them are blocked by the frozen ones.  If this fails MAX_ATTEMPTS =
times
+ * in a row, we give up.
+ */
+#define MAX_ATTEMPTS 10
+
 #define FREEZER_KERNEL_THREADS 0
 #define FREEZER_USER_SPACE 1
=20
@@ -192,14 +200,21 @@ static void cancel_freezing(struct task_
 static int try_to_freeze_tasks(int freeze_user_space)
 {
 	struct task_struct *g, *p;
-	unsigned int todo, waits;
+	unsigned int todo, waits, attempts;
 	unsigned long ret;
 	struct timeval start, end;
 	s64 elapsed_csecs64;
 	unsigned int elapsed_csecs;
+	char *tick =3D "-\\|/";
+
+	printk(" ");
+	attempts =3D 0;
=20
 	do_gettimeofday(&start);
=20
+ Repeat:
+	printk("\b%c", tick[attempts++ % 4]);
+
 	refrigerator_called =3D 0;
 	waits =3D 0;
 	do {
@@ -235,11 +250,43 @@ static int try_to_freeze_tasks(int freez
 		}
 	} while (todo);
=20
+	if (todo && attempts <=3D MAX_ATTEMPTS) {
+		/*
+		 * Some tasks have not been able to freeze.  They might be stuck
+		 * in TASK_UNINTERRUPTIBLE waiting for the frozen tasks.  Try to
+		 * thaw the tasks that have frozen without clearing the freeze
+		 * requests of the remaining tasks and repeat.
+		 */
+		read_lock(&tasklist_lock);
+		do_each_thread(g, p) {
+			if (frozen(p)) {
+				p->flags &=3D ~PF_FROZEN;
+				wake_up_process(p);
+			}
+		} while_each_thread(g, p);
+		read_unlock(&tasklist_lock);
+
+		ret =3D wait_event_timeout(refrigerator_waitq,
+						refrigerator_called, TIMEOUT);
+		if (!ret) {
+			/*
+			 * There is a little hope that we will succeed, but at
+			 * least we want to know which tasks have not been
+			 * frozen.  Thus, we are going to repeat once.
+			 */
+			attempts =3D MAX_ATTEMPTS;
+		}
+
+		goto Repeat;
+	}
+
 	do_gettimeofday(&end);
 	elapsed_csecs64 =3D timeval_to_ns(&end) - timeval_to_ns(&start);
 	do_div(elapsed_csecs64, NSEC_PER_SEC / 100);
 	elapsed_csecs =3D elapsed_csecs64;
=20
+	printk("\b");
+
 	if (todo) {
 		/* This does not unfreeze processes that are already frozen
 		 * (we have slightly ugly calling convention in that respect,
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

------_=_NextPart_001_01C7D52A.600A9F00
Content-Type: application/ms-tnef;
	name="winmail.dat"
Content-Transfer-Encoding: base64

eJ8+IjgRAQaQCAAEAAAAAAABAAEAAQeQBgAIAAAA5AQAAAAAAADoAAEIgAcAGAAAAElQTS5NaWNy
b3NvZnQgTWFpbC5Ob3RlADEIAQ2ABAACAAAAAgACAAEEgAEALgAAAFJlOiBbbGludXgtcG1dIFJl
OiBIaWJlcm5hdGlvbiBjb25zaWRlcmF0aW9ucwCsEAEFgAMADgAAANcHCAACAAoAAgAbAAQAEwEB
IIADAA4AAADXBwgAAgAKABwAMwAEAEUBAQmAAQAhAAAAREY4NzI2RkI1MzI4RjU0MThGMEFGQTNG
RTZEMDhDRkYAgAcBA5AGAFQSAAAxAAAAAwA2AAAAAABAADkAgBNW5ybVxwEeAD0AAQAAAAUAAABS
ZTogAAAAAB4AcAABAAAAKgAAAFtsaW51eC1wbV0gUmU6IEhpYmVybmF0aW9uIGNvbnNpZGVyYXRp
b25zAAAAAgFxAAEAAAAWAAAAAcfVKmAoSCZbaPVtQje6dfOnYc13rAAAHgAaDAEAAAAjAAAAbGlu
dXgta2VybmVsLW93bmVyQHZnZXIua2VybmVsLm9yZwAAHgAdDgEAAAAqAAAAW2xpbnV4LXBtXSBS
ZTogSGliZXJuYXRpb24gY29uc2lkZXJhdGlvbnMAAAACAQkQAQAAAK4JAACqCQAAURMAAExaRnV3
hi0xAwAKAHJjcGcxMjXiMgNDdGV4BUEBAwH3/wqAAqQD5AcTAoAP8wBQBFY/CFUHshElDlEDAQIA
Y2jhCsBzZXQyBgAGwxEl9jMERhO3MBIsETMI7wn3tjsYHw4wNREiDGBjAFAzCwkBZDM2FlALpiBP
FQOgVwmAbgeQZGF5CCwgMRDAdWd1cxMFQAHQMDcdwDE6MkIyHbBQYXZlAyBNwQDQaGVrIHcDYA6w
BjoKogqAPiBIaSFHIFYgViHiSG1tHbB3BwIgBIEf4Gh5IHRopQQAIAQAbicFQGEBIAUFkHQLgGcg
cGVvFQtQZR/gaSNAIFZQsE5zPyAfEANgYgGgrGx5IYodUHQikHIf0O0EYHUCMAQgbx9ABcAlUXMj
4BggIHIogR2wAHBkHCBlKAIowgXAdG8guxPgH0AgA9Aj4CQxdiUQhyY7AiAjMWVtIGQIcd0kYXMe
ICSQIrAuIYohilBBbnl3HZJJIzJu+x/QJRAnBCAXsCRhJ/IsgP8k4CoRHjAksC+EJFIBoAhgGQVA
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
xf//tyqwqaX5xxb9uP6rzpFF4f+gcIeQzPM/pT0AWkUo0T2D34XSfvWARScvepEofMHMs85zUWDP
EUIBdWdCAbuS/zayNKH18lKRPKQ9oUxxUzAfQnBW5Vj1OVGh0XVic/5ja7DPUYcBN1A6E1FiYtDf
RrBBgTYCUcE9ACIxylHE33GEsICPcHbkPOJix2BCEHc60TwwibFz6KDNw1NgaqeEQKBwhHBAdrsR
LnGE+1LCduRNhIE4GKuB0xAEAa9a8FDiUTE4zS84Jy07Aj1VSVAFwtvy44BCo0ZBqlE7SndAgC7P
kHhSwyxsa1Vwd3V9QgAAAB4ANRABAAAAIQAAADwyMDA3MDgwMjE5MDIuMjgzNzkucmp3QHNpc2su
cGw+AAAAAB4AORABAAAAcgAAADxQaW5lLkxOWC40LjY0LjA3MDcxNzEzMTkxNDAuMjQ2N0Bhc2dh
cmQubGFuZy5obT4gPDIwMDcwNzIxMjEyMC4wNDY0NS5yandAc2lzay5wbD4gPDIwMDcwODAxMDky
MjI3LkdCNDgwOEB1Y3cuY3o+AAAAHgBCEAEAAAAfAAAAPDIwMDcwODAxMDkyMjI3LkdCNDgwOEB1
Y3cuY3o+AAALAPIQAAAAAB8A8xABAAAAbAAAAFIAZQAlADMAQQAgAFsAbABpAG4AdQB4AC0AcABt
AF0AIABSAGUAJQAzAEEAIABIAGkAYgBlAHIAbgBhAHQAaQBvAG4AIABjAG8AbgBzAGkAZABlAHIA
YQB0AGkAbwBuAHMALgBFAE0ATAAAAAsA9BAAAAAACwD1EAAAAAALAPYQAAAAAEAABzDhSihgKtXH
AUAACDCP79KXKtXHAQMA3j+vbwAAAwDfP/////8DAPE/AAAAAB4A+D8BAAAAFQAAAFN5c3RlbSBB
ZG1pbmlzdHJhdG9yAAAAAAIB+T8BAAAAHgAAAAAAAADcp0DIwEIQGrS5CAArL+GCAQAAAAAAAAAu
AAAAHgD6PwEAAAAVAAAAU3lzdGVtIEFkbWluaXN0cmF0b3IAAAAAAgH7PwEAAAAeAAAAAAAAANyn
QMjAQhAatLkIACsv4YIBAAAAAAAAAC4AAAADAP0/5AQAAAMAGUAAAAEAAwAaQAAAAQAeADBAAQAA
ACMAAABsaW51eC1rZXJuZWwtb3duZXJAdmdlci5rZXJuZWwub3JnAAAeADFAAQAAAAwAAAByandA
c2lzay5wbAAeADhAAQAAAAIAAAAuAAAAHgA5QAEAAAACAAAALgAAAB4AfICGAwIAAAAAAMAAAAAA
AABGAQAAABgAAAByAGUAdAB1AHIAbgAtAHAAYQB0AGgAAAABAAAATgAAADxsaW51eC1rZXJuZWwt
b3duZXIraW1hZC5zb3Vzb3U9NDBpbnRlbC5jb20tUzE3NTgxNDJBYlhIQlF4NkB2Z2VyLmtlcm5l
bC5vcmc+AAAAHgBsg4YDAgAAAAAAwAAAAAAAAEYBAAAALAAAAHgALQBvAHIAaQBnAGkAbgBhAGwA
YQByAHIAaQB2AGEAbAB0AGkAbQBlAAAAAQAAAD0AAAAwMiBBdWcgMjAwNyAxNzoyNzoxOC4wMTMx
IChVVEMpIEZJTEVUSU1FPVs2MDFFOUMzMDowMUM3RDUyQV0AAAAAHgB5g4YDAgAAAAAAwAAAAAAA
AEYBAAAAHAAAAHgALQBpAHIAbwBuAHAAbwByAHQALQBhAHYAAAABAAAAQAAAAEU9U29waG9zO2k9
IjQuMTksMjE0LDExODMzNTk2MDAiOyAgICBkPSJzY2FuJzIwOCI7YT0iMjc1MzI0MzM4IgAeAHqD
hgMCAAAAAADAAAAAAAAARgEAAAAgAAAAeAAtAHYAaQByAHUAcwAtAHMAYwBhAG4AbgBlAGQAAAAB
AAAANAAAAGFtYXZpc2QtbmV3IGF0IG9ncmUuc2lzay5wbCB1c2luZyBNa1NfVmlyIGZvciBMaW51
eAAeAHyDhgMCAAAAAADAAAAAAAAARgEAAAA8AAAAeAAtAGkAcgBvAG4AcABvAHIAdAAtAGEAbgB0
AGkALQBzAHAAYQBtAC0AZgBpAGwAdABlAHIAZQBkAAAAAQAAAAUAAAB0cnVlAAAAAB4AfYOGAwIA
AAAAAMAAAAAAAABGAQAAADgAAAB4AC0AaQByAG8AbgBwAG8AcgB0AC0AYQBuAHQAaQAtAHMAcABh
AG0ALQByAGUAcwB1AGwAdAAAAAEAAAArAAAAQWdBQUFBK3dzVWJSaExDbm4yZHNiMkpoYkFDT0V3
RUJBZ2NFQmdjSUdBAAAeABGGhgMCAAAAAADAAAAAAAAARgEAAAAWAAAAdQBzAGUAcgAtAGEAZwBl
AG4AdAAAAAAAAQAAAAwAAABLTWFpbC8xLjkuNQAeAJqIhgMCAAAAAADAAAAAAAAARgEAAAAeAAAA
eAAtAG0AYQBpAGwAaQBuAGcALQBsAGkAcwB0AAAAAAABAAAAHQAAAGxpbnV4LWtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmcAAAAAHgA9lIYDAgAAAAAAwAAAAAAAAEYBAAAANAAAAHgALQBzAGcALQBiAGEA
ZABhAHQAdABhAGMAaABtAGUAbgB0AG4AbwByAGUAcABsAHkAAAABAAAABQAAAFRydWUAAAAACwAp
AAAAAAALACMAAAAAAAMABhCXO6V+AwAHECALAAADABAQAAAAAAMAERAAAAAAHgAIEAEAAABlAAAA
T05XRURORVNEQVksMUFVR1VTVDIwMDcxMToyMixQQVZFTE1BQ0hFS1dST1RFOkhJSE1NLFdPTkRF
UldIWVRISVNJU05UQUZGRUNUSU5HUEVPUExFV0lUSFZQTlM/UFJPQkFCTAAAAAACAX8AAQAAACEA
AAA8MjAwNzA4MDIxOTAyLjI4Mzc5LnJqd0BzaXNrLnBsPgAAAAAPiw==

------_=_NextPart_001_01C7D52A.600A9F00
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------_=_NextPart_001_01C7D52A.600A9F00--
