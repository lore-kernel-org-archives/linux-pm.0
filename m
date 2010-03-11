From: Greg KH <greg@kroah.com>
Subject: Re: power/level and power/control
Date: Thu, 11 Mar 2010 11:38:23 -0800
Message-ID: <20100311193823.GC29148__28873.9876043566$1268362220$gmane$org@kroah.com>
References: <Pine.LNX.4.44L0.1003111139170.1367-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1003111139170.1367-100000@iolanthe.rowland.org>
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
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, USB list <linux-usb@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Mar 11, 2010 at 11:44:59AM -0500, Alan Stern wrote:
> Greg & Rafael:
> 
> In 2.6.34-rc1 we have the new /sys/devices/.../power/control attribute, 
> which does exactly the same thing as USB's existing power/level 
> attribute.
> 
> There's no reason to keep both.  I'd remove power/level entirely, 
> except that it has been in existence for a while and people may be 
> using it.
> 
> The best solution may be to replace "level" with a symbolic link to 
> "control", and possibly also to deprecate it.  Does that seem like the 
> right thing to do?

Sounds good to me.

thanks,

greg k-h
