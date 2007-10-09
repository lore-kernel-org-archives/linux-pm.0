From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: parallel suspend/resume
Date: Tue, 9 Oct 2007 11:54:48 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0710091152190.4783-100000@iolanthe.rowland.org>
References: <20071008194639.GA5301@dmt>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20071008194639.GA5301@dmt>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Marcelo Tosatti <marcelo@kvack.org>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Mon, 8 Oct 2007, Marcelo Tosatti wrote:

> Hi,
> 
> I spent some time working with the parallel suspend/resume idea, even
> wrote a simple patch (attached), but that obviously does not scale to
> large number of devices.
> 
> What would be a better approach? 

In general, parallel suspend/resume isn't easy to do correctly.  There 
are lots of constraints on the order in which devices can be suspended, 
many of them not explicitly stated anywhere.  I don't think it is 
feasible to encapsulate the constraint information in the PM core; if 
anything, it should be left up to the individual subsystems to suspend 
or resume their devices in parallel.

Alan Stern
