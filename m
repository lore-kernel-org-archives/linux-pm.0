From: Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Subject: Re: [PATCH v6 0/8] Add support for Tegra Activity Monitor
Date: Wed, 18 Mar 2015 07:27:19 +0100
Message-ID: <CAAObsKDWuGatDaX2a8AqXDMayd0uJAUCLLdRYUmef1Oh=kvd3g@mail.gmail.com>
References: <78905871.274971426655422042.JavaMail.weblogic@epmlwas07d>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <78905871.274971426655422042.JavaMail.weblogic@epmlwas07d>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: MyungJoo Ham <myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mikko Perttunen <mikko.perttunen-/1wQRMveznE@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, =?UTF-8?B?67CV6rK966+8?= <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Peter De Schrijver <pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Prashant Gaikwad <pgaikwad-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+WeqIh2JisoIxyg@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 18 March 2015 at 06:10, MyungJoo Ham <myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> wrote:
>> Hello,
>>
>> something happened during the last cycle and an old version of the devfreq
>> driver was merged.
>>
>> This thread contains patches that bring it up to date to the last submitted
>> version and also incorporates the feedback that that version received, plus
>> some other small fixes and improvements that came up during rebase and
>> testing.
>>
>> These patches implement support for setting the rate of the EMC clock based on
>> stats collected from the ACTMON, a piece of hw in the Tegra124 that counts
>> memory accesses (among others).
>>
>> It depends on the following in-flight patches:
>>
>> * EMC driver: http://thread.gmane.org/gmane.linux.kernel/1907035
>> * CPUFreq driver: http://thread.gmane.org/gmane.linux.kernel/1897078
>>
>> I have pushed a branch here for testing:
>>
>> http://cgit.collabora.com/git/user/tomeu/linux.git/log/?h=actmon-v6
>>
>> Regards,
>>
>> Tomeu
>>
>> Tomeu Vizoso (8):
>>   of: Add binding for NVIDIA Tegra ACTMON node
>>   PM / devfreq: tegra: Update to v5 of the submitted patches
>>   clk: tegra: Have EMC clock implement determine_rate()
>>   PM / devfreq: tegra: Use clock rate constraints
>>   PM / devfreq: tegra: remove operating-points
>>   PM / devfreq: tegra: Set drvdata before enabling the irq
>>   PM / devfreq: tegra: Enable interrupts after resuming the devfreq
>>     monitor
>>   ARM: tegra: Add Tegra124 ACTMON support
>
> Acked-by: MyungJoo Ham <myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> for all PM / devfreq patches (2, 4, 5, 6, 7)
> And merged in for-rc tree with a little modification.

Thanks. Though that's fine with me, I was wondering if Mikko or
Alexandre would have any comments on the changes, even if they are
small regarding what they already reviewed.

> In the patch 2/8, I would like to add "const" in Line 748.
> Would it be fine with you?

Yes, thanks, that's fine.

Regards,

Tomeu

> (You may look at: https://git.kernel.org/cgit/linux/kernel/git/mzx/devfreq.git/log/?h=for-rc )
>
>
> The diff after applying all 2/8 to 7/8 will be:
>
> diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
> index 0d1edd5..8e633a6 100644
> --- a/drivers/devfreq/tegra-devfreq.c
> +++ b/drivers/devfreq/tegra-devfreq.c
> @@ -740,7 +740,7 @@ static int tegra_devfreq_remove(struct platform_device *pdev)
>         return 0;
>  }
>
> -static struct of_device_id tegra_devfreq_of_match[] = {
> +static const struct of_device_id tegra_devfreq_of_match[] = {
>         { .compatible = "nvidia,tegra124-actmon" },
>         { },
>  };
>
>
>>
>>  .../devicetree/bindings/arm/tegra/actmon.txt       |  28 ++
>>  arch/arm/boot/dts/tegra124.dtsi                    |  11 +
>>  drivers/clk/tegra/clk-emc.c                        |  19 +-
>>  drivers/devfreq/tegra-devfreq.c                    | 480 +++++++++++----------
>>  4 files changed, 316 insertions(+), 222 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/arm/tegra/actmon.txt
>>
>> --
>> 2.1.0
>>
