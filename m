From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [GIT PATCH] suspend patches for 2.6.25-rc0
Date: Fri, 8 Feb 2008 00:14:40 +0100
Message-ID: <200802080014.41638.rjw__13605.925293132$1202426282$gmane$org@sisk.pl>
References: <200802011820.56693.lenb@kernel.org>
	<20080207222713.GA20549@cs.cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080207222713.GA20549@cs.cmu.edu>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jan Harkes <jaharkes@cs.cmu.edu>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thursday, 7 of February 2008, Jan Harkes wrote:
> On Fri, Feb 01, 2008 at 06:20:56PM -0500, Len Brown wrote:
> > please pull from: 
> > 
> > git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.git suspend
> > 
> > This will update the files shown below.
> 
> The following patch,
> 
>     commit c3e94d899c864e558f938f9845ddb8c2e5d5ccd0
>     Author: Alan Stern <stern@rowland.harvard.edu>
>     Date:   Mon Nov 19 23:38:25 2007 +0100
> 
>     Hibernation: Add PM_RESTORE_PREPARE and PM_POST_RESTORE notifiers (rev. 2)
> 
> Seems to have reverted some code related to the PM_HIBERNATION_PREPARE
> notifiers in kernel/power/user.c that were added in 2.6.23 by the
> following patch,
> 
>     commit b10d911749d37dccfa5873d2088aea3f074b9e45
>     Author: Rafael J. Wysocki <rjw@sisk.pl>
>     Date:   Thu Jul 19 01:47:36 2007 -0700
> 
>     PM: introduce hibernation and suspend notifiers
> 
> I'm pretty sure this was not the intent of the new patch because it only
> tries to extend upon the former functionality and not replace it.

I haven't revert the changes.  It's only moved the notifier chain calls from
the ioctls to open/release in user.c .

Thanks,
Rafael
