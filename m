From: "Mahalingam, Nithish" <nithish.mahalingam@intel.com>
Subject: Runtime PM: Check for dev->parent PM support
Date: Wed, 2 Dec 2009 13:08:34 +0530
Message-ID: <175E0F9A9EFCEA46A65F5552BB057298C5C4E603@bgsmsx502.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
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
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi Rafael,

I see that in most of the internal runtime functions (__pm_runtime_suspend, __pm_runtime_resume, __pm_runtime_set_status etc.) without any explicit check to see if the dev->parent supports runtime PM there is access to its runtime PM fields. I guess there can be a use case where a device supports runtime PM but its parent does not. Am I missing something here?

Regards,	
Nithish Mahalingam
