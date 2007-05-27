From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH -mm 0/3] PM: Hibernation and suspend
	notifiers
Date: Sun, 27 May 2007 22:29:20 +0200
Message-ID: <200705272229.21263.rjw__3485.83949166841$1180297742$gmane$org@sisk.pl>
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
To: pm list <linux-pm@lists.linux-foundation.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

Hi,

The first of the following three patches introduces notifier chaing that can be
used by subsystems to prefore some hibernation-related or suspend-related
operations independent of device drivers' .suspend() and .resume() callbacks.

The next two patches use this mechanism for disabling/enabling the usermode
helper and firmware requesting functionality before/after (respectively) the
hibernation or suspend.

Comments welcome.

Greetings,
Rafael
