From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Re: [PATH 1/1] Kexec jump - v2 - kexec jump
Date: Thu, 16 Aug 2007 12:26:35 +0200
Message-ID: <20070816102635.GA2039__19243.5600249611$1187269753$gmane$org@elf.ucw.cz>
References: <1184483639.1898.99.camel@caritas-dev.intel.com>
	<20070731095101.GA1774@elf.ucw.cz>
	<1185954978.1363.23.camel@caritas-dev.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1185954978.1363.23.camel@caritas-dev.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Huang, Ying" <ying.huang@intel.com>
Cc: david@lang.hm, nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

Hi!

> > > +int kexec_flags;
> > > +
> > > +static unsigned long kexec_jump_buf_pfn;
> > > +
> > > +static int __init parse_kexec_jump_buf_pfn(char *arg)
> > > +{
> > > +	if (!arg)
> > > +		return -EINVAL;
> > > +
> > > +	kexec_jump_buf_pfn = memparse(arg, &arg);
> > > +	kexec_flags |= KEXEC_FLAGS_IS_KEXECED_KERNEL;
> > > +	return 0;
> > > +}
> > > +early_param("kexec_jump_buf_pfn", parse_kexec_jump_buf_pfn);
> > 
> > This one should be documented, too, I'd guess. (Is that internal,
> > kernel-to-kernel communication?)
> 
> Document will be added in next version too.

Ping... is there some next version?

I'm stuck at the tools side currently. kexec-1.101 just won't load the
kernel properly, and kexec-testing from git does not know -j option. I
tried hand-patching it, but got lots of scary rejects.

Is there chance for a patch against kexec-testing?
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
