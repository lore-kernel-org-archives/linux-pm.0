From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH -mm 0/2] PM: Hibernation and suspend
	notifiers (rev. 2)
Date: Sat, 2 Jun 2007 02:41:52 +0200
Message-ID: <200706020241.53788.rjw__34358.5159782835$1180744837$gmane$org@sisk.pl>
References: <200705272229.21263.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200705272229.21263.rjw@sisk.pl>
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
To: pm list <linux-pm@lists.linux-foundation.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

Hi,

This is the second revision of the patches that introduce hibernation and
suspend notifiers.

Generally, I have followed the Alan's suggestion to use a blocking notifier
chain and the Pavel's suggestion to limit the number of events.  Also, I've
dropped the patch to disable the requesting of firmware.

Comments welcome.

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
