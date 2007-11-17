From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: broken suspend [Was: 2.6.24-rc2-mm1]
Date: Sat, 17 Nov 2007 11:13:24 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0711171053500.29002-100000__19499.6423706927$1195316213$gmane$org@netrider.rowland.org>
References: <473F03DF.4020306@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <473F03DF.4020306@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sat, 17 Nov 2007, Jiri Slaby wrote:

> > The thing to do is figure out which driver is causing the problem.
> > Jiri, try enabling CONFIG_DEBUG_DRIVER.  
> 
> Sadly no output.

Guess I'll have to try running 2.6.24-rc2-mm1 on my own system.  In the 
meantime, you can try adding some printk statements to 
drivers/base/power/main.c.  In particular, see whether 
lock_all_devices() gets called from device_suspend(), whether it 
returns, and how far dpm_suspend() manages to get.

Alan Stern
