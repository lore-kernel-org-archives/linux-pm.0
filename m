From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] power: domain: no need to check return value of debugfs_create functions
Date: Thu, 24 Jan 2019 11:42:20 +0100
Message-ID: <4998515.YAP7gzz4HU@aspire.rjw.lan>
References: <20190122152151.16139-6-gregkh@linuxfoundation.org> <CAPDyKFrLn=gTz80sw5f4W=0W86p9Ktj3Zo1b+4R-YZd-sbRNzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFrLn=gTz80sw5f4W=0W86p9Ktj3Zo1b+4R-YZd-sbRNzA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Kevin Hilman <khilman@kernel.org>, Len Brown <len.brown@intel.com>, Linux PM <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday, January 23, 2019 1:49:00 PM CET Ulf Hansson wrote:
> On Tue, 22 Jan 2019 at 16:23, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > When calling debugfs functions, there is no need to ever check the
> > return value.  The function can work or not, but the code logic should
> > never do something different based on this.
> >
> > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > Cc: Kevin Hilman <khilman@kernel.org>
> > Cc: Ulf Hansson <ulf.hansson@linaro.org>
> > Cc: Len Brown <len.brown@intel.com>
> > Cc: linux-pm@vger.kernel.org
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Patch applied, thanks!
