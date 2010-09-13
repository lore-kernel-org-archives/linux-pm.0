From: Jiri Slaby <jslaby@suse.cz>
Subject: wacom + runtime PM = AA deadlock
Date: Mon, 13 Sep 2010 14:24:45 +0200
Message-ID: <4C8E180D.4020309__37372.0555370257$1284380855$gmane$org@suse.cz>
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
To: pingc@wacom.com
Cc: Dmitry Torokhov <dtor@mail.ru>, linux-pm <linux-pm@lists.linux-foundation.org>, Linux kernel mailing list <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi,

by mistake when runtime PM is enabled by default for input devices, X
hangs on wacom open:
[<ffffffff814a00ea>] mutex_lock+0x1a/0x40
[<ffffffffa02bc94b>] wacom_resume+0x3b/0x90 [wacom]
[<ffffffff81327a32>] usb_resume_interface+0xd2/0x190
[<ffffffff81327b5d>] usb_resume_both+0x6d/0x110
[<ffffffff81327c24>] usb_runtime_resume+0x24/0x40
[<ffffffff8130a2cf>] __pm_runtime_resume+0x26f/0x450
[<ffffffff8130a23a>] __pm_runtime_resume+0x1da/0x450
[<ffffffff8130a53a>] pm_runtime_resume+0x2a/0x50
[<ffffffff81328176>] usb_autopm_get_interface+0x26/0x60
[<ffffffffa02bc626>] wacom_open+0x36/0x90 [wacom]

wacom_open took wacom->lock and calls usb_autopm_get_interface which in
turn calls wacom_resume which tries to aquire the lock again.

More details (dmesg including) at:
https://bugzilla.novell.com/show_bug.cgi?id=638506

Any ideas how to fix that properly?

thanks,
-- 
js
suse labs
