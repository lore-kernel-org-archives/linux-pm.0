From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Is it supposed to be ok to call del_gendisk while
	userspace is frozen?
Date: Thu, 4 Mar 2010 20:26:30 +0100
Message-ID: <201003042026.30303.rjw__34342.2079495669$1267730684$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.1003032142580.6963-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1003032142580.6963-100000@netrider.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Jens Axboe <jens.axboe@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thursday 04 March 2010, Alan Stern wrote:
> On Thu, 4 Mar 2010, Rafael J. Wysocki wrote:
> 
> > > Very well.  Then we still need a solution to the original problem:  
> > > Devices sometimes need to be unregistered during resume, but
> > > del_gendisk() blocks on the writeback thread, which is frozen until
> > > after the resume finishes.  How do you suggest this be fixed?
> > 
> > I thought about thawing the writeback thread earlier in such cases.
> > 
> > Would that makes sense / is it doable at all?
> 
> My thought exactly.  This is the only approach that also solves the 
> following race:
> 
> 	A driver is unloaded at the same time as a suspend starts.
> 
> 	The writeback thread gets frozen.
> 
> 	Then before the rmmod thread is frozen, it calls del_gendisk.
> 
> Delaying things by means of a workqueue (or the equivalent) might also 
> work, but it doesn't seem as safe.  For example, some important 
> writebacks might end up getting delayed until too late.

OK, so what exactly should trigger the thawing of the writeback thread?

Should we do that unconditionally at one point or wait for a specific situation
to happen, and how to recognize that situation in the latter case?

Rafael
