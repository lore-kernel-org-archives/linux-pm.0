From: Nigel Cunningham <nigel@tuxonice.net>
Subject: [Patch] JBD and JBD2 missing set_freezable()
Date: Fri, 03 Feb 2012 19:59:41 +1100
Message-ID: <4F2BA1FD.3030302@tuxonice.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linux PM mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi all.

With the latest and greatest changes to the freezer, I started seeing
panics that were caused by jbd2 running post-process freezing and
hitting the canary BUG_ON for non-TuxOnIce I/O submission. I've traced
this back to a lack of set_freezable calls in both jbd and jbd2. Since
they're clearly meant to be frozen (there are tests for freezing()), I
submit the following patch to add the missing calls.

Signed-off-by: Nigel Cunningham <nigel@tuxonice.net>

diff --git a/fs/jbd/journal.c b/fs/jbd/journal.c
index 59c09f9..89cd985 100644
--- a/fs/jbd/journal.c
+++ b/fs/jbd/journal.c
@@ -129,6 +129,8 @@ static int kjournald(void *arg)
 	setup_timer(&journal->j_commit_timer, commit_timeout,
 			(unsigned long)current);

+	set_freezable();
+
 	/* Record that the journal thread is running */
 	journal->j_task = current;
 	wake_up(&journal->j_wait_done_commit);
diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index c0a5f9f..663e47c 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -139,6 +139,8 @@ static int kjournald2(void *arg)
 	setup_timer(&journal->j_commit_timer, commit_timeout,
 			(unsigned long)current);

+	set_freezable();
+
 	/* Record that the journal thread is running */
 	journal->j_task = current;
 	wake_up(&journal->j_wait_done_commit);
-- 
Evolution (n): A hypothetical process whereby improbable
events occur with alarming frequency, order arises from chaos, and
no one is given credit.
