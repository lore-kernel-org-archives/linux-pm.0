From: Kenneth Heitke <kheitke@codeaurora.org>
Subject: Question about expected behavior when PM runtime is
	disabled
Date: Fri, 10 Jun 2011 16:54:14 -0600
Message-ID: <4DF2A096.8020503@codeaurora.org>
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
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi Rafael,

Sorry if this question has been raised before.  I actually have two 
questions here.  These questions are related to PM runtime being 
disabled at runtime (i.e. call to pm_runtime_disable() )

If I call pm_runtime_enabled() to first determine if PM runtime is 
enabled followed conditionally by a call to pm_runtime_get_sync(), it 
would be possible for PM runtime to be disabled between these two calls 
and the get_sync() will fail.  Is there any reason to even use the 
enabled() call?  My goal here was to use the enabled() call to determine 
if PM runtime was configured/enabled in the kernel and then to manage my 
resources, clocks etc, in a different way if PM runtime is not present.

My second question then is what if PM runtime is enabled in the kernel 
and then gets disabled at runtime.  What is the expected behavior for a 
driver?  Should it fail all requests with EGAIN until PM runtime is 
enabled again? (in suspend state, PM runtime gets disable, new i/o 
request is made, power and clocks need to be turned on).

What about delayed autosuspend?  I believe that if PM runtime is 
disabled while there is a delayed autosuspend pending, the suspend will 
fail without notification (clocks and power will be left on).  Will PM 
runtime still be in the idle state once PM runtime is re-enabled?

thanks,
Ken


-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
