From: Yauhen Kharuzhy <jekhor@gmail.com>
Subject: uevent before resume completion
Date: Mon, 22 Sep 2008 17:19:59 +0300
Message-ID: <20080922141959.GA7976@jeknote.loshitsa1.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
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
To: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi.

We have an ARM board which does wakeup on USB cable connection to
it. In our power supply driver "USB connect" interrupt handler calls
power_supply_changed() which cause generation of uevent (in
power_supply_changed_work() ). But usermodehelper_disabled
still equals to 1 because resume process is not finished yet and
userspace helper is not executed.

How to fix this behaviour without breaking other kernel parts? We
definitely need to invoke userspace helper on USB cable insertion. Yes,
we can generate event after some time with timer but I think that a more
elegant solution can be found.

Please, CC: answers to me.

-- 
Yauhen Kharuzhy		jekhor _at_ gmail.com
			JID: jek@jabber.ru

A: No
Q: Should I quote below my post?
