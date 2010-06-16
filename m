From: Jason Chagas <jason.chagas@gmail.com>
Subject: Re: RFC: /sys/power/policy_preference
Date: Wed, 16 Jun 2010 18:12:02 -0400
Message-ID: <AANLkTinVfSUnR5cAvNowtzg8WEgm0JroN1EiaWAd2iHB@mail.gmail.com>
References: <alpine.LFD.2.00.1006161659140.24913@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.1006161659140.24913@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linux Power Management List <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

> powersave (can sacrifice measurable performance)
> =A0 =A0 =A0 =A0scheduler: enable sched_smt_power_savings
> =A0 =A0 =A0 =A0cpuidle: enable all C-states, subject to QOS
> =A0 =A0 =A0 =A0ondemand: disable turbo mode, powersave_bias=3D10
> =A0 =A0 =A0 =A0msr_ia32_energy_perf_bias: 11 of 15
>

Do you have any pointers to info (or code) on how the different
C&P-states are selected within each level?

Thanks,

Jason
