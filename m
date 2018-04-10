From: Yu Chen <yu.c.chen@intel.com>
Subject: Re: [PATCH][RFC] tools/power turbostat: if --max_loop, print for
 specific time of loops
Date: Tue, 10 Apr 2018 21:00:02 +0800
Message-ID: <20180410130002.GB29464@yu-chen.sh.intel.com>
References: <20180410101831.28530-1-yu.c.chen@intel.com>
 <1523358141.2753.194.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1523358141.2753.194.camel@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Bityutskiy, Artem" <artem.bityutskiy@intel.com>
Cc: "lenb@kernel.org" <lenb@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>
List-Id: linux-pm@vger.kernel.org

Hi,
On Tue, Apr 10, 2018 at 07:02:22PM +0800, Bityutskiy, Artem wrote:
> On Tue, 2018-04-10 at 18:18 +0800, Yu Chen wrote:
> > @@ -5076,6 +5084,15 @@ void cmdline(int argc, char **argv)
> >                         print_version();
> >                         exit(0);
> >                         break;
> > +               case 'x':
> > +                       {
> > +                               unsigned int loops = strtod(optarg, NULL);
> 
> It would make sense to error out here if you get a value <= 0.
> 
OK.
> > +
> > +                               if (loops % 2)
> > +                                       loops++;
> 
> What is this for?
> 
It was intended to make the number of loops even for simplify.
But after rethink about this, it might not be necessary. I'll
change it.

> > +                               max_loops = loops;
> 
> Is the "loops" variable really needed? Can you strtod directly to
> max_loops?
If the sanity check for user input is added then I think the local
variable is needed.

Thanks,
Yu
> 
> -- 
> Best Regards,
> Artem Bityutskiy
