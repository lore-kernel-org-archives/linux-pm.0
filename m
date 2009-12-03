From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: System sleep vs. runtime PM
Date: Thu, 3 Dec 2009 12:50:28 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0912031249110.4795-100000@iolanthe.rowland.org>
References: <200912031813.25776.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200912031813.25776.oliver@neukum.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Oliver Neukum <oliver@neukum.org>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 3 Dec 2009, Oliver Neukum wrote:

> > However, I don't see any reason to know what woke us up.  All we really
> > need to know is what devices have wakeup requests outstanding when the
> > system resume is finished.  It doesn't matter which request came first
> > (presumably that was the one which woke us up).
> 
> That assumes that the firmware doesn't do anything stupid with
> pending remote wakeups as it resumes the system. I'd call this
> unwarranted optimism. The conservative solution would be to resume
> every device whose driver has requested remote wakeup be enabled.

Drivers certainly can use that as one of their criteria for whether to 
power-up a device during system resume.

Alan Stern
