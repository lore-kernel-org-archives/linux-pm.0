From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] PM: Prevent waiting forever on asynchronous
 resume after abort
Date: Thu, 2 Sep 2010 17:34:08 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1009021723460.1311-100000__25086.5346556113$1283463322$gmane$org@iolanthe.rowland.org>
References: <AANLkTim7UM80MrwKoAz3hUFrqL2Fbyw6XS=X89PXRc2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTim7UM80MrwKoAz3hUFrqL2Fbyw6XS=X89PXRc2Q@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Colin Cross <ccross@android.com>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 2 Sep 2010, Colin Cross wrote:

> That would work, but I still don't see why it's better.  With either
> of your changes, the power.completion variable is storing state, and
> not just used for notification.  However, the exact meaning of that
> state is unclear, especially during the transition from an aborted
> suspend to resume, and the state is duplicating power.status.  Setting
> it to complete in dpm_prepare is especially confusing, because at that
> point nothing is completed, it hasn't even been started.

The state being waited for varies from time to time and is only
partially related to power.status.  Instead of using a completion I
suppose we could have used a new "transition_complete" variable
together with a waitqueue.  Would you prefer that?  It's effectively
the same thing as a completion, but without the nice packaging already 
provided by the kernel.

Alan Stern
