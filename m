From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: 2.6.25-rc2: cannot power off, reboot
Date: Tue, 19 Feb 2008 23:25:43 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0802192321370.11079@axis700.grange>
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

Hi

Don't remember, if this has been already reported for post 2.6.24 kernels: 
for instance with 2.6.25-rc2 my dual P-II cannot power off / reboot with 
"essentially" the same .config as under 2.6.24. 2.6.24 works. Last 
messages on the console are about syncing the 2 SCSI disks. Sysrq-O (power 
off) says something about the keyboard, and then about syncing the disks 
again and stays on. I _think_ rebooting doesn't work either. What info is 
needed for debugging? .config + full dmesg? For both 2.6.24 and 
2.6.25-rc2?

Thanks
Guennadi
---
Guennadi Liakhovetski
