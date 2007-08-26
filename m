From: Andreas Steffan <a.steffan@deas-online.de>
Subject: PROBLEM: Suspend corrupts bios clock since 2.6.21
Date: Sun, 26 Aug 2007 20:31:00 +0200
Message-ID: <1188153060.14603.31.camel__13066.429741639$1188156684$gmane$org@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
Cc: pavel@suse.cz, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hallo everybody,

I am running fedora core 7 on my Dell latitude D810 notebook (BIOS
rev A05).

Since 2.6.21 I found that suspending (to disk and to ram) corrupts
the bios clock most of the time (not always). The corruption is
happening during suspend. When I enter the system bios right after
I switch the system back on, I find the bios clock is set to a time
far in the future (many years). I guess that problem is related to
the clock changes that where introduced with 2.6.21.

Please let me know if you want me to provide further information to
get this problem fixed.

If there is a known quirk to work around this problem, I would
really appreciate a hint.

PS: I have not yet tried 2.6.22.4-65.fc7, but the latest 2.6.22 kernel
before showed the same behaviour for me.
--
regards 
Andreas

+-----------------------------------------------------------+
Andreas Steffan              email: a.steffan@deas-online.de
Hamburg, Germany             mobil: +49179 3903615
+-----------------------------------------------------------+

In theory, practice and theory are the same, but in practice
they are different -- Larry McVoy
