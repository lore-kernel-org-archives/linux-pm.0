From: Greg KH <greg@kroah.com>
Subject: Re: [stable] Stable inclusion request
Date: Thu, 23 Sep 2010 11:28:56 -0700
Message-ID: <20100923182856.GN23040@kroah.com>
References: <201009121932.28753.rjw@sisk.pl> <20100912174445.GA3328@kroah.com>
	<201009121952.27115.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201009121952.27115.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Greg Kroah-Hartman <gregkh@suse.de>, stable@kernel.org
List-Id: linux-pm@vger.kernel.org

On Sun, Sep 12, 2010 at 07:52:26PM +0200, Rafael J. Wysocki wrote:
> On Sunday, September 12, 2010, Greg KH wrote:
> > On Sun, Sep 12, 2010 at 07:32:28PM +0200, Rafael J. Wysocki wrote:
> > > Hi,
> > > 
> > > Please add the following commit:
> > > 
> > > http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=152e1d592071c8b312bb898bc1118b64e4aea535
> > > 
> > > to the 2.6.35.y -stable tree.
> > > 
> > > It shouldn't be necessary in any other -stable trees that are being maintained
> > > currently.
> > 
> > Ok, I'll queue it up this week, thanks for letting me know.
> 
> Thanks a lot!
> 
> Actually, I think this one should be included in 2.6.35.y as well:
> 
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=6715045ddc7472a22be5e49d4047d2d89b391f45
> 
> (it shouldn't be necessary in the other currently maintained -stable trees).

Both are now queued up, thanks.

greg k-h
