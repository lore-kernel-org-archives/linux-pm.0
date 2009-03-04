From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [RFC][Patch 0/3] Fix device_move() vs. dpm_list
 issues.
Date: Wed, 4 Mar 2009 11:01:31 +0100
Message-ID: <20090304110131.7adf2eb8@gondolin>
References: <20090303162446.3aff4457@gondolin>
	<Pine.LNX.4.44L0.0903031302330.3274-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0903031302330.3274-100000@iolanthe.rowland.org>
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
Cc: Marcel Holtmann <marcel@holtmann.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 3 Mar 2009 14:53:18 -0500 (EST),
Alan Stern <stern@rowland.harvard.edu> wrote:

> After looking through your s390 patch more carefully, I get a mixed-up 
> feeling -- as though you think dpm_list goes in reverse order. 

list_add_tail confused me...

> Therefore all you need to do is add a third argument to device_move(); 
> it can be a enumeration taking on one of the values
> 
> 	DPM_ORDER_DEV_AFTER_PARENT,
> 	DPM_ORDER_PARENT_BEFORE_DEV,
> 	DPM_ORDER_DEV_LAST.

and DPM_ORDER_DO_NOTHING.

> 
> (Come to think of it, I don't understand the reason for moving the
> device to the end of dpm_list.  What point is there in doing this?)

Completeness. It is not strictly needed.

> 
> 
> > Given that the callers still need to specify what to do, I find it much
> > easier (and the resulting code much more understandable) if the callers
> > fix up dpm_list...
> 
> I disagree.  Doing it the way described above would add less than 10
> lines of code to device_move() and one argument to each caller, whereas
> your changes are a lot more extensive.

I'm still not quite convinced, but I'll give it a try.
