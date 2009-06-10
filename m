From: Hans-Joachim Picht <hans@linux.vnet.ibm.com>
Subject: Re: [patch 05/38] s390: hibernation support for s390
Date: Wed, 10 Jun 2009 11:48:09 +0200
Message-ID: <20090610114809.2c96d243__45738.9021794826$1244627437$gmane$org@blc4eb509856389.ibm.com>
References: <20090604161847.513682672@de.ibm.com>
	<20090604161900.659762303@de.ibm.com>
	<20090608064451.GD1444@ucw.cz>
	<20090609153402.58e6b841@blc4eb509856389.ibm.com>
	<20090609195903.GB1388@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090609195903.GB1388@ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390@vger.kernel.org, linux-pm@lists.linux-foundation.org, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, 9 Jun 2009 21:59:03 +0200
Pavel Machek <pavel@ucw.cz> wrote:

> > > > +/*
> > > > + * save CPU registers before creating a hibernation image and
> > > > before
> > > > + * restoring the memory state from it
> > > > + */
> > > > +void save_processor_state(void)
> > > > +{
> > > > +}
> > > > +
> > > > +/*
> > > > + * restore the contents of CPU registers
> > > > + */
> > > > +void restore_processor_state(void)
> > > > +{
> > > > +}
> > > 
> > > ...and explaining why the functions can be emmpty would be nice.
> > 
> > I integrated the code for this in the assembly backend in the
> > swsusp_arch_suspend & swsusp_arch_resume functions.
> 
> I guessed so. Maybe it is worth a comment?

Sure ;-)
