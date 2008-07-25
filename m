From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [patch 2.6.26-git] pm selftest:  rtc paranoia
Date: Fri, 25 Jul 2008 14:50:23 -0700
Message-ID: <20080725145023.8a18c988.akpm__11897.1348893412$1217022750$gmane$org@linux-foundation.org>
References: <200807251326.51987.david-b@pacbell.net>
	<20080725144946.5e1b78c8.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080725144946.5e1b78c8.akpm@linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: david-b@pacbell.net, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Fri, 25 Jul 2008 14:49:46 -0700
Andrew Morton <akpm@linux-foundation.org> wrote:

> >  	}
> >  	if (status < 0)
> >  		printk(err_suspend, status);
> > +
> > +	/* Some platforms can't detect that the alarm triggered the
> > +	 * wakeup, or (accordingly) disable it after it afterwards.
> > +	 * It's supposed to give oneshot behavior; cope.
> > +	 */
> > +	alm.enabled = false;
> > +	rtc_set_alarm(rtc, &alm);
> >  }
> >  
> >  static int __init has_wakealarm(struct device *dev, void *name_ptr)
> 
> I assume this fixes some reported bug?  Any references?
> 
> Is this needed in 2.6.26.x?  2.6.25.x?

oh.  pm-selftest is new.  Ignore me.
