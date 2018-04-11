From: Artem Bityutskiy <dedekind1@gmail.com>
Subject: Re: [PATCH][v2] tools/power turbostat: if --max_loop, print for
 specific time of loops
Date: Wed, 11 Apr 2018 12:29:04 +0300
Message-ID: <1523438944.2753.207.camel@gmail.com>
References: <20180410145141.31166-1-yu.c.chen@intel.com>
Reply-To: dedekind1@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180410145141.31166-1-yu.c.chen@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yu Chen <yu.c.chen@intel.com>, Len Brown <lenb@kernel.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, 2018-04-10 at 22:51 +0800, Yu Chen wrote:
> +		case 't':
> +			{
> +				int loops = strtod(optarg, NULL);
> +
> +				if (loops <= 0) {
> +					fprintf(outf, "loops %d should be positive number\n",
> +						iterations);
> +					exit(2);
> +				}
> +				iterations = loops;
> +			}

What is the point of the additional {} scope and the 'loops' variable
in it? You could use the 'iterations' variable directly and simplify
the code.

Artem.
