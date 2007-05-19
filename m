From: Alan Stern <stern@rowland.harvard.edu>
Subject: usb-make-the-autosuspend-workqueue-thread-freezable.patch
Date: Sat, 19 May 2007 11:16:44 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0705191110340.8729-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
To: Greg KH <greg@kroah.com>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, USB development list <linux-usb-devel@lists.sourceforge.net>, Avuton Olrich <avuton@gmail.com>
List-Id: linux-pm@vger.kernel.org

Greg:

The patch in $SUBJECT (already in your development tree) fixes a problem
with system suspend in 2.6.22-rc1, as described in

	http://bugzilla.kernel.org/show_bug.cgi?id=8498

(For people on the PM development list, it's worth pointing out that all
the patch does is make a particular kernel thread freezable.)

Can you please expedite getting it sent up to Linus?

Thanks,

Alan Stern
