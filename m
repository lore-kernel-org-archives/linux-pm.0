From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] opp: convert dev_warn() to dev_dbg() for duplicate OPPs
Date: Fri, 21 Nov 2014 16:58:47 +0100
Message-ID: <5171628.FRGslOuEb6@vostro.rjw.lan>
References: <7017fa592bdaf73c260ad001a2b7abdc8d14f08a.1416211616.git.viresh.kumar@linaro.org> <1714555.tu97zMrOn0@vostro.rjw.lan> <CAKohpoknu=V_wscVPWLdZO8xEGY6CVMNXuP4F76GNABnm9K4dQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:50295 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1758399AbaKUPhi (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 21 Nov 2014 10:37:38 -0500
In-Reply-To: <CAKohpoknu=V_wscVPWLdZO8xEGY6CVMNXuP4F76GNABnm9K4dQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Stefan Wahren <stefan.wahren@i2se.com>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Nishanth Menon <nm@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Wednesday, November 19, 2014 01:16:24 PM Viresh Kumar wrote:
> On 19 November 2014 02:21, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > On Tuesday, November 18, 2014 08:38:14 AM Viresh Kumar wrote:
> 
> >> We are allowing addition of duplicate OPPs as a standard thing right now
> >> as cpufreq drivers don't get rid of the OPPs they create with DT. So, that
> >> shouldn't complain, isn't it ?
> >
> > Is cpufreq the only user of OPP?  I thought there were other users, so what
> > about them?
> 
> Probably of CPU OPPs, but I am not sure. Obviously dev OPPs can be used
> by others.
> 
> > I'm not sure about that.  If they aren't useful for anything after
> > that, what's the benefit of keeping them around?
> 
> I don't think they are of any use once the driver is gone, unless the driver is
> inserted again.
> 
> So, this is what we can do to distinguish DT OPPs with other dynamic ones:
> 
> diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
> index 490e9db..7e25f01 100644
> --- a/drivers/base/power/opp.c
> +++ b/drivers/base/power/opp.c
> @@ -49,6 +49,7 @@
>   *             are protected by the dev_opp_list_lock for integrity.
>   *             IMPORTANT: the opp nodes should be maintained in increasing
>   *             order.
> + * @from_dt:   created from static DT entries.

What about @dynamic instead of @from_dt?  That may apply to more use cases if
need be.

>   * @available: true/false - marks if this OPP as available or not
>   * @rate:      Frequency in hertz
>   * @u_volt:    Nominal voltage in microvolts corresponding to this OPP
> @@ -61,6 +62,7 @@ struct dev_pm_opp {
>         struct list_head node;
> 
>         bool available;
> +       bool from_dt;
>         unsigned long rate;
>         unsigned long u_volt;
> 
> 
> 
> Does this look fine? I can then write of_free_opp_table(), opposite of
> of_init_opp_table().
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
