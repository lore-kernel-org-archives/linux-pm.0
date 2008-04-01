From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH] PM: Introduce new top level suspend and
	hibernation callbacks (rev. 6)
Date: Tue, 1 Apr 2008 23:59:52 +0200
Message-ID: <200804012359.54031.rjw__7283.35772078044$1207087334$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0804011653140.9362-100000@netrider.rowland.org>
	<1207085886.23143.114.camel@nigel-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1207085886.23143.114.camel@nigel-laptop>
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
To: Nigel Cunningham <ncunningham@crca.org.au>
Cc: LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Alexey Starikovskiy <astarikovskiy@suse.de>
List-Id: linux-pm@vger.kernel.org

On Tuesday, 1 of April 2008, Nigel Cunningham wrote:
> Hi.
> 
> On Tue, 2008-04-01 at 16:56 -0400, Alan Stern wrote:
> > On Tue, 1 Apr 2008, Rafael J. Wysocki wrote:
> > 
> > > > Does ..._ext_... mean extended? (external?) If 'extended' (or if not),
> > > > does that imply that they're mutually exclusive alternatives for drivers
> > > > to use?
> > > 
> > > 'ext' means 'extended'.  The idea is that the 'extended' version will be used
> > > by bus types / driver types that don't need to implement the _noirq callbacks.
> > 
> > Something's wrong here.  This seems to say that the "extended" version
> > has _fewer_ method pointers -- in which case it should be called 
> > "restricted" instead.
> 
> Agreed.

This was a mistake explained in another message.  The "don't" should not be
present in the above sentence.

> > > > So drivers can never validly fail to resume. That sounds fair enough. If
> > > > the hardware has gone away while in lower power mode (USB, say), should
> > > > the driver then just printk an error and return success?
> > > 
> > > I think so.
> > > 
> > > IMO, an error code returned by a driver's ->resume() should mean "the device
> > > hasn't resumed and is presumably dead".  Otherwise, ->resume() should return
> > > success.
> > 
> > If the device is gone, it doesn't much matter what resume() returns.
> 
> What if the same driver is handling multiple instances and only some of
> them fail to resume?

->resume() will be called separately for each of them.

Thanks,
Rafael
