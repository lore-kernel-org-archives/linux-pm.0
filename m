From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] PM: Prevent waiting forever on asynchronous
 resume after abort
Date: Thu, 2 Sep 2010 16:45:25 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1009021642320.1311-100000__1864.88984986699$1283460367$gmane$org@iolanthe.rowland.org>
References: <AANLkTi=s3_kFvRY9Afzku82gUgW7YKYXDBZvTkxQsMP8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTi=s3_kFvRY9Afzku82gUgW7YKYXDBZvTkxQsMP8@mail.gmail.com>
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

> >> I think it would be better to change device_pm_init() and add a
> >> complete_all().
> >
> > I agree.
> That would work, and was my first solution, but it increases the
> reliance on the completion variable being left completed between state
> transitions, which is undocumented and unnecessary.  It seems more
> straightforward to me to only wait on the parent if the parent is
> suspended.

How about calling complete_all() from within dpm_prepare() as well?  
Then it will get initialized properly at the beginning of every sleep 
transition.

Alan Stern
