From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: power/level and power/control
Date: Thu, 11 Mar 2010 23:00:11 +0100
Message-ID: <201003112300.11761.rjw__36186.5997234874$1268344688$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.1003111139170.1367-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
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
Cc: Greg KH <greg@kroah.com>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, USB list <linux-usb@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thursday 11 March 2010, Alan Stern wrote:
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

Sounds reasonable to me.

Rafael
