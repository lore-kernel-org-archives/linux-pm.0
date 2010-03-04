From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Is it supposed to be ok to call del_gendisk while
 userspace is frozen?
Date: Wed, 3 Mar 2010 21:48:39 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1003032142580.6963-100000__26839.5637548112$1267671016$gmane$org@netrider.rowland.org>
References: <201003040123.13617.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201003040123.13617.rjw@sisk.pl>
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
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Jens Axboe <jens.axboe@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 4 Mar 2010, Rafael J. Wysocki wrote:

> > Very well.  Then we still need a solution to the original problem:  
> > Devices sometimes need to be unregistered during resume, but
> > del_gendisk() blocks on the writeback thread, which is frozen until
> > after the resume finishes.  How do you suggest this be fixed?
> 
> I thought about thawing the writeback thread earlier in such cases.
> 
> Would that makes sense / is it doable at all?

My thought exactly.  This is the only approach that also solves the 
following race:

	A driver is unloaded at the same time as a suspend starts.

	The writeback thread gets frozen.

	Then before the rmmod thread is frozen, it calls del_gendisk.

Delaying things by means of a workqueue (or the equivalent) might also 
work, but it doesn't seem as safe.  For example, some important 
writebacks might end up getting delayed until too late.

Alan Stern
