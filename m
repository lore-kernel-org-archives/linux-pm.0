From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] pm: rename device_power_down/up()
Date: Thu, 14 May 2009 15:34:51 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0905141533260.24833@localhost.localdomain>
References: <Pine.LNX.4.44L0.0905141421130.4344-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <Pine.LNX.4.44L0.0905141421130.4344-100000@iolanthe.rowland.org>
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
Cc: linux-pm@lists.linux-foundation.org, Greg KH <gregkh@suse.de>, akpm@linux-foundation.org
List-Id: linux-pm@vger.kernel.org

I agree with Alan,

ACK on the 1st patch, and lets follow it up
so we're not in the funky state where we have
both device_resume() and resume_device() etc. at the same time.

thanks,
Len Brown, Intel Open Source Technology Center
