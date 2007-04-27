From: Gautham R Shenoy <ego@in.ibm.com>
Subject: Re: Re: [RFC/PATCH 2/2] kernel: don't update load average
	during snapshot/shutdown
Date: Fri, 27 Apr 2007 20:46:49 +0530
Message-ID: <20070427151649.GB22639@in.ibm.com>
References: <Pine.LNX.4.64.0704271629150.15297@sbz-30.cs.Helsinki.FI>
	<200704271700.52678.rjw@sisk.pl>
Reply-To: ego@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200704271700.52678.rjw@sisk.pl>
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
Cc: Pekka J Enberg <penberg@cs.helsinki.fi>, linux-pm@lists.osdl.org, nigel@nigel.suspend2.net, pavel@ucw.cz
List-Id: linux-pm@vger.kernel.org

On Fri, Apr 27, 2007 at 05:00:52PM +0200, Rafael J. Wysocki wrote:
> 
> This clashes with the recent freezer changes in -mm quite violently.
>

Yes. But I anyway plan to have a system_freeze_event_mask. That can
very well serve this purpose.

> We're moving the freezer to kernel/freezer.c and we're introducing a special
> field in task_struct for the freezer flags.
> 
> Please have a look at the freezer changes queued up in -mm and the freezer
> patches recently sent.

I am not sure if the recently sent freezer patches hit lkml.
I cannot spot the address in the CC list.

> 
> Greetings,
> Rafael
> _______________________________________________
> linux-pm mailing list
> linux-pm@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/linux-pm

-- 
Gautham R Shenoy
Linux Technology Center
IBM India.
"Freedom comes with a price tag of responsibility, which is still a bargain,
because Freedom is priceless!"
