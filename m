From: Oliver Neukum <oliver@neukum.org>
Subject: notification on system wide suspend
Date: Tue, 22 May 2007 22:54:06 +0200
Message-ID: <200705222254.07224.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
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
To: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

Hi,

I've got a problem with system wide suspend.

The HID layer can cause output triggered in interrupt, even interrupts
caused by another device. Thus the freezer does not prevent output
requests. If a HID device has been autosuspended the output request
should cause the device to be woken up.

During hibernations and system wide suspends, however, output must
be blocked and the request queued.

Unfortunately I can't reliably tell whether I may or may not restart the
queue. The suspend() method is not called again if a device has been
runtime autosuspended. Is there a notifier chain a driver can hook into?

	Regards
		Oliver
