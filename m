From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [Q] freezing tasks vs. suspending drivers during STR
Date: Thu, 14 Jul 2011 10:43:26 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1107141040100.1983-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.64.1107141430460.10688@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.64.1107141430460.10688@axis700.grange>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thu, 14 Jul 2011, Guennadi Liakhovetski wrote:

> Hi all
> 
> I ran across an issue, which I cannot understand. In short: kernel threads 
> continue running also after freezing of the tasks has completed, late into 
> the device suspend. My scenario was suspending the system, while running 
> dmatest. At some point also the DMA driver is suspended, but the dmatest 
> threads continue running, so they issue further requests, which then 
> confuse the driver. In case this is a known design "decision," you do not 
> have to read on. Below I'll just provide some excerpts from kernel logs, 
> supporting my statement. Any explanation and fix suggestions would be 
> appreciated!

I don't know how dmatest was designed, but it seems clear that the 
kernel threads it uses ought to be marked freezable.  Probably nobody 
imagined running dmatest while suspending the system.  Or maybe for 
some reason it's not possible to make those threads freezable.

> Well, sure, I could hack the driver to reject any submits after suspend or 
> queue them without executing, but... Is this behaviour correct?

The driver shouldn't have to worry about rejecting submissions after it 
is suspended.  Rather, no thread should be running to make those 
submissions in the first place.

Alan Stern
