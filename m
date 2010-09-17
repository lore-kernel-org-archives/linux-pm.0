From: Tejun Heo <tj@kernel.org>
Subject: Re: [RFC][PATCH] PM / Runtime: Use alloc_workqueue() for
 creating PM workqueue
Date: Fri, 17 Sep 2010 11:57:45 +0200
Message-ID: <4C933B99.9050209@kernel.org>
References: <201009152156.30749.rjw@sisk.pl> <4C91D132.6090607@kernel.org>
	<201009162024.51520.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201009162024.51520.rjw@sisk.pl>
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
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On 09/16/2010 08:24 PM, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
> Subject: PM / Runtime: Use alloc_workqueue() for creating the PM workqueue
> 
> Although we need the PM workqueue to be freezable, we don't need it
> to be singlethread.  Also, the number of concurrent work items
> running on a single CPU need not be constrained.  For these reasons
> use alloc_workqueue() directly, with suitable arguments, instead of
> create_freezeable_workqueue(), to create the runtime PM workqueue.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
