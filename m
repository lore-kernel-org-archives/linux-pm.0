From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [GIT PULL] Opportunistic suspend from Google for 2.6.35
Date: Wed, 26 May 2010 01:13:34 +0200
Message-ID: <201005260113.34721.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
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
To: Linus Torvalds <torvalds@linux-foundation.org>, Alan Stern <stern@rowland.harvard.edu>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, Greg KH <gregkh@suse.de>, tytso@mit.edu, Brian Swetland <swetland@google.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Tejun Heo <tj@kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Felipe Balbi <felipe.balbi@nokia.com>
List-Id: linux-pm@vger.kernel.org

Hi Linus,

Please consider pulling the Google's opportunistic suspend patches from:

git://git.kernel.org/pub/scm/linux/kernel/git/rafael/suspend-2.6.git opsusp=
end

This is contentious, but in my opinion, at this point, it's as good as it g=
ets.

Quite a number of people don't like the idea, which is understandable, beca=
use
this stuff is kind of blunt.  However, it really helps the Android people to
deal with a problem we have no other working alternative solution for, ie.
maximizing battery life in the presence of arbitrarily badly designed
applications.

Some alternative approaches have been proposed during the on-going discussi=
on,
but they are general ideas rather than specific technical propositions, and
until someone actually tries to implement them it's not really  known
whether or not they are suitable for Android.  For this reason I don't think
we can realistically expect Google to implement any of them.  Thus, in my v=
iew,
we have a choice to either accept or reject this feature altogether.

Now, if the feature is rejected, I don't think it will cause Google to
abandon this approach and go for one we'd prefer.  Instead, I expect that
Google will continue to use it and it's going to be put into more and more
Android device drivers in that case.  As a result, these drivers won't be
submitted for mainline inclusion and the divergence between the mainline and
Android kernel trees will only increase over time.  Also, Android users won=
't
be able to use the mainline kernel without major modifications on their
systems, which won't be a good thing.

On the other hand, if the feature is accepted, we'll have to live with it,
which may turn out to be difficult in the long run.

To conclude, I see more reasons to merge it than to reject it, but they are=
 not
purely technical, so I don't feel like I'm in position to make this decisio=
n.
If you think this code is too ugly to live, please let me know.  If you thi=
nk
it's worth merging, please merge.  :-)


 Documentation/ioctl/ioctl-number.txt          |    3 +-
 Documentation/power/opportunistic-suspend.txt |  156 ++++++
 include/linux/suspend.h                       |    1 +
 include/linux/suspend_blocker.h               |  166 +++++++
 include/linux/suspend_ioctls.h                |    4 +
 kernel/power/Kconfig                          |   31 ++
 kernel/power/Makefile                         |    2 +
 kernel/power/main.c                           |  132 +++++-
 kernel/power/opportunistic_suspend.c          |  639 +++++++++++++++++++++=
++++
 kernel/power/power.h                          |   14 +
 kernel/power/process.c                        |   11 +-
 kernel/power/suspend.c                        |    5 +-
 kernel/power/user_suspend_blocker.c           |  143 ++++++
 13 files changed, 1296 insertions(+), 11 deletions(-)

---------------

Arve Hj=F8nnev=E5g (6):
      PM: Opportunistic suspend support
      PM: Add driver to access suspend blockers from user space
      PM: Abort task freezing if there is an active suspend blocker
      PM: Add debugfs file for suspend blockers
      PM: Report statistics for suspend blockers
      PM: Introduce suspend blocking work

Rafael J. Wysocki (1):
      PM: Fix build with CONFIG_SUSPEND unset
