From: David Brownell <david-b@pacbell.net>
Subject: Re: Removing dev.power.power_state (WAS: Feature
	Removals for 2.6.25)
Date: Fri, 1 Feb 2008 13:24:07 -0800
Message-ID: <200802011324.07760.david-b__14107.6786480427$1201901153$gmane$org@pacbell.net>
References: <Pine.LNX.4.44L0.0802011019370.3839-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0802011019370.3839-100000@iolanthe.rowland.org>
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
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Harvey.Harrison@gmail.com
List-Id: linux-pm@vger.kernel.org

On Friday 01 February 2008, Alan Stern wrote:
>
> I can look at the USB and SCSI stuff.  It shouldn't be all that bad.  
> The userspace interface has been gone for quite some time now, and most 
> of the remaining uses of that field are write-only.

It's that "most" which can make trouble.  :)

- Dave
