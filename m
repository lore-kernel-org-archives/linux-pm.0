From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCHv2 2/4] cpufreq: cpufreq-dt: extend with platform_data
Date: Wed, 10 Sep 2014 14:28:41 +0200
Message-ID: <20140910142841.17ae320a@free-electrons.com>
References: <CAKohpo=GiQHJ5eg=TkYAkzvsn=hTNTjSwmH20vitG2Z42zsoDA@mail.gmail.com>
	<1410350908-11316-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<1410350908-11316-3-git-send-email-thomas.petazzoni@free-electrons.com>
	<CAKohpokH4ZoM=+i3wW73o_Xf26ysBaXbNNzGUB0ofcc0EkK3WA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <CAKohpokH4ZoM=+i3wW73o_Xf26ysBaXbNNzGUB0ofcc0EkK3WA@mail.gmail.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Shawn Guo <shawn.guo@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Sachin Kamat <spk.linux@gmail.com>, Thomas Abraham <thomas.ab@samsung.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, "pramod.gurav@smartplayin.com" <pramod.gurav@smartplayin.com>, Rob Herring <rob.herring@linaro.org>, Mike Turquette <mike.turquette@linaro.org>, Gregory Clement <gregory.clement@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>
List-Id: linux-pm@vger.kernel.org

Dear Viresh Kumar,

On Wed, 10 Sep 2014 17:52:59 +0530, Viresh Kumar wrote:
> On 10 September 2014 17:38, Thomas Petazzoni
> <thomas.petazzoni@free-electrons.com> wrote:
> > +       dt_cpufreq_driver.driver_data = dev_get_platdata(&pdev->dev);
> 
> I don't think this is right. What if platform device's platform data
> is freed later?
> That's why its always better to duplicate that structure instead of playing with
> pointers.

Isn't the piece of code registering the platform_device supposed to
make sure that platform_data doesn't disappear? At least, in PATCH 3/4,
I'm using platform_device_register_data(), which does a kmemdup() of
the custom data being passed before assigning the struct
device->platform_data field.

But if you like, I can add one more memory copy :)

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
