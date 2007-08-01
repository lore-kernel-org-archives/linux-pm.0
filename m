From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH -mm 0/3] Freezer: Use wait queue instead of busy
	looping
Date: Wed, 1 Aug 2007 23:28:23 +0200
Message-ID: <200708012328.23939.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: pm list <linux-pm@lists.linux-foundation.org>, Nigel Cunningham <nigel@nigel.suspend2.net>, LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, Oleg Nesterov <oleg@tv-sign.ru>
List-Id: linux-pm@vger.kernel.org

Hi,

The patches in the next three messages do the following:
* make the freezer a bit more verbose
* make try_to_freeze_tasks() go to sleep while waiting for tasks to enter
  the refrigerator instead of busy looping
* make try_to_freeze_tasks() measure the time of freezing, regardless of
  whether or not it is successful

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
