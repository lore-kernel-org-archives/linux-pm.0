From: Len Brown <lenb@kernel.org>
Subject: idle patches for 2.6.35
Date: Fri, 28 May 2010 02:01:53 -0400
Message-ID: <1275026521-30835-1-git-send-email-lenb@kernel.org>
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
Cc: linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This patch series responds to all the feedback I've received.

I believe that this series is useful enough and clean enough
to merit inclusion upstream.

Please look it over and try it out and let me know what I missed.

thanks,
Len Brown, Intel Open Source Technology Center

ps.
Note that you can get the patch series as a single patch here:
http://ftp.kernel.org/pub/linux/kernel/people/lenb/idle/patches/2.6.34/idle-test-2.6.34.diff.gz

or pull from this git branch
git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-idle-2.6.git idle-test

Note that I updated the series "in place", changing git history.
So if you previously pulled from idle-test, you'll want to
discard that branch and create a new one based on 2.6.34.
