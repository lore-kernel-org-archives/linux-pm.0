From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCHv2 0/4] cpufreq-dt, platform_data based proposal
Date: Sun, 19 Oct 2014 11:31:56 +0200
Message-ID: <20141019113156.4893cf27@free-electrons.com>
References: <CAKohpo=GiQHJ5eg=TkYAkzvsn=hTNTjSwmH20vitG2Z42zsoDA@mail.gmail.com>
	<6228666.uuRIPi9Yy4@vostro.rjw.lan>
	<CAKohpokbTQKzz3jt7dkEnD-cziAk4+a8CcQMPNuyzAVMeMfS1g@mail.gmail.com>
	<1951683.rC8DQ3mkM4@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1951683.rC8DQ3mkM4@vostro.rjw.lan>
Sender: linux-arm-msm-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Shawn Guo <shawn.guo@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Sachin Kamat <spk.linux@gmail.com>, Thomas Abraham <thomas.ab@samsung.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, "pramod.gurav@smartplayin.com" <pramod.gurav@smartplayin.com>, Rob Herring <rob.herring@linaro.org>, Mike Turquette <mike.turquette@linaro.org>, Gregory Clement <gregory.clement@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>
List-Id: linux-pm@vger.kernel.org

Dear Rafael J. Wysocki,

On Sun, 12 Oct 2014 22:25:02 +0200, Rafael J. Wysocki wrote:

> Thomas, care to rebase the v2 on top of the current Linus' tree and
> resend?

I've just resent the patches. See:

  https://patchwork.kernel.org/patch/5100691/
  https://patchwork.kernel.org/patch/5100731/
  https://patchwork.kernel.org/patch/5100711/

There are only 3 patches in this version, compared to four in the
previous version, because one of the patch touches
arch/arm/mach-mvebu/, and should therefore go through the mvebu
maintainers.

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
