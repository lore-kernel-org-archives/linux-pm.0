From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH v2.6.38-rc7] Revert "libata:
	ahci_start_engine compliant to AHCI spec"
Date: Sun, 15 May 2011 11:25:19 +0200
Message-ID: <201105151125.19614.rjw__15918.9353966669$1305451603$gmane$org@sisk.pl>
References: <201105120025.34531.rjw@sisk.pl>
	<20110514102804.GB23665@htj.dyndns.org>
	<BANLkTik1nFKX1Eyov_o0Xd0rr01Si5hSqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <BANLkTik1nFKX1Eyov_o0Xd0rr01Si5hSqA@mail.gmail.com>
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
Cc: Michael Leun <lkml20100708@newton.leun.net>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Tejun Heo <tj@kernel.org>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, Jeff Garzik <jgarzik@pobox.com>
List-Id: linux-pm@vger.kernel.org

On Sunday, May 15, 2011, Jian Peng wrote:
> Hi, Michael/Rafael/Gu,
> 
> Could you help me understand the testing environme? I like to reproduce it
> if it is possible and debug it. The host controller this patch dealing with
> is not used on PC so my testing environment is quite different.

Well, the system I can reproduce it on is a production one, so I can't
really test too much on it.  What exactly would you like to do?

Rafael
