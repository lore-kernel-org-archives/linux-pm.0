From: "Mahalingam, Nithish" <nithish.mahalingam@intel.com>
Subject: Runtime PM: Calling Device runtime PM callbacks?
Date: Sun, 13 Dec 2009 10:50:13 +0530
Message-ID: <175E0F9A9EFCEA46A65F5552BB057298C5F19EC7@bgsmsx502.gar.corp.intel.com>
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

I was wondering why PM Runtime Core cannot call the device PM callbacks when 
its device's bus does not support runtime PM (if such a scenario is valid)?


Regards,	
Nithish Mahalingam
P.S. Alan, Not sure if you are askin the a similar question in the 
"System sleep vs. runtime PM" mail thread.
