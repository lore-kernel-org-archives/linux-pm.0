From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] powercap: add suspend and resume mechanism for SOC power limit
Date: Wed, 10 Jan 2018 01:21:22 +0100
Message-ID: <CAJZ5v0hr96bQZmfP3w0Kh2fGy9PxeU8gQRpHiHKtj9HNifRcVw@mail.gmail.com>
References: <1515486310-20330-1-git-send-email-xinx.sun@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1515486310-20330-1-git-send-email-xinx.sun@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: xinx.sun@intel.com
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, zhen.han@intel.com, chaox.m.wang@intel.com, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Jan 9, 2018 at 9:25 AM,  <xinx.sun@intel.com> wrote:
> From: Zhen Han <zhen.han@intel.com>
>
> PL1 and PL2 could be throlled or de-throttled by
> Thermal management to control SOC temperature.
> However, currently, their value will be reset to default value
> after once system suspend and resume.
> Add pm_notifier to save PL1, PL2 before system suspect and restore
> PL1, PL2 after system resume.
>
> Signed-off-by: Sun Xinx <xinx.sun@intel.com>

There is a formal issue here.

We need a Signed-off-by: tag from Zhen Han too.

Thanks,
Rafael
