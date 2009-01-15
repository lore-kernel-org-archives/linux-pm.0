From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH] resume: wait for device probing to finish
Date: Thu, 15 Jan 2009 09:23:52 +0000
Message-ID: <20090115092352.5d2ceffd__19345.8327827559$1232011823$gmane$org@infradead.org>
References: <200901142303.46166.rjw@sisk.pl>
	<20090114152444.64e1ddfb.akpm@linux-foundation.org>
	<200901150039.58972.rjw@sisk.pl>
	<1231983276.7229.575.camel@nigel-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1231983276.7229.575.camel@nigel-laptop>
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
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, pavel@suse.cz, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thu, 15 Jan 2009 12:34:36 +1100
Nigel Cunningham <ncunningham@crca.org.au> wrote:

> Hi Rafael etc.
> 
> On Thu, 2009-01-15 at 00:39 +0100, Rafael J. Wysocki wrote:
> 
> [...]
>  
> >  /**
> > + * wait_for_device_probe
> > + * Wait for device probing to be completed.
> > + *
> > + * Note: this function polls at 100 msec intervals.
> > + */
> > +int wait_for_device_probe(void)
> > +{
> > +	/* wait for the known devices to complete their probing */
> > +	while (driver_probe_done() != 0)
> > +		msleep(100);
> > +	async_synchronize_full();
> > +	return 0;
> > +}
> > +
> 
> Am I missing something? I can't see why you're polling instead of
> using probe_waitqueue.

I'm just consolidating the existing code to one place.
