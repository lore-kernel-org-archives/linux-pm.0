From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/2] cpufreq: cpu0: Extend support beyond CPU0
Date: Mon, 30 Jun 2014 13:27:52 +0530
Message-ID: <CAKohpo=dgSW551yzqjAV2_opw_4naqFEWpwUz9ktkGgR5vCBZA@mail.gmail.com>
References: <cover.1403684824.git.viresh.kumar@linaro.org>
	<e9c0eef07745e561b9d12dcb50c3e2f7eb3e8880.1403684824.git.viresh.kumar@linaro.org>
	<53AB1CC1.4010907@codeaurora.org>
	<CAKohpo=Q7eWNwcK6KF9_U-zD0g=96QHW9hiQupLpV5GqoWE+mA@mail.gmail.com>
	<53ACB568.4000903@codeaurora.org>
	<20140627015354.32686.83046@quantum>
	<CAKohponvN3rAvJrfi4TojFcq5gq7r2oNE4Q0_NtwBHmEZ8waBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f172.google.com ([209.85.214.172]:41951 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752672AbaF3H5x (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 30 Jun 2014 03:57:53 -0400
Received: by mail-ob0-f172.google.com with SMTP id uy5so8393123obc.17
        for <linux-pm@vger.kernel.org>; Mon, 30 Jun 2014 00:57:53 -0700 (PDT)
In-Reply-To: <CAKohponvN3rAvJrfi4TojFcq5gq7r2oNE4Q0_NtwBHmEZ8waBA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>, Rob Herring <rob.herring@linaro.org>, Grant Likely <grant.likely@linaro.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Shawn Guo <shawn.guo@linaro.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arvind Chauhan <arvind.chauhan@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-arm-msm@vger.kernel.org, Sachin Kamat <spk.linux@gmail.com>, Thomas P Abraham <thomas.ab@samsung.com>, Nishanth Menon <nm@ti.com>, Tomasz Figa <t.figa@samsung.com>, Mark Brown <broonie@kernel.org>, Mark Rutland <Mark.Rutland@arm.com>

On 27 June 2014 07:45, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 27 June 2014 07:23, Mike Turquette <mturquette@linaro.org> wrote:
>>> but it isn't future-proof if/when the clock framework starts returning
>>> dynamically allocated clock pointers for each clk_get() invocation.
>>> Maybe we need a function in the common clock framework that tells us if
>>> the clocks are the same either via DT or by taking two clock pointers?
>>
>> I looked through the patch briefly and did not see why we would need to
>> do this. Any hint?
>
> We want to know which CPUs are sharing clock line, so that we can
> fill affected-cpus field of cpufreq core.

What about comparing "clocks" property in cpu DT nodes?

@Rob/Grant: I tried looking for an existing routine to do that, but couldn't
find it. And so wrote one.

I am not good at DT stuff and so I do hope there would be few correction
required here. Let me know if this can be added to drivers/of/base.c :

+/**
+ * of_property_match - Match property in two nodes
+ * @np1, np2: Nodes to match
+ * @list_name: property to match
+ *
+ * Returns 1 on match, 0 on no match, and error for missing property.
+ */
+static int of_property_match(const struct device_node *np1,
+                             const struct device_node *np2,
+                             const char *list_name)
+{
+       const __be32 *list1, *list2, *list1_end;
+       int size1, size2;
+       phandle phandle1, phandle2;
+
+       /* Retrieve the list property */
+       list1 = of_get_property(np1, list_name, &size1);
+       if (!list1)
+               return -ENOENT;
+
+       list2 = of_get_property(np2, list_name, &size2);
+       if (!list2)
+               return -ENOENT;
+
+       if (size1 != size2)
+               return 0;
+
+       list1_end = list1 + size1 / sizeof(*list1);
+
+       /* Loop over the phandles */
+       while (list1 < list1_end) {
+               phandle1 = be32_to_cpup(list1++);
+               phandle2 = be32_to_cpup(list2++);
+
+               if (phandle1 != phandle2)
+                       return 0;
+       }
+
+       return 1;
+}

@Stephen: I have updated my tree with this change, in case you wanna
try.
