From: Vitaly Wool <vitalywool@gmail.com>
Subject: Re: subtle pm_runtime_put_sync race and sdio functions
Date: Thu, 27 Jan 2011 19:20:10 +0100
Message-ID: <AANLkTikH0aHQNzShAYQfPLPg4C_0HS_pWEqbJJ4aHZgm__45285.6514174075$1296152550$gmane$org@mail.gmail.com>
References: <Pine.LNX.4.44L0.1012212032590.11252-100000@netrider.rowland.org>
	<201012221329.40251.rjw@sisk.pl> <87k4hrtfcb.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <87k4hrtfcb.fsf@ti.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-mmc@vger.kernel.org, linux-wireless@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>, linux-pm@lists.linux-foundation.org, Ido Yariv <ido@wizery.com>
List-Id: linux-pm@vger.kernel.org

Hi Kevin,

> Therefore, what is ideally needed is the ability for A's suspend to
> simply call pm_runtime_suspend() so the subsystem can do the work.
> However, since runtime transitions are locked out by this time, that
> doesn't work. =A0IOW, what is needed is a way for a system suspend to say
> "please finish the runtime suspend that was already requested."
>
> What I've done to work around this in driver A is to manually check
> pm_runtime_suspended() and directly call the subsystem's runtime
> suspend/resume (patch below[1]. =A0NOTE, I've used the _noirq methods to
> ensure device A is available when device B needs it.)

suppose this driver runs on a platform that has runtime PM disabled.
How is it going to work then?

Thanks,
   Vitaly
