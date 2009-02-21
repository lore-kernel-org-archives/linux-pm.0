From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFD] Automatic suspend
Date: Sat, 21 Feb 2009 10:52:09 +0100
Message-ID: <200902211052.10989.rjw__19097.6460966796$1235210161$gmane$org@sisk.pl>
References: <200902192215.18365.rjw@sisk.pl> <200902210040.50344.rjw@sisk.pl>
	<20090220234548.GA9297@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090220234548.GA9297@srcf.ucam.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Kyle Moffett <kyle@moffetthome.net>, Uli Luckas <u.luckas@road.de>, LKML <linux-kernel@vger.kernel.org>, Nigel Cunningham <nigel@nigel.suspend2.net>, Brian Swetland <swetland@google.com>, pm list <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Saturday 21 February 2009, Matthew Garrett wrote:
> On Sat, Feb 21, 2009 at 12:40:48AM +0100, Rafael J. Wysocki wrote:
> 
> > We can't do the quirks from the kernel and that's one of the reasons why I
> > think user space should start automatic suspend (it can do the quirks if
> > necessary).
> 
> Any sort of automatic suspend is simply impossible in a world where your 
> drivers don't work properly. There's code for making intel and radeon 
> handle suspend/resume themselves now, and nvidia before g80 should also 
> be easy. More recent nvidia is going to be some work.
> 
> But yeah. Let's not have "Work around broken drivers" as a design goal. 

OK, I'm withdrawing it, then. :-)

> The argument against timeouts in wakelocks works just as well here.

So, what do you thing about the approach desribed earlier in this thread
(http://lkml.org/lkml/2009/2/20/182)?

Rafael
