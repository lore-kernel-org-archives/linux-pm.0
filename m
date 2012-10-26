From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [for-next PATCH] PM / devfreq: Add sysfs node to expose available frequencies
Date: Fri, 26 Oct 2012 02:22:51 +0200
Message-ID: <1775844.L5g0QF5oVv@vostro.rjw.lan>
References: <1351207963-30075-1-git-send-email-nm@ti.com> <1639482.oGax1ZB8vZ@vostro.rjw.lan> <20121026000321.GA4190@kahuna>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20121026000321.GA4190@kahuna>
Sender: linux-kernel-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-pm <linux-pm@vger.kernel.org>, Rajagopal Venkat <rajagopal.venkat@linaro.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Kevin Hilman <khilman@ti.com>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thursday, October 25, 2012 07:03:21 PM Nishanth Menon wrote:
> On 01:56-20121026, Rafael J. Wysocki wrote:
> > On Thursday, October 25, 2012 06:32:43 PM Nishanth Menon wrote:
> [..]
> > > +static ssize_t show_available_freqs(struct device *d,
> > > +				    struct device_attribute *attr,
> > > +				    char *buf)
> > > +{
> > > +	struct devfreq *df = to_devfreq(d);
> > > +	struct device *dev = df->dev.parent;
> > > +	struct opp *opp;
> > > +	ssize_t count = 0;
> > > +	unsigned long freq = 0;
> > > +
> > > +	rcu_read_lock();
> > > +	do {
> > > +		opp = opp_find_freq_ceil(dev, &freq);
> > > +		if (IS_ERR(opp))
> > > +			break;
> > > +
> > > +		count += sprintf(&buf[count], "%lu ", freq);
> > > +		freq++;
> > > +	} while (1);
> > > +	rcu_read_unlock();
> > > +	count += sprintf(&buf[count], "\n");
> > 
> > Care to avoid printing the tailing space?
> count -= count ? 1 : 0;

What about

if (count)
  count--;

instead?

> count += sprintf(&buf[count], "\n");
> should take care of empty list and the trailing space. Sounds reasonable?

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
