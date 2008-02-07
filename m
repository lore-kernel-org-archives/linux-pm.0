From: Jan Harkes <jaharkes@cs.cmu.edu>
Subject: Re: [GIT PATCH] suspend patches for 2.6.25-rc0
Date: Thu, 7 Feb 2008 17:27:13 -0500
Message-ID: <20080207222713.GA20549@cs.cmu.edu>
References: <200802011820.56693.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200802011820.56693.lenb@kernel.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Len Brown <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Fri, Feb 01, 2008 at 06:20:56PM -0500, Len Brown wrote:
> please pull from: 
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.git suspend
> 
> This will update the files shown below.

The following patch,

    commit c3e94d899c864e558f938f9845ddb8c2e5d5ccd0
    Author: Alan Stern <stern@rowland.harvard.edu>
    Date:   Mon Nov 19 23:38:25 2007 +0100

    Hibernation: Add PM_RESTORE_PREPARE and PM_POST_RESTORE notifiers (rev. 2)

Seems to have reverted some code related to the PM_HIBERNATION_PREPARE
notifiers in kernel/power/user.c that were added in 2.6.23 by the
following patch,

    commit b10d911749d37dccfa5873d2088aea3f074b9e45
    Author: Rafael J. Wysocki <rjw@sisk.pl>
    Date:   Thu Jul 19 01:47:36 2007 -0700

    PM: introduce hibernation and suspend notifiers

I'm pretty sure this was not the intent of the new patch because it only
tries to extend upon the former functionality and not replace it.

Jan
