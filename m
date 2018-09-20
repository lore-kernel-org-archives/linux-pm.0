From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2] cpufreq: qcom-kryo: Fix section mismatch warning
Date: Thu, 20 Sep 2018 09:02:45 -0700
Message-ID: <20180920160245.f4afwfyyz3nd4xvn@vireshk-mac-ubuntu>
References: <20180919182247.1101-1-natechancellor@gmail.com>
 <CAKwvOdnW8p4Tj2n+Y4XyMMVdD7W90W4NTLkJHKhZ6604ah4fnw@mail.gmail.com>
 <20180919215039.mb7prmmfs5jek3aj@vireshk-mac-ubuntu>
 <20180919215418.y2jsrsj73vy3dudd@vireshk-mac-ubuntu>
 <CAJZ5v0ipkaudrv7W5VP1_e9LERF6DLZuw+HtTf2Si4p=pbv9bw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0ipkaudrv7W5VP1_e9LERF6DLZuw+HtTf2Si4p=pbv9bw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: ndesaulniers@google.com, natechancellor@gmail.com, ilia.lin@gmail.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 20-09-18, 00:45, Rafael J. Wysocki wrote:
> Because __init things go away at one point and calling them from the
> other sections is a bad idea.  OTOH, __exit things are simply not
> needed in built-in drivers and they are never there if the driver is
> built-in, so calling them from the other sections is a bad idea too.

I assumed that the driver is calling platform_driver_probe() and so probe() can
be marked __init. But it doesn't do that to make deferred probing work.

-- 
viresh
