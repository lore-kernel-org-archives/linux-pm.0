From: Yu Chen <yu.c.chen@intel.com>
Subject: Re: [PATCH][v2] tools/power turbostat: if --max_loop, print for
 specific time of loops
Date: Wed, 11 Apr 2018 18:15:29 +0800
Message-ID: <20180411101529.GA12068@yu-chen.sh.intel.com>
References: <20180410145141.31166-1-yu.c.chen@intel.com>
 <1523438944.2753.207.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1523438944.2753.207.camel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Artem Bityutskiy <dedekind1@gmail.com>
Cc: Len Brown <lenb@kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, Apr 11, 2018 at 12:29:04PM +0300, Artem Bityutskiy wrote:
> On Tue, 2018-04-10 at 22:51 +0800, Yu Chen wrote:
> > +		case 't':
> > +			{
> > +				int loops = strtod(optarg, NULL);
> > +
> > +				if (loops <= 0) {
> > +					fprintf(outf, "loops %d should be positive number\n",
> > +						iterations);
> > +					exit(2);
> > +				}
> > +				iterations = loops;
> > +			}
> 
> What is the point of the additional {} scope and the 'loops' variable
> in it? You could use the 'iterations' variable directly and simplify
> the code.
Got your point, will change it.
> 
> Artem.
