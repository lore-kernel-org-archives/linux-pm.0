From: Greg KH <greg@kroah.com>
Subject: Re: [RFC 1/2] Merge power-management source files
Date: Fri, 21 Sep 2007 10:40:32 -0700
Message-ID: <20070921174032.GA13137@kroah.com>
References: <Pine.LNX.4.44L0.0709201401470.3846-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0709201401470.3846-100000@iolanthe.rowland.org>
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
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Sep 20, 2007 at 02:05:03PM -0400, Alan Stern wrote:
> This proposed patch applies to 2.6.23-rc6-mm1.  It merges the suspend.c 
> and resume.c files in drivers/base/power into main.c, while making some 
> public symbols private.
> 
> If nobody objects, I will submit it to Andrew Morton.

Why Andrew?  I thought I had to handle all of the drivers/base/* stuff
:)

thanks,

greg k-h
