From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: 2.6.22-rcX Transmeta/APM regression
Date: Sat, 30 Jun 2007 12:08:03 -0700
Message-ID: <20070630120803.99a124e4.akpm__19137.1146044277$1183230558$gmane$org@linux-foundation.org>
References: <200706301126.41179.ak@suse.de>
	<20070630185706.3979.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070630185706.3979.qmail@science.horizon.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux@horizon.com
Cc: bk@suse.de, michal.k.k.piotrowski@gmail.com, linux-kernel@vger.kernel.org, ak@suse.de, hpa@zytor.com, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On 30 Jun 2007 14:57:06 -0400 linux@horizon.com wrote:

> > --- a/arch/i386/kernel/cpu/mtrr/generic.c~i386-mtrr-crash-fix
> > +++ a/arch/i386/kernel/cpu/mtrr/generic.c
> > @@ -65,7 +65,8 @@ get_fixed_ranges(mtrr_type * frs)
> >  
> >  void mtrr_save_fixed_ranges(void *info)
> >  {
> > -	get_fixed_ranges(mtrr_state.fixed_ranges);
> > +	if (cpu_has_mtrr)
> > +		get_fixed_ranges(mtrr_state.fixed_ranges);
> >  }
> >  
> >  static void print_fixed(unsigned base, unsigned step, const mtrr_type*types)
> 
> This works great, thanks!  Please consider the regression diagnosed and fixed.

OK, thanks.  I'll scoot that linuswards later today.
