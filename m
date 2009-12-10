From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Async suspend-resume patch w/ completions (was: Re:
 Async suspend-resume patch w/ rwsems)
Date: Thu, 10 Dec 2009 15:51:15 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0912101538250.3560__38663.8335920454$1260489135$gmane$org@localhost.localdomain>
References: <Pine.LNX.4.44L0.0912101321020.2680-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0912101321020.2680-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org



On Thu, 10 Dec 2009, Alan Stern wrote:
> 
> You probably didn't look closely at the original code in dpm_suspend()  
> and dpm_resume().  It's very awkward; each device is removed from
> dpm_list, operated on, and then added on to a new local list.  At the
> end the new list is spliced back into dpm_list.
> 
> This approach is better because it doesn't involve changing any list 
> pointers while the sleep transition is in progress.  At any rate, I 
> don't recommend doing it in the same patch as the async stuff; it 
> should be done separately.  Either before or after -- the two are 
> independent.

I do agree with the "independent" part. But I don't agree about the 
awkwardness per se.

Sure, it moves things back and forth and has private lists, but that's 
actually a fairly standard thing to do in those kinds of situations where 
you're taking something off a list, operating on it, and may need to put 
it back on the same list eventually. The VM layer does similar things.

So that's why I think your version was actually odder - the existing list 
manipulation isn't all that odd. It has that strange "did we get removed 
while we dropped the lock and tried to suspend the device" thing, of 
course, but that's not entirely unheard of either.

Could it be done more cleanly? I think so, but I agree with you that it's 
likely a separate issue.

I _suspect_, for example, that we could just do something like, the 
appended to avoid _some_ of the subtlety. IOW, just move the device to the 
local list early - and if it gets removed while being suspended, it will 
automatically get removed from the local list (the remover doesn't care 
_what_ list it is on whe it does a 'list_del(power.entr)').

UNTESTED PATCH! This may be total crap, of course. But it _looks_ like an 
"ObviousCleanup(tm)" - famous last words.

		Linus

---
 drivers/base/power/main.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 8aa2443..f2bb493 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -687,6 +687,7 @@ static int dpm_suspend(pm_message_t state)
 		struct device *dev = to_device(dpm_list.prev);
 
 		get_device(dev);
+		list_move(&dev->power.entry, &list);
 		mutex_unlock(&dpm_list_mtx);
 
 		error = device_suspend(dev, state);
@@ -698,8 +699,6 @@ static int dpm_suspend(pm_message_t state)
 			break;
 		}
 		dev->power.status = DPM_OFF;
-		if (!list_empty(&dev->power.entry))
-			list_move(&dev->power.entry, &list);
 		put_device(dev);
 	}
 	list_splice(&list, dpm_list.prev);
