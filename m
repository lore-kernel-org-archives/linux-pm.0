From: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Subject: Re: [PATCH V3 0/5] PM / OPP: opp-supported-hw and <prop>-name bindings
Date: Tue, 24 Nov 2015 00:02:08 +0100
Message-ID: <18133487.DZlYslOPCi@vostro.rjw.lan>
References: <cover.1447209519.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1447209519.git.viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, nm-l0cyMroinI0@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Wednesday, November 11, 2015 08:10:53 AM Viresh Kumar wrote:
> Hi Rafael,
> 
> Rob only needs to Ack the modified 2/5 patch and then you can safely
> apply this series.
> 
> The first patch enables us to select only a subset of OPPs from the
> bigger table, based on what version of the hardware we are running on.
> 
> The second one enables us to select slightly different values for
> multiple properties, based on what kind of hardware they are running on.
> 
> The third one removes an (unused) binding, which is replaced by the
> second patch with a better solution.
> 
> The fourth patch is based on what Stephen suggested (and then reviewed)
> in the earlier series, and the 5th one updates the existing users of
> these bindings for it.
> 
> V2->V3:
> - dropped turbo/suspend named properties
> - Applied all the Acks
> 
> Viresh Kumar (5):
>   PM / OPP: Add "opp-supported-hw" binding
>   PM / OPP: Add {opp-microvolt|opp-microamp}-<name> binding
>   PM / OPP: Remove 'operating-points-names' binding
>   PM / OPP: Rename OPP nodes as opp@<opp-hz>
>   ARM: dts: exynos4412: Rename OPP nodes as opp@<opp-hz>
> 
>  Documentation/devicetree/bindings/opp/opp.txt | 132 ++++++++++++++++++--------
>  arch/arm/boot/dts/exynos4412.dtsi             |  28 +++---
>  2 files changed, 107 insertions(+), 53 deletions(-)

I'm tentatively queuing this series up for 4.5, but ACKs from Rob are
still missing for patches [2,5/5] AFAICS.

Thanks,
Rafael

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
