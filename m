From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [QUESTION] How to reset TCP connections when
 resuming system from disk/ram
Date: Wed, 4 Jun 2008 14:54:29 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0806041452590.4505-100000@iolanthe.rowland.org>
References: <4846B7A9.4020904@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4846B7A9.4020904@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 4 Jun 2008, Maxim Levitsky wrote:

> Maxim Levitsky wrote:
> > Hi,
> > 
> > Thanks to your effort, the suspend to ram/disk works flawlessly on my
> > desktop system.
> > 
> > But I still have rather small, but annoying problem, that system doesn't
> > understands that a long suspend cycle was done, and still waits for long closed
> > TCP connections.
> > 
> > I remember there was a patch to close all TCP connections on suspend, but it was rejected
> > due to the fact that TCP sessions can live through short suspend/resume cycles.
> > 
> > What can you suggest here?
> > Is there a tool to close all TCP connections?

I don't know the answer to your question.

However you should note that closing all TCP connections is overkill.  
It's quite possible that some processes on your computer are 
communicating among themselves using TCP; there's no reason those 
connections should be killed.

Alan Stern
