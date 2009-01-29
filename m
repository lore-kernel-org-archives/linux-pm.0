From: Daniel Qarras <dqarras@yahoo.com>
Subject: Acer Aspire 1690 Suspend/Hibernate Report with 2.6.29-rc3
Date: Thu, 29 Jan 2009 09:49:51 -0800 (PST)
Message-ID: <826361.85762.qm@web36805.mail.mud.yahoo.com>
Reply-To: dqarras@yahoo.com
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
To: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi!

Just a FYI, with my Acer Aspire 1690 using 2.6.29-rc3 suspend/hibernate behave in this manner:

Hibernation completes ok but resumes immediately as if I would have pressed the power button. This was bisected earlier this month and was a regression between 2.6.23 and 2.6.24 (so no change with 2.6.29-rc3):

https://lists.linux-foundation.org/pipermail/linux-pm/2009-January/019225.html

Suspend completes ok and resume works also! Only thing which might be worth mentioning is that when pressing or moving USB mouse, its internal led goes on and stays that way no matter how long untouched. After unplugging the mouse the system also resume when plugging the mouse back.

lspci is at 1) and rather recent dmesg at 2)

1) https://bugzilla.redhat.com/attachment.cgi?id=326874
2) https://bugzilla.redhat.com/attachment.cgi?id=326875

Cheers!




      
