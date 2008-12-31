From: Larry Finger <Larry.Finger@lwfinger.net>
Subject: Re: rtl8187 usb wifi adaptor causes suspend hang
Date: Wed, 31 Dec 2008 17:00:05 -0600
Message-ID: <495BF975.7030603__47329.6029180803$1230910657$gmane$org@lwfinger.net>
References: <348894.23448.qm@web23108.mail.ird.yahoo.com>
	<495B82CB.6050205@tuffmail.co.uk> <495BC8F9.4040203@lwfinger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <495BC8F9.4040203@lwfinger.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Cc: Bob Copeland <me@bobcopeland.com>, USB list <linux-usb@vger.kernel.org>, linux-wireless@vger.kernel.org, Herton Ronaldo Krzesinski <herton@mandriva.com.br>, htl10@users.sourceforge.net, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Here is a second try at a suspend/resume patch for rtl8187. This one
also seems a bit too easy; however, it did work for me, at least for
STD. I now realize that my machine didn't power off in my previous
test. This time I manually turned it off before restarting. My
computer still doesn't STR, thus that was not tested.

Larry

=============





Index: wireless-testing/drivers/net/wireless/rtl818x/rtl8187_dev.c
===================================================================
--- wireless-testing.orig/drivers/net/wireless/rtl818x/rtl8187_dev.c
+++ wireless-testing/drivers/net/wireless/rtl818x/rtl8187_dev.c
@@ -1464,6 +1464,28 @@ static int __devinit rtl8187_probe(struc
 	return err;
 }

+#ifdef CONFIG_PM
+
+static int rtl8187_suspend(struct usb_interface *intf, pm_message_t
state)
+{
+	struct ieee80211_hw *dev = usb_get_intfdata(intf);
+
+	rtl8187_stop(dev);
+
+	return 0;
+}
+
+static int rtl8187_resume(struct usb_interface *intf)
+{
+	struct ieee80211_hw *dev = usb_get_intfdata(intf);
+
+	rtl8187_start(dev);
+
+	return 0;
+}
+
+#endif /* CONFIG_PM */
+
 static void __devexit rtl8187_disconnect(struct usb_interface *intf)
 {
 	struct ieee80211_hw *dev = usb_get_intfdata(intf);
@@ -1484,6 +1506,10 @@ static struct usb_driver rtl8187_driver
 	.id_table	= rtl8187_table,
 	.probe		= rtl8187_probe,
 	.disconnect	= __devexit_p(rtl8187_disconnect),
+#ifdef CONFIG_PM
+	.suspend	= rtl8187_suspend,
+	.resume		= rtl8187_resume,
+#endif /* CONFIG_PM */
 };

 static int __init rtl8187_init(void)
