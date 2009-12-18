From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Runtime PM: Idle notification
Date: Fri, 18 Dec 2009 23:54:11 +0100
Message-ID: <200912182354.12021.rjw@sisk.pl>
References: <175E0F9A9EFCEA46A65F5552BB057298D7D7F223@bgsmsx502.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <175E0F9A9EFCEA46A65F5552BB057298D7D7F223@bgsmsx502.gar.corp.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Mahalingam, Nithish" <nithish.mahalingam@intel.com>
Cc: "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Sorry for the delay.

On Wednesday 16 December 2009, Mahalingam, Nithish wrote:
> > Shouldn't we just return success if power.runtime_status == RPM_SUSPENDED? I 
> > know it does not make a difference in the runtime PM core as return value for 
> > the idle callbacks are never checked. But what if someone wants to use idle 
> > callback API explicitly?

In that case the return value of your _idle will depend on the caller who
actually uses the return value.  The PM core doesn't care.

> Also I do understand returning success is not a clean solution, I am just 
> trying to understand what might be the right thing to in this scenario.

That really depends on your bus type/ device type/ device class and the
driver in question.

Rafael
