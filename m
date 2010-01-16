From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Memory allocations in .suspend became very unreliable
Date: Sat, 16 Jan 2010 01:57:54 +0100
Message-ID: <201001160157.54806.rjw@sisk.pl>
References: <1263549544.3112.10.camel@maxim-laptop>
	<201001152303.39885.rjw@sisk.pl>
	<1263599807.3407.2.camel@maxim-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1263599807.3407.2.camel@maxim-laptop>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Saturday 16 January 2010, Maxim Levitsky wrote:
> On Fri, 2010-01-15 at 23:03 +0100, Rafael J. Wysocki wrote: 
> > On Friday 15 January 2010, Maxim Levitsky wrote:
> > > Hi,
> > 
> > Hi,
> > 
> > > I know that this is very controversial, because here I want to describe
> > > a problem in a proprietary driver that happens now in 2.6.33-rc3
> > > I am taking about nvidia driver.
> > > 
> > > Some time ago I did very long hibernate test and found no errors after
> > > more that 200 cycles.
> > > 
> > > Now I update to 2.6.33 and notice that system will hand when nvidia
> > > driver allocates memory is their .suspend functions. 
> > 
> > They shouldn't do that, there's no guarantee that's going to work at all.
> > 
> > > This could fail in 2.6.32 if I would run many memory hungry
> > > applications, but now this happens with most of memory free.
> > 
> > This sounds a little strange.  What's the requested size of the image?
> Don't know, but system has to be very tight on memory.

Can you send full dmesg, please?

Rafael
