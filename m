From: Jiri Slaby <jslaby@suse.cz>
Subject: Why is max_cstate=1 still needed?
Date: Fri, 11 Mar 2011 13:18:42 +0100
Message-ID: <4D7A1322.4050706__11369.4707550623$1299845992$gmane$org@suse.cz>
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
To: Len Brown <lenb@kernel.org>
Cc: linux-pm <linux-pm@lists.linux-foundation.org>, "x86@kernel.org" <x86@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Linux kernel mailing list <linux-kernel@vger.kernel.org>, Jiri Slaby <jirislaby@gmail.com>
List-Id: linux-pm@vger.kernel.org

Hello,

there are still reports against the latest kernels, that people need to
pass processor/intel_idle.max_cstate=1 to successfully boot the kernel.
The symptoms are always the same, until the parameter is specified OR
until the user presses a key, the system won't boot up.

This started to appear between 2.6.31 and 2.6.34 (possibly a 2.6.33
regression) and continues to be reported against the latest stable
2.6.37.3. For example:
https://bugzilla.kernel.org/show_bug.cgi?id=15289
https://bugzilla.novell.com/show_bug.cgi?id=579932
https://bugzilla.novell.com/show_bug.cgi?id=673589
https://bugzilla.novell.com/show_bug.cgi?id=675161

I see that there were some fixes in .38-rc in this bug report (they look
unrelated):
https://bugzilla.kernel.org/show_bug.cgi?id=29992

Should they give .38-rc a try?

Any help would be appreciated.

thanks,
-- 
js
suse labs
