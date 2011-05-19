From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH v2.6.38-rc7] Revert "libata:
	ahci_start_engine compliant to AHCI spec"
Date: Thu, 19 May 2011 23:32:16 +0200
Message-ID: <201105192332.16493.rjw__34513.7965785854$1305840753$gmane$org@sisk.pl>
References: <201105120025.34531.rjw@sisk.pl> <201105191219.27743.rjw@sisk.pl>
	<BANLkTin6+2obBm=+5Kd5Za1Lq-n4UQ-STw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <BANLkTin6+2obBm=+5Kd5Za1Lq-n4UQ-STw@mail.gmail.com>
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
> 
> Yes. I tested without reverting the patch that caused failure on E6410 (with
> same AHCI controller), The system is Ubuntu 11.04 with default 2.6.39-rc6
> kernel (guess this should be same kernel as yours before reverting the
> patch).
> 
> My system worked well with AC power cable plugging in and out at boot time,
> at runtime, and during "dd if=/dev/sda5 of=/dev/null ..".

What kind of disk did you use?  Mine is an Intel SSD.

> The config file I mentioned is those under /etc/ or other directories that
> is used to control the power management.

They aren't relevant to this issue.

> Did you test my patch? What it the result?

No, I didn't.  Unfortunately, I won't be able to do any tests on the affected
machine in the near future (most probably for the next two weeks or so).

Thanks,
Rafael
