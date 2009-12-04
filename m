From: "Mahalingam, Nithish" <nithish.mahalingam@intel.com>
Subject: Re: [PATCH] Runtime PM: Adding explicit check to make
 sure dev->parent supports runtime PM before accessing its PM fields.
Date: Fri, 4 Dec 2009 23:01:37 +0530
Message-ID: <175E0F9A9EFCEA46A65F5552BB057298C5C4F135@bgsmsx502.gar.corp.intel.com>
References: <175E0F9A9EFCEA46A65F5552BB057298C5C4F11C@bgsmsx502.gar.corp.intel.com>
	<Pine.LNX.4.44L0.0912041130571.3070-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0912041130571.3070-100000@iolanthe.rowland.org>
Content-Language: en-US
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
Cc: "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

> Can you please tell your email client to wrap lines after 72 columns or 
> so?

Am sorry, it is the work of MS Outlook. Will take care...

>> Yes Alan, those fields do get set but if you look at __pm_runtime_set_status function -
>> 
>> 	if (status == RPM_SUSPENDED) {
>> 		/* It always is possible to set the status to 'suspended'. */
>> 		if (parent) {
>> 			atomic_add_unless(&parent->power.child_count, -1, 0);
>> 			notify_parent = !parent->power.ignore_children;
>> 		}
>> 		goto out_set;
>> 	}
>> 
>> This code gets executed without doing any check to see if the parent supports
>> runtime PM. Doing explicit check before can avoid executing these code at runtime.

> And that would be a mistake.  If the code wasn't executed then
> parent->power.child_count would contain an incorrect value.  However, I
> agree that it might make sense to avoid setting notify_parent if the
> parent is disabled.

It is not only the previous example where child_count would end up with a 
wrong value, if you look at __pm_runtime_suspend -

		if (dev->parent) {
			parent = dev->parent;
			atomic_add_unless(&parent->power.child_count, -1, 0);
		}

and in __pm_runtime_resume -

		if (parent)
			atomic_inc(&parent->power.child_count);


Also wanted to ask - do you think acquiring spinlock every time before 
even checking if parent supports runtime PM, optimal?


Regards,	
Nithish Mahalingam
