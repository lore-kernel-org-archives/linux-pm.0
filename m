From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: wacom + runtime PM = AA deadlock
Date: Mon, 13 Sep 2010 10:25:38 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1009131019370.1584-100000__35593.8434637666$1284388022$gmane$org@iolanthe.rowland.org>
References: <4C8E180D.4020309@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4C8E180D.4020309@suse.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: pingc@wacom.com, Dmitry Torokhov <dtor@mail.ru>, Linux kernel mailing list <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org, linux-pm <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 13 Sep 2010, Jiri Slaby wrote:

> Hi,
> 
> by mistake when runtime PM is enabled by default for input devices, X
> hangs on wacom open:
> [<ffffffff814a00ea>] mutex_lock+0x1a/0x40
> [<ffffffffa02bc94b>] wacom_resume+0x3b/0x90 [wacom]
> [<ffffffff81327a32>] usb_resume_interface+0xd2/0x190
> [<ffffffff81327b5d>] usb_resume_both+0x6d/0x110
> [<ffffffff81327c24>] usb_runtime_resume+0x24/0x40
> [<ffffffff8130a2cf>] __pm_runtime_resume+0x26f/0x450
> [<ffffffff8130a23a>] __pm_runtime_resume+0x1da/0x450
> [<ffffffff8130a53a>] pm_runtime_resume+0x2a/0x50
> [<ffffffff81328176>] usb_autopm_get_interface+0x26/0x60
> [<ffffffffa02bc626>] wacom_open+0x36/0x90 [wacom]
> 
> wacom_open took wacom->lock and calls usb_autopm_get_interface which in
> turn calls wacom_resume which tries to aquire the lock again.
> 
> More details (dmesg including) at:
> https://bugzilla.novell.com/show_bug.cgi?id=638506
> 
> Any ideas how to fix that properly?

One possibility is for wacom_open simply not to acquire the lock until
after the usb_autopm_get_interface call returns.  And why does
wacom_open have that assignment to wacom->irq->dev?  The value was
already set in wacom_probe.

BTW, does anybody know why wacom_open calls usb_autopm_get_interface 
but wacom_close doesn't call usb_autopm_put_interface?

Alan Stern
