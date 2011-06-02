From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: calling runtime PM from system PM methods
Date: Thu, 2 Jun 2011 14:38:01 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1106021436080.1674-100000__13750.3234706402$1307040034$gmane$org@iolanthe.rowland.org>
References: <87lixkyxa8.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <87lixkyxa8.fsf@ti.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Kevin Hilman <khilman@ti.com>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu, 2 Jun 2011, Kevin Hilman wrote:

> OK.  I was trying to catch that by checking pm_runtime_suspended(), but
> now see that that cannot work in general.
> 
> The problem I'm trying to solve is how (or whether) I can use runtime PM
> from the system PM methods, specifically in the case where runtime PM
> has been disabled from userspace (or pm_runtime_forbid() has been
> called.)  
> 
> In a nutshell, what I'm after is for any pm_runtime_forbid() calls to be
> cancelled during system PM, thus allowing pending runtime PM events to
> occur during system PM.

There are a few approaches that might do what you want.  But I'd like 
to hear Rafael's opinion before making any suggestions.

Alan Stern
