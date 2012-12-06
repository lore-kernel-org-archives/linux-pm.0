From: Ming Lei <ming.lei@canonical.com>
Subject: Re: Race condition between driver_probe_device and device_shutdown
Date: Thu, 6 Dec 2012 18:52:43 +0800
Message-ID: <CACVXFVPbpbb-PAJAweoLj8uec=KgoUKvybSey+R=L=oY16Ozbw@mail.gmail.com>
References: <20120524021429.GB12557@kroah.com>
	<Pine.LNX.4.44L0.1205241029260.1349-100000@iolanthe.rowland.org>
	<CACVXFVPu_nbVCVR_HTt9H764+4JKC3=GPyhsf8Lpsch4Fa=xqQ@mail.gmail.com>
	<CANeycqo8sFVeWVEeW3mdPPVRt35+kfkdUzenLB+YgNs4y-T7Cg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CANeycqo8sFVeWVEeW3mdPPVRt35+kfkdUzenLB+YgNs4y-T7Cg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wedson Almeida Filho <wedsonaf@gmail.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, Greg KH <gregkh@linuxfoundation.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Linux PM List <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Dec 6, 2012 at 5:11 PM, Wedson Almeida Filho <wedsonaf@gmail.com> wrote:
> [Sorry for taking so long to respond, after a week of silence I
> assumed I wouldn't get any responses, plus I had moved on to other
> things.]
>
> I happen to still have the logs, the relevant part is pasted at the end.
>
> Answering some of the questions: the driver is on the platform bus, in
> fact, it's drivers/usb/host/ehci-tegra.c; after seeing the oops below,
> I added printks when entering and exiting tegra_ehci_probe to try to
> understand it better.
>
> Note that in the log we see some thread entering tegra_ehci_probe, but
> nothing indicates that it has exited before we get the oops.

The commit d1c6c030fcec6f860d9bb6c632a3ebe62e28440b(driver core:
fix shutdown races with probe/remove(v3)) has been merged to v3.6, so
device_shutdown will wait for completing of probe.

Could you test kernel 3.6 or the latest kernel to see if the problem can be
reproduced?

Thanks,
--
Ming Lei
