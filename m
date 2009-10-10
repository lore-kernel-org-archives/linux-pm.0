From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: ext4 filesystem corruption
Date: Sat, 10 Oct 2009 05:26:18 +0200
Message-ID: <1255145178.3542.9.camel@maxim-laptop>
References: <1254863215.11577.23.camel@maxim-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1254863215.11577.23.camel@maxim-laptop>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: linux-pm <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

I have more information on that issue.

First of all this isn't related to s2ram/disk.
Second, this happened here again 3 times.

Now kernel complains loudly about access to freed inode.

After a reboot fsck tells the following:

- Some directory entries point to freed inodes,
   Which means these files are gone, but I never deleted some of them

- Some inodes have shared blocks

- Some orpahaned inodes found

- Free block counts/bitmaps corrupted.

That all happens without any s2ram/disk cycle.

However, yet an unusual situation did happen today.
I had installed an update to mountall ubuntu package, and it hosed all
boot process.
I had to  reboot many times, and once did hold the power button for 4
seconds.

I also used often the SYSRQ+U/SYSRQ+B tool.

On the contrary, I did several s2disk cycles, and one did fail, but
there was no corruption.

I must say that until now, I had never seen any ext3/ext4 corruption,
even though there were many many crashes, power failures, forced
reboots, etc...

Best regards,
Maxim Levitsky
