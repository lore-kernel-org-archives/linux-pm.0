From: Chase Douglas <chase.douglas@canonical.com>
Subject: Macbook 5,1 Ubuntu Lucid resume issue
Date: Thu, 04 Feb 2010 10:04:35 -0800
Message-ID: <1265306675.1951.14.camel@cndougla-ubuntu>
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

Hello all,

I'm testing resume from s3 suspend on Ubuntu Lucid on my macbook
(version 5,1; nvidia MCP 79 internals). On Ubuntu Karmic, resume
(usually) works without a hitch. However, on Lucid when I resume the
disk resumes and the system is partly running, but the display
(backlight and LCD I think) and ethernet networking do not come back up.
This occurs when resuming back to X or to a virtual terminal without X
started. It occurs whether the nvidia or nv kernel modules are loaded or
unloaded.

What is most interesting is the dependent variable in all of this is not
the kernel but the user-space. If I run Karmic with the Lucid kernel it
resumes correctly. If I run Lucid with the Karmic kernel it does not
resume correctly. I have run a script which essentially does:

1. suspend (using pm-suspend)
2. wait 60 seconds (during which time I resume the machine)
3. save dmesg output to the hard disk

I have pored over the dmesg logs from good and bad resumes, but I
haven't found anything to suggest what the real issue may be. Right now
I am at a loss as to what I should try next. Does anyone have any
thoughts as to what I can try to debug this?

Thanks,
Chase
