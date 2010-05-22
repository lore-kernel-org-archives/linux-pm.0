From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [Regression][git head f4b87dee9] ath9k doesn't work
	correctly after resume from suspend to RAM
Date: Sat, 22 May 2010 23:53:26 +0200
Message-ID: <201005222353.26920.rjw__23378.2892617912$1274565220$gmane$org@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
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
To: linux-wireless@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@gmail.com>, "John W. Linville" <linville@tuxdriver.com>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Maciej Rutecki <maciej.rutecki@gmail.com>
List-Id: linux-pm@vger.kernel.org

Hi,

With current -git on Acer Ferrari One the ath9k driver doesn't seem to work
after resume from suspend to RAM.  NetworkManager seems to think that it works,
but it doesn't really connect with the AP and doesn't try to obtain an IP
address.  Reloading the driver makes it work again.

The 2.6.34 (final) version works flawlessly with STR.

The user space is openSUSE 11.3 Milestone 6, so it may be somewhat unstable
in general, but this particular feature does work with 2.6.34.

Thanks,
Rafael
