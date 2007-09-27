From: Oliver Neukum <oliver@neukum.org>
Subject: The evilness of struct usb_device->auto_pm
Date: Thu, 27 Sep 2007 13:56:28 +0200
Message-ID: <200709271356.28884.oliver__8331.32308112017$1190894268$gmane$org@neukum.org>
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
To: linux-pm@lists.linux-foundation.org, linux-usb-devel@lists.sourceforge.net, Alan Stern <stern@rowland.harvard.edu>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

Hi,

doing autosuspend for the storage driver, this feature was a sore point.
At some point we have to cross subsystem borders when doing runtime
suspend on a subtree of the device tree. Drivers need to know whether
they are doing a system wide suspend or a runtime suspend. The locking
requirements at the very least are different.
We need a standardised way to tell drivers what kind of suspension they
are dealing with. So I think it has to move into the generic struct device
or become a part of the message parameter.

	Regards
		Oliver
