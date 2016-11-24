From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v4] cpufreq: conservative: Decrease frequency faster when the update deferred
Date: Thu, 24 Nov 2016 02:21:30 +0100
Message-ID: <2889674.NcZ1F9SjeT@vostro.rjw.lan>
References: <e7710ffa-9012-13d1-5f05-7b6fc6032a9b@semaphore.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:61504 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934630AbcKXBNo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Nov 2016 20:13:44 -0500
In-Reply-To: <e7710ffa-9012-13d1-5f05-7b6fc6032a9b@semaphore.gr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stratos Karafotis <stratosk@semaphore.gr>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Wednesday, November 16, 2016 07:26:29 PM Stratos Karafotis wrote:
> Conservative governor changes the CPU frequency in steps.
> That means that if a CPU runs at max frequency, it will need several
> sampling periods to return to min frequency when the workload
> is finished.
> 
> If the update function that calculates the load and target frequency
> is deferred, the governor might need even more time to decrease the
> frequency.
> 
> This may have impact to power consumption and after all conservative
> should decrease the frequency if there is no workload at every sampling
> rate.
> 
> To resolve the above issue calculate the number of sampling periods
> that the update is deferred. Considering that for each sampling period
> conservative should drop the frequency by a freq_step because the
> CPU was idle apply the proper subtraction to requested frequency.
> 
> Below, the kernel trace with and without this patch. First an
> intensive workload is applied on a specific CPU. Then the workload
> is removed and the CPU goes to idle.
> 
> WITHOUT
> 
>      <idle>-0     [007] dN..   620.329153: cpu_idle: state=4294967295 cpu_id=7
> kworker/7:2-556   [007] ....   620.350857: cpu_frequency: state=1700000 cpu_id=7
> kworker/7:2-556   [007] ....   620.370856: cpu_frequency: state=1900000 cpu_id=7
> kworker/7:2-556   [007] ....   620.390854: cpu_frequency: state=2100000 cpu_id=7
> kworker/7:2-556   [007] ....   620.411853: cpu_frequency: state=2200000 cpu_id=7
> kworker/7:2-556   [007] ....   620.432854: cpu_frequency: state=2400000 cpu_id=7
> kworker/7:2-556   [007] ....   620.453854: cpu_frequency: state=2600000 cpu_id=7
> kworker/7:2-556   [007] ....   620.494856: cpu_frequency: state=2900000 cpu_id=7
> kworker/7:2-556   [007] ....   620.515856: cpu_frequency: state=3100000 cpu_id=7
> kworker/7:2-556   [007] ....   620.536858: cpu_frequency: state=3300000 cpu_id=7
> kworker/7:2-556   [007] ....   620.557857: cpu_frequency: state=3401000 cpu_id=7
>      <idle>-0     [007] d...   669.591363: cpu_idle: state=4 cpu_id=7
>      <idle>-0     [007] d...   669.591939: cpu_idle: state=4294967295 cpu_id=7
>      <idle>-0     [007] d...   669.591980: cpu_idle: state=4 cpu_id=7
>      <idle>-0     [007] dN..   669.591989: cpu_idle: state=4294967295 cpu_id=7
> ...
>      <idle>-0     [007] d...   670.201224: cpu_idle: state=4 cpu_id=7
>      <idle>-0     [007] d...   670.221975: cpu_idle: state=4294967295 cpu_id=7
> kworker/7:2-556   [007] ....   670.222016: cpu_frequency: state=3300000 cpu_id=7
>      <idle>-0     [007] d...   670.222026: cpu_idle: state=4 cpu_id=7
>      <idle>-0     [007] d...   670.234964: cpu_idle: state=4294967295 cpu_id=7
> ...
>      <idle>-0     [007] d...   670.801251: cpu_idle: state=4 cpu_id=7
>      <idle>-0     [007] d...   671.236046: cpu_idle: state=4294967295 cpu_id=7
> kworker/7:2-556   [007] ....   671.236073: cpu_frequency: state=3100000 cpu_id=7
>      <idle>-0     [007] d...   671.236112: cpu_idle: state=4 cpu_id=7
>      <idle>-0     [007] d...   671.393437: cpu_idle: state=4294967295 cpu_id=7
> ...
>      <idle>-0     [007] d...   671.401277: cpu_idle: state=4 cpu_id=7
>      <idle>-0     [007] d...   671.404083: cpu_idle: state=4294967295 cpu_id=7
> kworker/7:2-556   [007] ....   671.404111: cpu_frequency: state=2900000 cpu_id=7
>      <idle>-0     [007] d...   671.404125: cpu_idle: state=4 cpu_id=7
>      <idle>-0     [007] d...   671.404974: cpu_idle: state=4294967295 cpu_id=7
> ...
>      <idle>-0     [007] d...   671.501180: cpu_idle: state=4 cpu_id=7
>      <idle>-0     [007] d...   671.995414: cpu_idle: state=4294967295 cpu_id=7
> kworker/7:2-556   [007] ....   671.995459: cpu_frequency: state=2800000 cpu_id=7
>      <idle>-0     [007] d...   671.995469: cpu_idle: state=4 cpu_id=7
>      <idle>-0     [007] d...   671.996287: cpu_idle: state=4294967295 cpu_id=7
> ...
>      <idle>-0     [007] d...   672.001305: cpu_idle: state=4 cpu_id=7
>      <idle>-0     [007] d...   672.078374: cpu_idle: state=4294967295 cpu_id=7
> kworker/7:2-556   [007] ....   672.078410: cpu_frequency: state=2600000 cpu_id=7
>      <idle>-0     [007] d...   672.078419: cpu_idle: state=4 cpu_id=7
>      <idle>-0     [007] d...   672.158020: cpu_idle: state=4294967295 cpu_id=7
> kworker/7:2-556   [007] ....   672.158040: cpu_frequency: state=2400000 cpu_id=7
>      <idle>-0     [007] d...   672.158044: cpu_idle: state=4 cpu_id=7
>      <idle>-0     [007] d...   672.160038: cpu_idle: state=4294967295 cpu_id=7
> ...
>      <idle>-0     [007] d...   672.234557: cpu_idle: state=4 cpu_id=7
>      <idle>-0     [007] d...   672.237121: cpu_idle: state=4294967295 cpu_id=7
> kworker/7:2-556   [007] ....   672.237174: cpu_frequency: state=2100000 cpu_id=7
>      <idle>-0     [007] d...   672.237186: cpu_idle: state=4 cpu_id=7
>      <idle>-0     [007] d...   672.237778: cpu_idle: state=4294967295 cpu_id=7
> ...
>      <idle>-0     [007] d...   672.267902: cpu_idle: state=4 cpu_id=7
>      <idle>-0     [007] d...   672.269860: cpu_idle: state=4294967295 cpu_id=7
> kworker/7:2-556   [007] ....   672.269906: cpu_frequency: state=1900000 cpu_id=7
>      <idle>-0     [007] d...   672.269914: cpu_idle: state=4 cpu_id=7
>      <idle>-0     [007] d...   672.271902: cpu_idle: state=4294967295 cpu_id=7
> ...
>      <idle>-0     [007] d...   672.751342: cpu_idle: state=4 cpu_id=7
>      <idle>-0     [007] d...   672.823056: cpu_idle: state=4294967295 cpu_id=7
> kworker/7:2-556   [007] ....   672.823095: cpu_frequency: state=1600000 cpu_id=7
> 
> WITH
> 
>      <idle>-0     [007] dN..  4380.928009: cpu_idle: state=4294967295 cpu_id=7
> kworker/7:2-399   [007] ....  4380.949767: cpu_frequency: state=2000000 cpu_id=7
> kworker/7:2-399   [007] ....  4380.969765: cpu_frequency: state=2200000 cpu_id=7
> kworker/7:2-399   [007] ....  4381.009766: cpu_frequency: state=2500000 cpu_id=7
> kworker/7:2-399   [007] ....  4381.029767: cpu_frequency: state=2600000 cpu_id=7
> kworker/7:2-399   [007] ....  4381.049769: cpu_frequency: state=2800000 cpu_id=7
> kworker/7:2-399   [007] ....  4381.069769: cpu_frequency: state=3000000 cpu_id=7
> kworker/7:2-399   [007] ....  4381.089771: cpu_frequency: state=3100000 cpu_id=7
> kworker/7:2-399   [007] ....  4381.109772: cpu_frequency: state=3400000 cpu_id=7
> kworker/7:2-399   [007] ....  4381.129773: cpu_frequency: state=3401000 cpu_id=7
>      <idle>-0     [007] d...  4428.226159: cpu_idle: state=1 cpu_id=7
>      <idle>-0     [007] d...  4428.226176: cpu_idle: state=4294967295 cpu_id=7
>      <idle>-0     [007] d...  4428.226181: cpu_idle: state=4 cpu_id=7
>      <idle>-0     [007] d...  4428.227177: cpu_idle: state=4294967295 cpu_id=7
> ...
>      <idle>-0     [007] d...  4428.551640: cpu_idle: state=4 cpu_id=7
>      <idle>-0     [007] d...  4428.649239: cpu_idle: state=4294967295 cpu_id=7
> kworker/7:2-399   [007] ....  4428.649268: cpu_frequency: state=2800000 cpu_id=7
>      <idle>-0     [007] d...  4428.649278: cpu_idle: state=4 cpu_id=7
>      <idle>-0     [007] d...  4428.689856: cpu_idle: state=4294967295 cpu_id=7
> ...
>      <idle>-0     [007] d...  4428.799542: cpu_idle: state=4 cpu_id=7
>      <idle>-0     [007] d...  4428.801683: cpu_idle: state=4294967295 cpu_id=7
> kworker/7:2-399   [007] ....  4428.801748: cpu_frequency: state=1700000 cpu_id=7
>      <idle>-0     [007] d...  4428.801761: cpu_idle: state=4 cpu_id=7
>      <idle>-0     [007] d...  4428.806545: cpu_idle: state=4294967295 cpu_id=7
> ...
>      <idle>-0     [007] d...  4429.051880: cpu_idle: state=4 cpu_id=7
>      <idle>-0     [007] d...  4429.086240: cpu_idle: state=4294967295 cpu_id=7
> kworker/7:2-399   [007] ....  4429.086293: cpu_frequency: state=1600000 cpu_id=7
> 
> Without the patch the CPU dropped to min frequency after 3.2s
> With the patch applied the CPU dropped to min frequency after 0.86s
> 
> Signed-off-by: Stratos Karafotis <stratosk@semaphore.gr>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied.

Thanks,
Rafael

