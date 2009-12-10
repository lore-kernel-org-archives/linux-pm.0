From: "Mahalingam, Nithish" <nithish.mahalingam@intel.com>
Subject: Re: Runtime PM: Not updating parent's usage
	in	->pm_runtime_suspend?
Date: Thu, 10 Dec 2009 16:34:30 +0530
Message-ID: <175E0F9A9EFCEA46A65F5552BB057298C5F1991B@bgsmsx502.gar.corp.intel.com>
References: <175E0F9A9EFCEA46A65F5552BB057298C5F198E6@bgsmsx502.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <175E0F9A9EFCEA46A65F5552BB057298C5F198E6@bgsmsx502.gar.corp.intel.com>
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
To: "Mahalingam, Nithish" <nithish.mahalingam@intel.com>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, "Rafael J. Wysocki" <rjw@sisk.pl>
List-Id: linux-pm@vger.kernel.org

OK understood the flow now. Ignore this mail.

Regards,	
Nithish Mahalingam


-----Original Message-----
From: linux-pm-bounces@lists.linux-foundation.org [mailto:linux-pm-bounces@lists.linux-foundation.org] On Behalf Of Mahalingam, Nithish
Sent: Thursday, December 10, 2009 4:08 PM
To: linux-pm@lists.linux-foundation.org; Rafael J. Wysocki; Alan Stern
Subject: [linux-pm] Runtime PM: Not updating parent's usage in ->pm_runtime_suspend?

Hi,

While going through the code I found that the parent's usage count (usage_count) 
gets incremented when a device's pm_runtime_resume is called but does not get 
decremented when the device's pm_runtime_suspend is called. Am I missing 
something in the flow?

Regards,	
Nithish Mahalingam
_______________________________________________
linux-pm mailing list
linux-pm@lists.linux-foundation.org
https://lists.linux-foundation.org/mailman/listinfo/linux-pm
