From: Willi Mann <foss-ml@wm1.at>
Subject: CONFIG_PM_VERBOSE causing system lockup
Date: Tue, 07 Sep 2010 11:23:45 +0200
Message-ID: <i650b3$h98$1@dough.gmane.org>
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
To: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

Hi!

For trying to test my software suspend issue I reported a month ago with 
kernel 2.6.36-rc3, I enabled CONFIG_PM_VERBOSE. Unfortunately, this causes a 
complete system lockup when I execute

dpkg-reconfigure linux-image-2.6.36-rc3

I discovered this by accident. I guess other commands causing serious amount 
of hard disk access could trigger the same, but I didn't test. 

I logged the following via netconsole, but kernel messages are written to 
both /var/log/syslog and /var/log/kern.log too. (I could imagine that this 
causes the problem). They are also written to local console as I've set log 
level 8 for the console. The last page of the screen before it freezes only 
contains the messages from the log. I tried to issue SysRQ-commands, but 
that doesn't cause any reaction. 

http://wserver.wm1.at/~willi/linux/config_pm_verbose/suspend-hang2.log.gz

Any ideas how to solve this problem?

WM
