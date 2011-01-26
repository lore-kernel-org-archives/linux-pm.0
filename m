From: Mandeep Singh Baines <msb@chromium.org>
Subject: [PATCH v1 0/6] Set printk priority level
Date: Wed, 26 Jan 2011 15:29:24 -0800
Message-ID: <1296084570-31453-1-git-send-email-msb__48418.7659611509$1296144547$gmane$org@chromium.org>
References: <20110125235700.GR8008@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110125235700.GR8008@google.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: gregkh@suse.de, rjw@sisk.pl, mingo@redhat.com, akpm@linux-foundation.org
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

We've been burned by regressions/bugs which we later realized could
have been triaged quicker if only we'd paid closer attention to
dmesg.

This patch series fixes printk()s which appear in the logs of the
device I'm currently working on. I'd love to fix all such printks
but there are hundreds of files and thousands of LOC affected:

$ find . -name \*.c | xargs fgrep -c "printk(\"" | wc -l
16237
$ find . -name \*.c | xargs fgrep "printk(\"" | wc -l
20745

[PATCH 1/6] mm/page_alloc: use appropriate printk priority level
[PATCH 2/6] arch/x86: use appropriate printk priority level
[PATCH 3/6] PM: use appropriate printk priority level
[PATCH 4/6] TTY: use appropriate printk priority level
[PATCH 5/6] fs: use appropriate printk priority level
[PATCH 6/6] taskstats: use appropriate printk priority level
