From: Oliver Neukum <oliver@neukum.org>
Subject: Re: Runtime resume of children
Date: Thu, 26 Nov 2009 17:47:08 +0100
Message-ID: <200911261747.09019.oliver@neukum.org>
References: <Pine.LNX.4.44L0.0911251542030.2879-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0911251542030.2879-100000@iolanthe.rowland.org>
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
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Am Mittwoch, 25. November 2009 21:46:14 schrieb Alan Stern:
> On Wed, 25 Nov 2009, Oliver Neukum wrote:
> > Am Montag, 23. November 2009 21:59:12 schrieb Alan Stern:

> > > Correct.  It's a specific case that I need to handle for USB.
> >
> > Hm. In which way is this different from a system where devices
> > share clock lines? It seems to me that groups of devices that
> > can be suspended only together are not rare. That in USB these
> > devices happen to be all a device's interfaces does not really
> > matter.
> 
> That's not a good example because there's nothing wrong with suspending
> some of the devices while leaving the clock and the others running.
> You'll have to search harder to find a group of devices which really do
> need to be suspended all together.

True, so think about a shared switchable power line. But that's the
way of the future.

	Regards
		Oliver
