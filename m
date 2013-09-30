From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 2/2] cpufreq: make return type of lock_policy_rwsem_{read|write}() as void
Date: Mon, 30 Sep 2013 20:28:21 +0200
Message-ID: <2382588.IckWbq3JRN@vostro.rjw.lan>
References: <075032be4fd288074b8f699d4f4ba0179518df6f.1379344038.git.viresh.kumar@linaro.org> <a257808b511a83f210ed699149ce87fef5db6236.1379344038.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <a257808b511a83f210ed699149ce87fef5db6236.1379344038.git.viresh.kumar@linaro.org>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: tixy@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, srivatsa.bhat@linux.vnet.ibm.com
List-Id: linux-pm@vger.kernel.org

On Monday, September 16, 2013 08:40:17 PM Viresh Kumar wrote:
> lock_policy_rwsem_{read|write}() currently has return type of int but it always
> return zero and hence its return type must be void instead. This patch makes its
> return type void and fixes all users of it as well.
> 
> Reported-by: Jon Medhurst<tixy@linaro.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

This doesn't apply to bleeding-edge for me any more after I have applied your
series of 44 patches to it.  Care to resend?

Rafael

