From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH RFC] introduce pm_call() macro to get rid of
	most	#ifdef CONFIG_PM
Date: Mon, 3 Mar 2008 14:56:38 -0800
Message-ID: <200803031456.38406.david-b__33860.625481657$1204585231$gmane$org@pacbell.net>
References: <20080302234308.GA10116@zarina> <20080303141818.GE12606@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080303141818.GE12606@elf.ucw.cz>
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
To: linux-pm@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org, Anton Vorontsov <cbouatmailru@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Monday 03 March 2008, Pavel Machek wrote:
> > +/* avoid `defined but not used' warning */
> > +#define pm_call(x) ((x) - 1 ? NULL : NULL)
> > +#endif /* CONFIG_PM */
> > +
> 
> This is evil.

Ugly, yes.  It might merit some casts too.


> Maybe your gcc is smart enough to optimize this away, 
> but I'm not sure mine is.

It'll be a constant expression; it certainly ought to be.
