From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] pci: Fix a possible sleep-in-atomic bug in
 pci_set_power_state
Date: Wed, 11 Oct 2017 16:33:24 +0300
Message-ID: <20171011133324.b5xnlmj5uhme2ibt@mwanda>
References: <1507536980-9345-1-git-send-email-baijiaju1990@163.com>
 <20171009171517.GL25517@bhelgaas-glaptop.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
In-Reply-To: <20171009171517.GL25517@bhelgaas-glaptop.roam.corp.google.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: devel@driverdev.osuosl.org, simon@nikanor.nu, scott@matheina.com, airlied@linux.ie, gregkh@linuxfoundation.org, linux-pm@vger.kernel.org, dan.a.cashman@gmail.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, tvboxspy@gmail.com, Jia-Ju Bai <baijiaju1990@163.com>, patrik.r.jakobsson@gmail.com, linux-pci@vger.kernel.org, bhelgaas@google.com, golubev.mikhail@gmail.com, forest@alittletooquiet.net
List-Id: linux-pm@vger.kernel.org

On Mon, Oct 09, 2017 at 12:15:17PM -0500, Bjorn Helgaas wrote:
> I assume it's easy to produce an actual failure here?  Why haven't we
> seen bug reports about this?

The bug was detected with static analysis.  You have to enable a debug
feature in the .config if you want sleeping with spinlock held warnings.
Otherwise you'd have to hit the deadlock and you have to be pretty
unlucky to hit it so these bugs sometimes do go unreported for a long
time.

regards,
dan carpenter
