From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [RFD] Automatic suspend
Date: Fri, 20 Feb 2009 23:45:48 +0000
Message-ID: <20090220234548.GA9297__27913.2786709399$1235173718$gmane$org@srcf.ucam.org>
References: <200902192215.18365.rjw@sisk.pl> <200902201657.01145.rjw@sisk.pl>
	<200902210012.08088.oliver@neukum.org>
	<200902210040.50344.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200902210040.50344.rjw@sisk.pl>
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
Cc: Kyle Moffett <kyle@moffetthome.net>, Uli Luckas <u.luckas@road.de>, LKML <linux-kernel@vger.kernel.org>, Nigel Cunningham <nigel@nigel.suspend2.net>, Brian Swetland <swetland@google.com>, pm list <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Sat, Feb 21, 2009 at 12:40:48AM +0100, Rafael J. Wysocki wrote:

> We can't do the quirks from the kernel and that's one of the reasons why I
> think user space should start automatic suspend (it can do the quirks if
> necessary).

Any sort of automatic suspend is simply impossible in a world where your 
drivers don't work properly. There's code for making intel and radeon 
handle suspend/resume themselves now, and nvidia before g80 should also 
be easy. More recent nvidia is going to be some work.

But yeah. Let's not have "Work around broken drivers" as a design goal. 
The argument against timeouts in wakelocks works just as well here.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
