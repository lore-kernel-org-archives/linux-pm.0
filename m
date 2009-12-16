From: "Mahalingam, Nithish" <nithish.mahalingam@intel.com>
Subject: Re: Runtime PM: Idle notification
Date: Wed, 16 Dec 2009 11:17:31 +0530
Message-ID: <175E0F9A9EFCEA46A65F5552BB057298D7D7F223@bgsmsx502.gar.corp.intel.com>
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

> Shouldn't we just return success if power.runtime_status == RPM_SUSPENDED? I 
> know it does not make a difference in the runtime PM core as return value for 
> the idle callbacks are never checked. But what if someone wants to use idle 
> callback API explicitly?

Also I do understand returning success is not a clean solution, I am just 
trying to understand what might be the right thing to in this scenario.


Regards,	
Nithish Mahalingam
