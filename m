From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [RFC] the generic thermal layer enhancement
Date: Thu, 31 May 2012 14:13:11 +0800
Message-ID: <1338444791.1472.254.camel@rui.sh.intel.com>
References: <1338367742.1472.128.camel@rui.sh.intel.com>
	<1338367860.1472.129.camel@rui.sh.intel.com>
	<20120530103006.GA3261@besouro>
	<CAK44p20bjZfX-ur0V8hmSGzLDJ0cDLCTQ4LkHKQqSvfFbqyG+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <CAK44p20bjZfX-ur0V8hmSGzLDJ0cDLCTQ4LkHKQqSvfFbqyG+w@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Amit Kachhap <amit.kachhap@linaro.org>
Cc: Jean Delvare <jdelvare@suse.com>, "Brown, Len" <len.brown@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

> >> > G5. unify active cooling and passive cooling code
> >> >
> >> >     If G4 and G5 are resolved, a new problem to me is that there is no
> >> >     difference between passive cooling and active cooling except the
> >> >     cooling policy.
> >
> > OK...
> >
> >> >     Then we can share the same code for both active and passive cooling.
> >> >     maybe something like:
> >> >
> >> >     case THERMAL_TRIP_ACTIVE:
> >> >     case THERMAL_TRIP_PASSIVE:
> >> >          ...
> >> >          tz->ops->get_trend();
> >
> > Would the get_trend take into account if we are cooling with active or passive
> > cooling device?
> >
> >> >          if (trend == HEATING)
> >> >                  cdev->ops->set_cur_state(cdev, cur_state++);
> >> >          else if (trend == COOLING)
> >> >                  cdev->ops->set_cur_state(cdev, cur_state--);
> >> >          break;
> >
> > I believe we should have something for temperature stabilization there as well.
> I also agree that thermal stablization is important. I have observed
> that too much state change is happening around the trip point. But yes
>  the trend callback may take care of this and set the COOLING trend
> different from HEATING trend.

that's why Matthew and I are asking you to try to fit into the current
passive cooling implementation first, as the current algorithm is really
a good one, if you can make use of it.
.get_trend() is just a backup for this.

thanks,
rui
