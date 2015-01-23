From: Lukasz Majewski <l.majewski@samsung.com>
Subject: Re: [PATCH v6 08/18] cpufreq: exynos: Use device tree to determine if
 cpufreq cooling should be registered
Date: Fri, 23 Jan 2015 14:57:44 +0100
Message-ID: <20150123145744.3dc47a47@amdc2363>
References: <1421666462-7606-1-git-send-email-l.majewski@samsung.com>
 <1422015260-14225-1-git-send-email-l.majewski@samsung.com>
 <CAKohpok1EacvJ3PCOZYnz81D3=P04apRp7VOxPFE1QxYF4Wydg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <CAKohpok1EacvJ3PCOZYnz81D3=P04apRp7VOxPFE1QxYF4Wydg@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, Kukjin Kim <kgene.kim@samsung.com>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Abhilash Kesavan <a.kesavan@samsung.com>, Kukjin Kim <kgene@kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>
List-Id: linux-pm@vger.kernel.org

Hi Viresh,

> On 23 January 2015 at 17:44, Lukasz Majewski <l.majewski@samsung.com>
> wrote:
> > +       cpus = of_find_node_by_path("/cpus");
> > +       if (!cpus) {
> > +               pr_err("failed to find cpus node\n");
> > +               return 0;
> > +       }
> > +
> > +       np = of_get_next_child(cpus, NULL);
> > +       if (!np) {
> > +               pr_err("failed to find cpus child node\n");
> > +               of_node_put(cpus);
> >                 return 0;
> > +       }
> 
> Why making it complex? Just get device node for cpu 0 and
> do cpu_dev->np.

Please pay a note about following problem:

Previously we got: cpu0: cpu@0 for all Exynos devices.

Now, however, cpu numbering has changed (due to GIC rework).
For example:

Exynos4412:
	cpus {
		cpu0: cpu@A00 {
			...
			#cooling-cells = <2>; /* min followed by max */
		};

		cpu@A01 {
		};

		cpu@A02 {
		};

		cpu@A03 {
		};
	}

Exynos 4210:
	cpus {
		cpu0: cpu@900 {
			#cooling-cells = <2>; /* min followed by max */
		};

		cpu@901 {
		};
	};

Exynos 5250:
	cpus {
		cpu0: cpu@0 {
			#cooling-cells = <2>; /* min followed by max */
		};

		cpu@1 {
		};
	};
	

As you can see different cpu@XXY nodes we have and simply calling cpu@0
won't work.


-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
