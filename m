From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 00/04][RFC] PM: Runtime platform device PM
Date: Thu, 28 May 2009 11:33:56 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0905281129090.3037-100000__29900.4183886156$1243524887$gmane$org@iolanthe.rowland.org>
References: <aec7e5c30905272314s54364f00u9bf5ecf48081dcda@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <aec7e5c30905272314s54364f00u9bf5ecf48081dcda@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: paul@pwsan.com, linux-sh@vger.kernel.org, gregkh@suse.de, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thu, 28 May 2009, Magnus Damm wrote:

> On Wed, May 27, 2009 at 11:30 PM, Alan Stern <stern@rowland.harvard.edu> wrote:
> > On Wed, 27 May 2009, Magnus Damm wrote:
> >> PM: Runtime platform device power management
> 
> > Have you given any thought as to whether the platform_device_wakeup and
> > platform_device_idle calls should be restricted to process context?
> 
> Good question. The first thing that pops into my mind is to have same
> restrictions as clk_enable() and clk_disable(). To keep things simple
> I'd say that it's unlikely that any embedded platform driver would
> need to sleep during the dev_pm_ops callbacks. Maybe it makes sense to
> only allow _noirq variants of dev_pm_ops, not sure. Any ideas?

I don't know what would be appropriate for you.  USB power transitions
cannot be made in an atomic context, but the situation could well be
different for platform devices.  It's just something to be aware of.

(And by the way, the _noirq ops don't run in atomic context.  They run 
in process context with most interrupt deliveries disabled.  It's not 
the same thing -- they are allowed to sleep.)

Alan Stern
