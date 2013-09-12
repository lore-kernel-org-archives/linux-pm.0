From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: "cpufreq: fix serialization issues with freq change notifiers"
 breaks cpufreq too
Date: Thu, 12 Sep 2013 13:21:40 +0530
Message-ID: <CAKohpokJJOxKHhyqDRRZnp_Fwc2oXZcUR7KeMF_Zegoqpo_MqA@mail.gmail.com>
References: <Pine.LNX.4.64.1309091656200.6602@axis700.grange>
	<CAKohponZ+FnzqXYMbBzbun0-1iQMi2fS4syrEBC_MdF41vLCeA@mail.gmail.com>
	<Pine.LNX.4.64.1309101656150.16010@axis700.grange>
	<CAKohpomBBKLhNemVUpUHAftGhPJJe+ZB7T_9UYLD7LwpR1nK0g@mail.gmail.com>
	<Pine.LNX.4.64.1309101740120.16010@axis700.grange>
	<CAKohpomK7Y_6aLMA3B+hZrtgYq9U89ihgkbvYWA3BsKN3gJD3g@mail.gmail.com>
	<Pine.LNX.4.64.1309101853170.16010@axis700.grange>
	<CAKohpokaHU0V86DPB7nEQ8ndwu_mJ_x_Uz47XPHZeyAW3hcP_w@mail.gmail.com>
	<Pine.LNX.4.64.1309120938240.4632@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1309120938240.4632@axis700.grange>
Sender: cpufreq-owner@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Greg KH <greg@kroah.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, SH-Linux <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>
List-Id: linux-pm@vger.kernel.org

On 12 September 2013 13:17, Guennadi Liakhovetski <g.liakhovetski@gmx.de> wrote:
> Yes, they seem to fix my issues.

Great!!

> You probably aren't going to submit them
> in this form, instead, merge them with the original serialisation fix
> patch, right? So, you don't need my tested-by here. But feel free to cc me
> when you submit a fixed version.

I will add your tested-by as you have eventually test all three patch that I
would merge :)

Thanks for testing this..
