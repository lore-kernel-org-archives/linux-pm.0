From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Dynamic Idle?
Date: Fri, 7 Nov 2008 10:06:21 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0811071003100.2437-100000@iolanthe.rowland.org>
References: <345163910811070501x4cafe0afq28c89898b771ec76@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <345163910811070501x4cafe0afq28c89898b771ec76@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Peter Reid <ppeter.reid@gmail.com>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Fri, 7 Nov 2008, Peter Reid wrote:

> What do the following terms mean in terms of linux power management for
> embedded systems.
> 
>  1) Dynamic - Idle
>  2) Suspend-Resume

Dynamic and Idle are two separate terms.  Dynamic means that something 
is running.  Idle means that something either isn't running or else is 
running but isn't doing anything.

Suspend means to put either a single device or else the entire system
into a non-operational low-power state.  Resume means to put the device
or the system back into an operational full-power state.

> Could you please explain with a scenario of how these states occur in
> real world embedded systems.

Suppose an embedded system has a USB device attached.  At times when 
the device isn't being used, the system could put it into a low-power 
state to conserve energy.  When the system needs to use the device, it 
would first have to resume the device.

Alan Stern
