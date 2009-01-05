From: Daniel Qarras <dqarras@yahoo.com>
Subject: Hibernation breaks between 2.6.23 and 2.6.24 on Acer
	Aspire 1690
Date: Mon, 5 Jan 2009 08:35:28 -0800 (PST)
Message-ID: <524512.7403.qm@web36807.mail.mud.yahoo.com>
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

Hi all,

I've got Fedora 10 on Acer Aspire 1690 (1692 WLMi to be exact) and some time ago I noticed that pm-hibernate has the following problem:

pm-hibernate runs ok and cleanly shuts down the machine that at the very moment it is supposed to be hibernated it wakes up and resumes as if I had pressed the power button.

I compiled few kernel.org kernels and noticed this starts to occur between 2.6.23 and 2.6.24. 2.6.23 and all older versions work, 2.6.24 and new versions fail, including 2.6.28.

Does anyone have any suggestions what might be causing this? I mean, could I try some boot parameter or some simple patch before starting to bisect this?

FWIW, dmesg/lspci output can be found from my Fedora bug report at

https://bugzilla.redhat.com/show_bug.cgi?id=476430

Thanks!




      
