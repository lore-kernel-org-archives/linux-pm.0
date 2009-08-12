From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC][PATCH 0/3] PM: Asynchronous suspend and resume
Date: Wed, 12 Aug 2009 17:12:09 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0908121702520.23954-100000__6746.21359580687$1250111589$gmane$org@iolanthe.rowland.org>
References: <200908122218.13975.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200908122218.13975.rjw@sisk.pl>
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
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

On Wed, 12 Aug 2009, Rafael J. Wysocki wrote:

> Hi,
> 
> The following patches introduce a mechanism allowing us to execute device
> drivers' suspend and resume callbacks asynchronously during system sleep
> transitions, such as suspend to RAM.  The idea is explained in the [1/1] patch
> message.
> 
> Comments welcome.

I get the idea.  Not bad.  Have you tried it in a serious way?  For 
example, turning on the async_suspend flag for every device?

In one way it isn't as efficient as it could be.  You fire off a bunch
of async threads and then make many of them wait for parent or child
devices.  They could be doing useful work instead.

It would be interesting to invent a way of representing explicitly the 
non-tree dependencies -- assuming there aren't too many of them!  (I 
can just hear the TI guys hollering about power and timer domains...)

Alan Stern
