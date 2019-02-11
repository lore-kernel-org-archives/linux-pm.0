From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 0/3] drivers: Frequency constraint infrastructure
Date: Mon, 11 Feb 2019 11:13:38 +0530
Message-ID: <20190211054338.nxw4dbs75wkqolr3@vireshk-i7>
References: <cover.1547197612.git.viresh.kumar@linaro.org>
 <CAJZ5v0gs3FnCgFS8rg7vwCeATJKfR+mfMVrpkTbM237XVhpDJQ@mail.gmail.com>
 <20190208090912.43aao5kny42iirum@vireshk-i7>
 <CAJZ5v0iE9tFt9Xs27EYcjv6N1KAq-LaAQnv=QBvnbNRpfwrWCg@mail.gmail.com>
 <20190208102346.ophy3eqhxjzaqsxr@vireshk-i7>
 <CAJZ5v0gNhmqY_oem9SZk2fEkOikmjTK3YfFRuOi8f=66GSgVuw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gNhmqY_oem9SZk2fEkOikmjTK3YfFRuOi8f=66GSgVuw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Viresh Kumar <vireshk@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Matthias Kaehlcke <mka@chromium.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 08-02-19, 11:35, Rafael J. Wysocki wrote:
> At least some of the underlying mechanics seem to be very similar.
> You have priority lists, addition and removal of requests etc.
> 
> Arguably, PM QoS may be regarded as a bit overly complicated, but
> maybe they both can use a common library underneath?
 
> As I said I like the idea of replacing cpufreq notifiers with
> something nicer, so if you can avoid doing almost-the-same-ting in two
> different frameworks, it would be fine by me.

Ok, will try to move to PM QoS. Thanks.

-- 
viresh
