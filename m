From: Len Brown <lenb@kernel.org>
Subject: Re: RFC: /sys/power/policy_preference
Date: Thu, 17 Jun 2010 14:44:41 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1006171441160.4214@localhost.localdomain>
References: <alpine.LFD.2.00.1006161659140.24913@localhost.localdomain>
	<AANLkTinVfSUnR5cAvNowtzg8WEgm0JroN1EiaWAd2iHB@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1729434706-1276800281=:4214"
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <AANLkTinVfSUnR5cAvNowtzg8WEgm0JroN1EiaWAd2iHB@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jason Chagas <jason.chagas@gmail.com>
Cc: Linux Power Management List <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1729434706-1276800281=:4214
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by smtp1.linux-foundation.org id o5HJpspH018258

On Wed, 16 Jun 2010, Jason Chagas wrote:

> > powersave (can sacrifice measurable performance)
> > =A0 =A0 =A0 =A0scheduler: enable sched_smt_power_savings
> > =A0 =A0 =A0 =A0cpuidle: enable all C-states, subject to QOS
> > =A0 =A0 =A0 =A0ondemand: disable turbo mode, powersave_bias=3D10
> > =A0 =A0 =A0 =A0msr_ia32_energy_perf_bias: 11 of 15
> >
>=20
> Do you have any pointers to info (or code) on how the different
> C&P-states are selected within each level?

I'm not proposing any changes to how the cpuidle menu govenor
selects C-states, or how it obeys PM_QOS, except for 1 thing.

I am proposing that in "max_performance" mode that C-states
be disabled entirely, to avoid any state latency whatsoever.

thanks,
Len Brown, Intel Open Source Technology Center
--8323328-1729434706-1276800281=:4214
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit


--8323328-1729434706-1276800281=:4214--
