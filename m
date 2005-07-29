From: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Subject: [PATCH] swsusp: simpler calculation of number of pages
	in PBE list
Date: Fri, 29 Jul 2005 21:46:40 +0200
Message-ID: <42EA87A0.908@stud.feec.vutbr.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090005060603090605030006"
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
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This is a multi-part message in MIME format.
--------------090005060603090605030006
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit

The function calc_nr uses an iterative algorithm to calculate the number 
of pages needed for the image and the pagedir. Exactly the same result 
can be obtained with a one-line expression.

Signed-off-by: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>

--------------090005060603090605030006
Content-Type: text/x-patch;
 name="swsusp-simpler-calc_nr.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="swsusp-simpler-calc_nr.diff"

diff -Nurp -X dontdiff.new linux-mm/kernel/power/swsusp.c linux-mm.mich/kernel/power/swsusp.c
--- linux-mm/kernel/power/swsusp.c	2005-07-28 13:57:53.000000000 +0200
+++ linux-mm.mich/kernel/power/swsusp.c	2005-07-29 21:01:46.000000000 +0200
@@ -737,18 +737,7 @@ static void copy_data_pages(void)
 
 static int calc_nr(int nr_copy)
 {
-	int extra = 0;
-	int mod = !!(nr_copy % PBES_PER_PAGE);
-	int diff = (nr_copy / PBES_PER_PAGE) + mod;
-
-	do {
-		extra += diff;
-		nr_copy += diff;
-		mod = !!(nr_copy % PBES_PER_PAGE);
-		diff = (nr_copy / PBES_PER_PAGE) + mod - extra;
-	} while (diff > 0);
-
-	return nr_copy;
+	return nr_copy + (nr_copy+PBES_PER_PAGE-2)/(PBES_PER_PAGE-1);
 }
 
 /**

--------------090005060603090605030006
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--------------090005060603090605030006--
