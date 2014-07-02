From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 07/14] cpufreq: cpu0: OPPs can be populated at runtime
Date: Wed, 2 Jul 2014 07:33:01 +0530
Message-ID: <CAKohpomff9PGBzkZKXxctVSgNyPzWR_8fUn9xnKb-sC8jR=uvA@mail.gmail.com>
References: <cover.1404231535.git.viresh.kumar@linaro.org>
	<1ba7771e910084cd0820c19ca5994fe1b3d6451d.1404231535.git.viresh.kumar@linaro.org>
	<53B2F7C3.5060107@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <53B2F7C3.5060107@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Shawn Guo <shawn.guo@linaro.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arvind Chauhan <arvind.chauhan@arm.com>, linux-arm-msm@vger.kernel.org, Sachin Kamat <spk.linux@gmail.com>, Thomas P Abraham <thomas.ab@samsung.com>, Nishanth Menon <nm@ti.com>, Tomasz Figa <t.figa@samsung.com>
List-Id: linux-pm@vger.kernel.org

On 1 July 2014 23:32, Stephen Boyd <sboyd@codeaurora.org> wrote:
> Please update the binding as well to indicate that this property is now
> optional.

Does this look fine..

diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-cpu0.txt
b/Documentation/devicetree/bindings/cpufreq/cpufreq-cpu0.txt
index f055515..366690c 100644
--- a/Documentation/devicetree/bindings/cpufreq/cpufreq-cpu0.txt
+++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-cpu0.txt
@@ -8,10 +8,12 @@ Both required and optional properties listed below
must be defined
 under node /cpus/cpu@0.

 Required properties:
-- operating-points: Refer to Documentation/devicetree/bindings/power/opp.txt
-  for details
+- None

 Optional properties:
+- operating-points: Refer to
Documentation/devicetree/bindings/power/opp.txt for
+  details. OPPs *must* be supplied either via DT, i.e. this property, or
+  populated at runtime.
 - clock-latency: Specify the possible maximum transition latency for clock,
   in unit of nanoseconds.
 - voltage-tolerance: Specify the CPU voltage tolerance in percentage.
