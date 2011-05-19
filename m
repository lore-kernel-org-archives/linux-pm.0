From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH v2.6.38-rc7] Revert "libata:
	ahci_start_engine compliant to AHCI spec"
Date: Thu, 19 May 2011 12:19:27 +0200
Message-ID: <201105191219.27743.rjw__41054.568559821$1305800496$gmane$org@sisk.pl>
References: <201105120025.34531.rjw@sisk.pl>
	<BANLkTimZ9pe-FhkJYHTG1Jx8MUPrMHSFbA@mail.gmail.com>
	<BANLkTim9_1Xt8oE4awbCO1iKUW96YUOv_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <BANLkTim9_1Xt8oE4awbCO1iKUW96YUOv_A@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jian Peng <jipeng2005@gmail.com>
Cc: Valdis.Kletnieks@vt.edu, Michael Leun <lkml20100708@newton.leun.net>, LKML <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Tejun Heo <tj@kernel.org>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, Jeff Garzik <jgarzik@pobox.com>
List-Id: linux-pm@vger.kernel.org

On Thursday, May 19, 2011, Jian Peng wrote:
> Hi, Rafael,

Hi,

> I am using Dell E6410 with same AHCI host controller as your system, but
> could not reproduce the bug you found out (using Ubuntu 11.04 and 2.6.39-rc6
> kernel).

OK, do I think correctly you tested without the patch you sent previously?

> Do you know which config file I need change to perform this testing?

I'm not sure what you mean.  The kernel .config?

Rafael
