From: Pavel Machek <pavel@ucw.cz>
Subject: bq2415x_charger, bq27x00_battery.c: comment cleanups
Date: Wed, 11 Feb 2015 11:47:16 +0100
Message-ID: <20150211104715.GA2458@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, trivial@kernel.org
List-Id: linux-pm@vger.kernel.org


Cleanup comments  for bq2415x_charger, bq27x00_battery.c.

Signed-off-by: Pavel Machek <pavel@ucw.cz>

diff --git a/drivers/power/bq2415x_charger.c b/drivers/power/bq2415x_charger.c
index 1f49986..2a226ca 100644
--- a/drivers/power/bq2415x_charger.c
+++ b/drivers/power/bq2415x_charger.c
@@ -13,12 +13,6 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- */
-
-/*
  * Datasheets:
  * http://www.ti.com/product/bq24150
  * http://www.ti.com/product/bq24150a
@@ -173,7 +167,7 @@ struct bq2415x_device {
 	struct power_supply *notify_psy;
 	struct notifier_block nb;
 	enum bq2415x_mode reported_mode;/* mode reported by hook function */
-	enum bq2415x_mode mode;		/* current configured mode */
+	enum bq2415x_mode mode;		/* currently configured mode */
 	enum bq2415x_chip chip;
 	const char *timer_error;
 	char *model;
diff --git a/drivers/power/bq27x00_battery.c b/drivers/power/bq27x00_battery.c
index a78ac20..6be9f3c 100644
--- a/drivers/power/bq27x00_battery.c
+++ b/drivers/power/bq27x00_battery.c
@@ -16,9 +16,6 @@
  * IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
  * WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
  *
- */
-
-/*
  * Datasheets:
  * http://focus.ti.com/docs/prod/folders/print/bq27000.html
  * http://focus.ti.com/docs/prod/folders/print/bq27500.html

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
